import 'package:flutter/material.dart';
import 'package:tech_associate/components/navigators/screen_navigator.dart';
import 'package:tech_associate/widgets/bottom_app_bar.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 
 
  int _currentIndex = 0;

  void _onItemTapped(int index){
    setState(() {
       _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
        padding: EdgeInsets.only(top: 22),
        child: ScreenNavigator.getBodyContent(_currentIndex)
        ),
      bottomNavigationBar: MyBottomAppBar(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped
      ),   
    );
  }
}