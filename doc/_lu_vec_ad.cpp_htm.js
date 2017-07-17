var list_across0 = [
'_contents.htm',
'_reference.htm',
'_index.htm',
'_search.htm',
'_external.htm'
];
var list_up0 = [
'cppad.htm',
'example.htm',
'exampleutility.htm',
'lu_vec_ad.cpp.htm'
];
var list_down3 = [
'install.htm',
'introduction.htm',
'ad.htm',
'adfun.htm',
'preprocessor.htm',
'multi_thread.htm',
'utility.htm',
'ipopt_solve.htm',
'example.htm',
'speed.htm',
'appendix.htm'
];
var list_down2 = [
'get_started.cpp.htm',
'general.htm',
'exampleutility.htm',
'listallexamples.htm',
'testvector.htm'
];
var list_down1 = [
'general.cpp.htm',
'speed_example.cpp.htm',
'lu_vec_ad.cpp.htm'
];
var list_down0 = [
'lu_vec_ad_ok.cpp.htm'
];
var list_current0 = [
'lu_vec_ad.cpp.htm#Syntax',
'lu_vec_ad.cpp.htm#Purpose',
'lu_vec_ad.cpp.htm#Storage Convention',
'lu_vec_ad.cpp.htm#n',
'lu_vec_ad.cpp.htm#m',
'lu_vec_ad.cpp.htm#Matrix',
'lu_vec_ad.cpp.htm#Rhs',
'lu_vec_ad.cpp.htm#Result',
'lu_vec_ad.cpp.htm#logdet',
'lu_vec_ad.cpp.htm#Example'
];
function choose_across0(item)
{	var index          = item.selectedIndex;
	item.selectedIndex = 0;
	if(index > 0)
		document.location = list_across0[index-1];
}
function choose_up0(item)
{	var index          = item.selectedIndex;
	item.selectedIndex = 0;
	if(index > 0)
		document.location = list_up0[index-1];
}
function choose_down3(item)
{	var index          = item.selectedIndex;
	item.selectedIndex = 0;
	if(index > 0)
		document.location = list_down3[index-1];
}
function choose_down2(item)
{	var index          = item.selectedIndex;
	item.selectedIndex = 0;
	if(index > 0)
		document.location = list_down2[index-1];
}
function choose_down1(item)
{	var index          = item.selectedIndex;
	item.selectedIndex = 0;
	if(index > 0)
		document.location = list_down1[index-1];
}
function choose_down0(item)
{	var index          = item.selectedIndex;
	item.selectedIndex = 0;
	if(index > 0)
		document.location = list_down0[index-1];
}
function choose_current0(item)
{	var index          = item.selectedIndex;
	item.selectedIndex = 0;
	if(index > 0)
		document.location = list_current0[index-1];
}