import 'package:flutter/material.dart';
import 'package:shoppy/LoginScreen.dart';
import 'screens/FavoritesScreen.dart';
import 'screens/AccountScreen.dart';
import 'screens/BestDealsScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/ListScreen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BestDealsScreen(),
    ListScreen(),
    FavoritesScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset('asset/images/logo.png', height: 60),
          titleSpacing: MediaQuery.of(context).size.width * 0.26,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          elevation: 0.00,
          backgroundColor: const Color.fromARGB(255, 6, 39, 97),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.notifications_active_outlined,
                    size: 26.0,
                  ),
                )),
          ]),
      body: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey[400],
          selectedItemColor: const Color.fromARGB(255, 6, 39, 97),
          unselectedFontSize: 11,
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.grey[300],
                size: 32,
              ),
              label: 'HOME',
              activeIcon: const Icon(
                Icons.home,
                color: Color.fromARGB(255, 6, 39, 97),
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.percent_outlined,
                color: Colors.grey[300],
                size: 32,
              ),
              label: 'BEST DEALS',
              activeIcon: const Icon(
                Icons.percent,
                color: Color.fromARGB(255, 6, 39, 97),
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.grey[300],
                size: 32,
              ),
              label: 'LIST',
              activeIcon: const Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 6, 39, 97),
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Colors.grey[300],
                size: 32,
              ),
              label: 'FAVORITES',
              activeIcon: const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 6, 39, 97),
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: Colors.grey[300],
                size: 32,
              ),
              label: 'ACCOUNT',
              activeIcon: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 6, 39, 97),
                size: 32,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
