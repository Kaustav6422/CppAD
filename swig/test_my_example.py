# load the modules
import sys
#
sys.path.append( 'build' )
import my_example
#
# initialze exit status as OK
error_count = 0
# --------------------------------------------
# integer return value, integer arguments
if my_example.my_fact(4) == 24 :
	print("my_example.fact: OK")
else :
	print("my_example.my_fact: Error")
	error_count = error_count + 1
# --------------------------------------------
# c string return value
if my_example.my_message() == "OK" :
	print("my_example.my_message: OK")
else :
	print("my_example.my_message: Error")
	error_count = error_count + 1
# --------------------------------------------
# integer pointer argument to one integer value
obj = my_example.int_class()
my_example.my_add(3, 4, obj)
if obj.value() == 7 :
	print("my_example.my_add: OK")
else :
	print("my_example.my_add: Error")
	error_count = error_count + 1
# --------------------------------------------
# integer pointer argument to array of integer values
n   = 10
array_ptr = my_example.new_int_array_ptr(n)
for i in range(n) :
	my_example.int_array_ptr_setitem(array_ptr, i, 2 * i)
#
if my_example.my_max(n, array_ptr) == 18 :
	print("my_example.my_max: OK")
else :
	print("my_example.my_max: Error")
	error_count = error_count + 1
my_example.delete_int_array_ptr(array_ptr)
# --------------------------------------------
# return error_count
sys.exit(error_count)
