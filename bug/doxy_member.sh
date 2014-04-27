#! /bin/bash -e
# $Id$
# -----------------------------------------------------------------------------
# CppAD: C++ Algorithmic Differentiation: Copyright (C) 2003-14 Bradley M. Bell
#
# CppAD is distributed under multiple licenses. This distribution is under
# the terms of the 
#                     Eclipse Public License Version 1.0.
#
# A copy of this license is included in the COPYING file of this distribution.
# Please visit http://www.coin-or.org/CppAD/ for information on other licenses.
# -----------------------------------------------------------------------------
# Trying to figure out why documentation details for ADFun::Forward
# are missing. This similar case seems to work.
#
# ------------------------------------------------------------------------------
# bash function that echos and executes a command
echo_eval() {
	echo $*
	eval $*
}
# -----------------------------------------------
echo "$0"
name=`echo $0 | sed -e 's|.*/||' -e 's|\..*||'`
# -----------------------------------------------
for dir in build doxy_member
do
	if [ ! -e $dir ]
	then
		mkdir $dir
	fi
	cd $dir
done
# -------------------------------------------------------------------------
cat << EOF > $name.hpp

class my_class {
private:
	int value_;
public:
	void set_value(int value);
	int  get_value(void);
};
EOF
cat << EOF > implement.hpp
/*!
\\file implement.hpp
Implementation of member functions
*/

/*!
Member function that sets the value.

\\param value [in]
New value.
*/
void my_class::set_value(int value)
{	value_ = value; }

/*!
Member function that gets the value.

\\return
Current value.
*/
int my_class::get_value(void)
{	return value_; }
EOF
cat << EOF > $name.cpp
# include <iostream>
# include "$name.hpp"
# include "implement.hpp"
int main(void)
{	my_class x;
	x.set_value(2);
	std::cout << "x.value = " << x.get_value() << std::endl;
	return 0;
}
EOF
# -------------------------------------------------------------------------
# echo_eval doxygen -g doxyfile
cp ../../../doxyfile .
sed \
	-e 's|^\(INPUT *=\)|& .|' \
	-e 's|^\(FILE_PATTERNS *=\)|& *.hpp *.cpp|' \
	-i doxyfile
# -------------------------------------------------------------------------
echo_eval doxygen doxyfile
# -------------------------------------------------------------------------
echo_eval g++ $name.cpp -o name
echo_eval ./name