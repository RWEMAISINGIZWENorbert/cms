
import 'package:flutter/material.dart';
import 'package:tech_associate/screens/admin/dashboard/analytics.dart';
import 'package:tech_associate/screens/admin/dashboard/compliants.dart';
import 'package:tech_associate/screens/admin/dashboard/dashboard.dart';
import 'package:tech_associate/screens/admin/dashboard/settings.dart';

class ScreenNavigator {
    
    static const List<Widget> _screens = [
       Dashboard(),
       Compliants(),
       Analytics(),
       Settings()
    ];


    static Widget getBodyContent(int index){
      return _screens[index];
    }

}