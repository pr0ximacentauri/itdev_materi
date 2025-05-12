import 'package:flutter/material.dart';
import 'package:itdev_materi/providers/book_provider.dart';
import 'package:itdev_materi/screens/books/book_add_screen.dart';
import 'package:itdev_materi/screens/books/book_detail_screen.dart';
import 'package:itdev_materi/screens/home/home_drawer.dart';
import 'package:itdev_materi/screens/main_scaffold.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    // Pastikan tidak error karena context belum tersedia secara penuh
    Future.microtask(() =>
      Provider.of<BookProvider>(context, listen: false).getBooks()
    );
  }
  Widget build(BuildContext context) {

    return MainScaffold(
      currentIndex: 0,
      body: Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(
          title: const Text('Manajemen Buku Digital'),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.add),
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => BookAddScreen()),
          //       );
          //     },
          //   ),
          // ],
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Kategori Buku',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  BookCategoryCard(label: 'Fiksi', icon: Icons.menu_book),
                  BookCategoryCard(label: 'Non-Fiksi', icon: Icons.auto_stories),
                  BookCategoryCard(label: 'Referensi', icon: Icons.library_books),
                  BookCategoryCard(label: 'Anak-anak', icon: Icons.child_care),
                  BookCategoryCard(label: 'Akademik', icon: Icons.school),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Semua Buku',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Consumer<BookProvider>(
              builder: (context, bookProvider, _) {
                final books = bookProvider.books;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.65,
                    children: books.map((book) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailScreen(book: book),
                            ),
                          );
                        },
                        child: BookCard(
                          title: book.title,
                          author: book.author, 
                          imageUrl: book.image,
                        ),
                      );
                    }).toList(),
                  ),
                );
              } 
            )
          ],
        ),
      ),
    );
  }
}

class BookCategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;

  const BookCategoryCard({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.lightBlue[50],
        child: SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.indigo),
              const SizedBox(height: 8),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                author,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
