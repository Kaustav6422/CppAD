# ifndef CPPAD_EXAMPLE_MULTI_THREAD_HARMONIC_HPP
# define CPPAD_EXAMPLE_MULTI_THREAD_HARMONIC_HPP
/* --------------------------------------------------------------------------
CppAD: C++ Algorithmic Differentiation: Copyright (C) 2003-17 Bradley M. Bell

CppAD is distributed under the terms of the
             Eclipse Public License Version 2.0.

This Source Code may also be made available under the following
Secondary License when the conditions for such availability set forth
in the Eclipse Public License, Version 2.0 are satisfied:
      GNU General Public License, Version 2.0 or later.
---------------------------------------------------------------------------- */

bool harmonic_time(
    double& time_out, double test_time, size_t num_threads, size_t mega_sum
);

# endif
