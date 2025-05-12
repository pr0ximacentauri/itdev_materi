import 'package:flutter/material.dart';
import 'package:itdev_materi/screens/books/book_add_screen.dart';
import 'package:itdev_materi/screens/home/home_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Manajemen Buku Digital',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('halaman Utama'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Tambah Buku Baru'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BookAddScreen();
                  },
                ),
              );
            },
          ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(Icons.logout),
          //   title: const Text('Sign Out'),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
