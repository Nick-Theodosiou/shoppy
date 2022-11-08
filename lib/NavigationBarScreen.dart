import 'package:flutter/material.dart';
import 'screens/CategoriesScreen.dart';
import 'screens/FavoritesScreen.dart';
import 'screens/ListsScreen.dart';
import 'screens/StoresScreen.dart';
import 'screens/HomeScreen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavoritesScreen(),
    CategoriesScreen(),
    StoresScreen(),
    ListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Image.asset('asset/images/logo.png'),
          titleSpacing: 00.0,
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
                    Icons.account_circle_outlined,
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
                Icons.category_outlined,
                color: Colors.grey[300],
                size: 32,
              ),
              label: 'CATEGORIES',
              activeIcon: const Icon(
                Icons.category,
                color: Color.fromARGB(255, 6, 39, 97),
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.store_outlined,
                color: Colors.grey[300],
                size: 32,
              ),
              label: 'STORES',
              activeIcon: const Icon(
                Icons.store,
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
              label: 'LISTS',
              activeIcon: const Icon(
                Icons.shopping_cart,
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
