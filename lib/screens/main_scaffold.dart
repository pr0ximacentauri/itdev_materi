import 'package:flutter/material.dart';
import 'package:itdev_materi/screens/books/book_add_screen.dart';
import 'package:itdev_materi/screens/home/home_screen.dart';

class MainScaffold extends StatelessWidget {
  final int currentIndex;
  final Widget body;

  const MainScaffold({
    super.key,
    required this.currentIndex,
    required this.body,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget screen;
    switch (index) {
      case 0:
        screen = const HomeScreen();
        break;
      case 1:
        screen = const BookAddScreen();
        break;
      default:
        screen = const HomeScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Tambah Buku'),
        ],
      ),
    );
  }
}
