import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'root_navigation_provider.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

final rootNavigationTabs = [
  Container(
    key: const ValueKey(0),
    color: Colors.red,
    child: const Center(child: Text('Library')),
  ),
  Container(
    key: const ValueKey(1),
    color: Colors.blue,
    child: const Center(child: Text('History')),
  ),
  Container(
    key: const ValueKey(2),
    color: Colors.green,
    child: const Center(child: Text('Explore')),
  ),
  Container(
    key: const ValueKey(4),
    color: Colors.orange,
    child: const Center(child: Text('More')),
  ),
];

class _RootWidgetState extends State<RootWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RootBottomNavigationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aether App'),
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          print(child);
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: rootNavigationTabs[provider.currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: provider.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(key: ValueKey(100), Icons.collections_bookmark),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(LineIcons.globe),
            icon: Icon(LineIcons.globe),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        onTap: (index) {
          provider.currentIndex = index;
        },
      ),
    );
  }
}
