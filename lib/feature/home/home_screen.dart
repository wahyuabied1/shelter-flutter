import 'package:flutter/material.dart';
import 'package:shelter_super_app/feature/home/main/main_home_screen.dart';
import 'package:shelter_super_app/feature/home/notifikasi/notification_screen.dart';
import 'package:shelter_super_app/feature/home/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final int selectedPage;
  final bool showAlreadyLogin;

  const HomeScreen({
    Key? key,
    this.selectedPage = 0,
    this.showAlreadyLogin = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  PageController? pageController;

  void onNavigationTapped(int index) {
    setState(() {
      _currentPage = index;
      pageController?.jumpToPage(index);
    });
  }

  @override
  void initState() {
    _currentPage = widget.selectedPage;
    super.initState();
    pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            MainHomeScreen(onNavigate: onNavigationTapped),
            // NotificationScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            // _buildNavItem(Icons.notifications, 'Notifikasi', 1),
            _buildNavItem(Icons.person, 'Profile', 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentPage == index;

    return GestureDetector(
      onTap: () => onNavigationTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding:
            EdgeInsets.symmetric(horizontal: isSelected ? 16 : 0, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 50,
          width: 80,
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
              ),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
