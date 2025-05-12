import 'package:flutter/material.dart';
import 'package:itdev_materi/models/book_model.dart';
import 'package:itdev_materi/providers/book_provider.dart';
import 'package:itdev_materi/screens/books/book_edit_screen.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatelessWidget {
  final BookModel book;
  
  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.image, height: 200),
            const SizedBox(height: 16),
            Text('Author: ${book.author}', style: TextStyle(fontSize: 18)),
            Text('Publisher: ${book.publisher}'),
            Text('Category: ${book.category}'),
            Text('Description: ${book.description}'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookEditScreen(book: book),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Edit"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Provider.of<BookProvider>(context, listen: false)
                        .deleteBook(book.id);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}