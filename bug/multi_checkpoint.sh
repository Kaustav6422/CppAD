#! /bin/bash -e
# -----------------------------------------------------------------------------
# CppAD: C++ Algorithmic Differentiation: Copyright (C) 2003-18 Bradley M. Bell
#
# CppAD is distributed under the terms of the
#              Eclipse Public License Version 2.0.
#
# This Source Code may also be made available under the following
# Secondary License when the conditions for such availability set forth
# in the Eclipse Public License, Version 2.0 are satisfied:
#       GNU General Public License, Version 2.0 or later.
# -----------------------------------------------------------------------------
name=`echo $0 | sed -e 's|.*/||' -e 's|\..*||'`
if [ "$0" != "bug/$name.sh" ]
then
    echo "usage: bug/$name.sh"
    exit 1
fi
cat << EOF
Description
EOF
cat << EOF > $name.cpp
# include <cppad/cppad.hpp>
# include <omp.h>

namespace {

    typedef CPPAD_TESTVECTOR(double)               d_vector;
    typedef CPPAD_TESTVECTOR( CppAD::AD<double> ) ad_vector;


    // algorithm that we are checkpoingint
    const size_t length_of_sum_ = 5000;
    void long_sum_algo(const ad_vector& ax, ad_vector& ay)
    {   ay[0] = 0.0;
        for(size_t i = 0; i < length_of_sum_; ++i)
            ay[0] += ax[0];
        return;
    }
    // inform CppAD if we are in parallel mode
    bool in_parallel(void)
    {   return omp_in_parallel() != 0; }
    //
    // inform CppAD of the current thread number
    size_t thread_num(void)
    {   return static_cast<size_t>( omp_get_thread_num() ); }

}

int main(void)
{   bool ok = true;

    // OpenMP setup
    size_t num_threads = 2;      // number of threads
    omp_set_dynamic(0);          // turn off dynamic thread adjustment
    omp_set_num_threads( int(num_threads) );  // set number of OMP threads

    // check that multi-threading is possible on this machine
    if( omp_get_max_threads() < 2 )
    {   std::cout << "This machine does not support multi-threading: ";
    }

    // create checkpoint version of algorithm
    size_t n(1), m(1);
    ad_vector ax(n), ay(m);
    ax[0] = 2.0;
    CppAD::atomic_base<double>::option_enum sparsity =
        CppAD::atomic_base<double>::set_sparsity_enum;
    bool optimize = false;
    CppAD::checkpoint<double> atom_fun(
        "long_sum", long_sum_algo, ax, ay, sparsity, optimize
    );

    // setup for using CppAD in paralle mode
    CppAD::thread_alloc::parallel_setup(num_threads, in_parallel, thread_num);
    CppAD::thread_alloc::hold_memory(true);
    CppAD::parallel_ad<double>();

    // place to hold result for each thread
    d_vector y(num_threads);
    for(size_t thread = 0; thread < num_threads; thread++)
        y[thread] = 0.0;

    # pragma omp parallel for
    for(int thread = 0; thread < int(num_threads); thread++)
    {   ad_vector au(n), av(m);
        au[0] = 1.0;
        atom_fun(au, av);
        //
        y[thread] = double( length_of_sum_ * (thread + 1) );
    }

    // check the results
    for(size_t thread = 0; thread < num_threads; thread++)
    {   double check = double( length_of_sum_ * (thread + 1) );
        ok          &= check == y[thread];
    }
    if( ok )
        return 0;
    return 1;
}

EOF
# -----------------------------------------------------------------------------
if [ ! -e cppad/configure.hpp ]
then
    echo
    echo 'Cannot find the file cppad/configure.hpp.'
    echo 'Must run bin/run_cmake.sh to create it.'
    rm $name.cpp
    exit 1
fi
if [ -e build/bug ]
then
    rm -r build/bug
fi
mkdir -p build/bug
mv $name.cpp build/bug/$name.cpp
cd build/bug
cxx_flags='-Wall -pedantic-errors -std=c++11 -Wshadow -Wconversion -g -O0 -fopenmp'
eigen_dir="$HOME/prefix/eigen/include"
echo "g++ -I../.. -isystem $eigen_dir $cxx_flags $name.cpp -o $name"
g++ -I../.. -isystem $eigen_dir $cxx_flags $name.cpp -o $name
#
echo "build/bug/$name"
if ! ./$name
then
    echo
    echo "build/bug/$name: Error"
    exit 1
fi
echo
echo "./$name.sh: OK"
exit 0
