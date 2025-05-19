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
         height: screenHeight * 0.14,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){
                 onItemTapped(0);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      currentIndex == 0 ?  IconlyBold.home: IconlyLight.home,
                      color: currentIndex == 0 ? Theme.of(context).primaryColor  : Theme.of(context).hintColor,
                      size: 28,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dashboard', 
                      style: currentIndex == 0 
                      ? Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColor) 
                      : Theme.of(context).textTheme.labelSmall
                      ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                onItemTapped(1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                     currentIndex == 1 ? Icons.list : Icons.list,
                      size: 28,
                      color: currentIndex == 1 ? Theme.of(context).primaryColor  : Theme.of(context).hintColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'complaints', 
                      style: currentIndex == 1 
                      ? Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColor) 
                      : Theme.of(context).textTheme.labelSmall
                      ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                onItemTapped(2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                     currentIndex == 2 ? Icons.analytics : Icons.analytics,
                     size: 28,
                     fill: 1.0,
                     color: currentIndex == 2 ? Theme.of(context).primaryColor  : Theme.of(context).hintColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'analyics', 
                      style: currentIndex == 2 
                      ? Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColor) 
                      : Theme.of(context).textTheme.labelSmall
                      ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                onItemTapped(3);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                     currentIndex == 3 ? IconlyBold.setting : IconlyLight.setting,
                     size: 28,
                     fill: 1.0,
                     color: currentIndex == 3 ? Theme.of(context).primaryColor  : Theme.of(context).hintColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'settings',
                      style: currentIndex == 3 
                      ? Theme.of(context).textTheme.labelSmall!.copyWith(color: Theme.of(context).primaryColor) 
                      : Theme.of(context).textTheme.labelSmall
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