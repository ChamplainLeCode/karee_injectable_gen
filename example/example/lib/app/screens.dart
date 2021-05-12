import 'package:example/app/screens/users/user_home_screen.dart';
import 'package:example/app/screens/users/user_filter_screen.dart';
import 'package:example/app/screens/home_screen.dart';

/*
 *	
@Author Champlain Marius Bakop
@Email champlainmarius20@gmail.com
@github ChamplainLeCode */


List<Map<Symbol, dynamic>> screens = [

	{#name: 'home', #screen: () => HomeScreen(), #initial: true},
	{#name: 'user_filter', #screen: () => UserFilterScreen()},
	{#name: 'user_page', #screen: () => UserHomeScreen()},

];