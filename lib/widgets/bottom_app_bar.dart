import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class MyBottomAppBar extends StatelessWidget {
   
   final int currentIndex;
   final Function(int) onItemTapped;

  const MyBottomAppBar({
    required this.currentIndex,
    required this.onItemTapped,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BottomAppBar(
         height: screenHeight * 0.11,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                 onItemTapped(0);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      currentIndex == 0 ?  IconlyBold.home: IconlyLight.home,
                      color: currentIndex == 0 ? Theme.of(context).primaryColor  : Theme.of(context).hintColor,
                      size: 22,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Dashboard', 
                      style: (currentIndex == 0 
                      ? Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColor) 
                      : Theme.of(context).textTheme.labelSmall)?.copyWith(fontSize: 9),
                      ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                onItemTapped(1);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                     currentIndex == 1 ? IconlyBold.category : IconlyLight.category,
                      size: 22,
                      color: currentIndex == 1 ? Theme.of(context).primaryColor  : Theme.of(context).hintColor,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Complaints', 
                      style: (currentIndex == 1 
                      ? Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColor) 
                      : Theme.of(context).textTheme.labelSmall)?.copyWith(fontSize: 9),
                      ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                onItemTapped(2);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                     currentIndex == 2 ? IconlyBold.chart : IconlyLight.chart,
                     size: 22,
                     color: currentIndex == 2 ? Theme.of(context).primaryColor  : Theme.of(context).hintColor,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Analytics', 
                      style: (currentIndex == 2 
                      ? Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColor) 
                      : Theme.of(context).textTheme.labelSmall)?.copyWith(fontSize: 9),
                      ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                onItemTapped(3);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                     currentIndex == 3 ? IconlyBold.setting : IconlyLight.setting,
                     size: 22,
                     color: currentIndex == 3 ? Theme.of(context).primaryColor  : Theme.of(context).hintColor,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Settings',
                      style: (currentIndex == 3 
                      ? Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColor) 
                      : Theme.of(context).textTheme.labelSmall)?.copyWith(fontSize: 9),
                       ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}