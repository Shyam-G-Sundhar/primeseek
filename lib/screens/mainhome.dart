import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:primeseek/screens/home.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  late PageController _pageController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    HomeScreen(),
    PlaceholderPage(
      title: 'Bookings are Temporarily Hold',
    ),
    PlaceholderPage(title: 'Under Verfication Progress')
  ];
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _currentIndex == 0
                  ? Icon(Icons.home_outlined, key: ValueKey<int>(0))
                  : Icon(Icons.home_outlined, key: ValueKey<int>(1)),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _currentIndex == 1
                  ? Icon(Icons.book_online_outlined, key: ValueKey<int>(2))
                  : Icon(Icons.book_online_outlined, key: ValueKey<int>(3)),
            ),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _currentIndex == 3
                  ? Icon(Icons.person_2_outlined, key: ValueKey<int>(6))
                  : Icon(Icons.person_2_outlined, key: ValueKey<int>(7)),
            ),
            label: 'Profile',
          ),
        ],
      ),
    ));
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
