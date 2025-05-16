import 'package:flutter/material.dart';
import 'package:itdev_materi/models/book_model.dart';
import 'package:itdev_materi/providers/book_provider.dart';
import 'package:itdev_materi/screens/books/book_detail_screen.dart';
import 'package:provider/provider.dart';

class BookEditScreen extends StatefulWidget {
  final BookModel book; 
  const BookEditScreen({super.key, required this.book});

  @override
  State<BookEditScreen> createState() => _BookEditScreenState();
}


class _BookEditScreenState extends State<BookEditScreen>  {
  late final titleTxt;
  late final descriptionTxt;
  late final authorTxt;
  late final publisherTxt;
  late final categoryTxt;
  late final imageTxt;

  @override
  void initState() {
    super.initState();
    titleTxt = TextEditingController(text: widget.book.title);
    descriptionTxt = TextEditingController(text: widget.book.description);
    authorTxt = TextEditingController(text: widget.book.author);
    publisherTxt = TextEditingController(text: widget.book.publisher);
    categoryTxt = TextEditingController(text: widget.book.category);
    imageTxt = TextEditingController(text: widget.book.image);
  }

  @override
  void dispose() {
    titleTxt.dispose();
    descriptionTxt.dispose();
    authorTxt.dispose();
    publisherTxt.dispose();
    categoryTxt.dispose();
    imageTxt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Buku'),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleTxt,
              decoration: const InputDecoration(labelText: 'Judul Buku'),
            ),
            TextField(
              controller: descriptionTxt,
              decoration: const InputDecoration(labelText: 'Deskripsi Buku')
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
                final updatedBook = BookModel(
                  docId: widget.book.docId,
                  id: widget.book.id,   
                  title: titleTxt.text,
                  description: descriptionTxt.text,
                  author: authorTxt.text,
                  publisher: publisherTxt.text,
                  category: categoryTxt.text,
                  image: imageTxt.text,
                );
                Provider.of<BookProvider>(context, listen: false).updateBook(updatedBook);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookDetailScreen(book: updatedBook)),
                );
              },
              child: const Text('Perbarui Buku'),
            )
          ],
        )
      )
    );
  }
}