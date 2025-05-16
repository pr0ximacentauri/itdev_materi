import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itdev_materi/models/book_model.dart';
import 'package:itdev_materi/providers/book_provider.dart';
import 'package:itdev_materi/screens/home/home_screen.dart';
import 'package:itdev_materi/screens/main_scaffold.dart';
import 'package:provider/provider.dart';

class BookAddScreen extends StatelessWidget {
  const BookAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleTxt = TextEditingController();
    final descriptionTxt = TextEditingController();
    final authorTxt = TextEditingController();
    final publisherTxt = TextEditingController();
    final categoryTxt = TextEditingController();
    final imageTxt = TextEditingController();

    return MainScaffold(
      currentIndex: 1,
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Buku'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleTxt,
                decoration: const InputDecoration(labelText: 'Judul Buku'),
              ),
              TextField(
                controller: descriptionTxt,
                decoration: const InputDecoration(labelText: 'Deskripsi Buku'),
              ),
              TextField(
                controller: authorTxt,
                decoration: const InputDecoration(labelText: 'Penulis Buku'),
              ),
              TextField(
                controller: publisherTxt,
                decoration: const InputDecoration(labelText: 'Penerbit Buku'),
              ),
              TextField(
                controller: categoryTxt,
                decoration: const InputDecoration(labelText: 'Kategori Buku'),
              ),
              TextField(
                controller: imageTxt,
                decoration: const InputDecoration(labelText: 'URL Gambar Buku'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final book = BookModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: titleTxt.text,
                    description: descriptionTxt.text,
                    author: authorTxt.text,
                    publisher: publisherTxt.text,
                    category: categoryTxt.text,
                    image: imageTxt.text,
                  );
                  Provider.of<BookProvider>(context, listen: false).addBook(book);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  );
                },
                child: const Text('Tambah Buku'),
              ),
            ],
          )
        ),
      ),
    );
  }
}