import 'package:flutter/material.dart';
import 'package:pmsna1/screens/dashboard_screen.dart';
import 'package:pmsna1/screens/register_sreens.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/register':(BuildContext context) => const RegisterScreen(),
    '/dash':(BuildContext context) => DashboardScreen(),
  };
}