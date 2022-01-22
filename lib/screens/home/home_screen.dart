import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wedevs_testproject/constants/colores.dart';
import 'package:wedevs_testproject/screens/home/tabs/cart_tab/cart_tab.dart';
import 'package:wedevs_testproject/screens/home/tabs/home_tab/home_tab.dart';
import 'package:wedevs_testproject/screens/home/tabs/list_grid_tab/list_grid_tab.dart';
import 'package:wedevs_testproject/screens/home/tabs/my_account_tab/my_account.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //pages
  final screens = [
    HomeTab(),
    ListGridTab(),
    CartTab(),
    MyAccountTab(),
  ];

  int selectedIndex = 0;
  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index) {
    setState(() {
      selectedIndex = index;
      //text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundColor,
      body: SafeArea(
        child: screens[selectedIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        //notchMargin: 6.0,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 65.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  updateTabSelection(0);
                },
                child: Icon(
                  Icons.home_outlined,
                  color: selectedIndex == 0 ? homeScreenBottomIconSelectedColor : homeScreenBottomIconColor,
                  size: 25.0,
                ),
              ),
              MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  updateTabSelection(1);
                },
                child: Icon(
                  Icons.grid_view_outlined,
                  color: selectedIndex == 1 ? homeScreenBottomIconSelectedColor : homeScreenBottomIconColor,
                  size: 25.0,
                ),
              ),
              const Spacer(),
              MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  updateTabSelection(2);
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: selectedIndex == 2 ? homeScreenBottomIconSelectedColor : homeScreenBottomIconColor,
                  size: 25.0,
                ),
              ),
              MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  updateTabSelection(3);
                },
                child: Icon(
                  Icons.person_outline,
                  color: selectedIndex == 3 ? homeScreenBottomIconSelectedColor : homeScreenBottomIconColor,
                  size: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Cool FAB',
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                homeScreenFloatingActionButtonBackgroundStartColor,
                homeScreenFloatingActionButtonBackgroundEndColor,
              ],
            ),
          ),
          child: const Icon(Icons.search),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
