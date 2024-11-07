import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase/core/constants/colors.dart';
import 'package:flutter_chat_firebase/presentations/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final _widgets = [
    HomePage(),
    const Text('Contact'),
    const Text('Setting'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgets,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16.0,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, -8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            useLegacyColorScheme: false,
            currentIndex: _selectedIndex,
            onTap: (value) => setState(() => _selectedIndex = value),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(color: AppColors.primary),
            selectedIconTheme: const IconThemeData(color: AppColors.primary),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.sms_outlined,
                    color: _selectedIndex == 0
                        ? AppColors.primary
                        : AppColors.grey),
                label: 'Message',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined,
                    color: _selectedIndex == 1
                        ? AppColors.primary
                        : AppColors.grey),
                label: 'Contact',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings,
                    color: _selectedIndex == 2
                        ? AppColors.primary
                        : AppColors.grey),
                label: 'Setting',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
