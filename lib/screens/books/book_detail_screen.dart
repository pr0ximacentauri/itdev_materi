import 'package:flutter/material.dart';
import 'package:itdev_materi/models/book_model.dart';
import 'package:itdev_materi/providers/book_provider.dart';
import 'package:itdev_materi/screens/books/book_edit_screen.dart';
import 'package:itdev_materi/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatefulWidget {
  final BookModel book;

  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen>{
  late BookModel book;

  @override
  void initState() {
    super.initState();
    book = widget.book;

    Future.microtask(() =>
      Provider.of<BookProvider>(context, listen: false).getBooks()
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final provider = Provider.of<BookProvider>(context, listen: false);
              final updatedBook = provider.books.firstWhere(
                (b) => b.docId == book.docId,
                orElse: () => book,
              );
              setState(() {
                book = updatedBook;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookEditScreen(book: book)),
              );
              final provider = Provider.of<BookProvider>(context, listen: false);
              final updatedBook = provider.books.firstWhere(
                (b) => b.docId == book.docId,
                orElse: () => book,
              );
              setState(() {
                book = updatedBook;
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Hero(
              tag: 'bookImage-${widget.book.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(widget.book.image, height: 220, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.book.title, style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Author: ${widget.book.author}', style: textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text('Publisher: ${widget.book.publisher}', style: textTheme.bodyLarge),
                  const SizedBox(height: 4),
                  Text('Category: ${widget.book.category}', style: textTheme.bodyLarge),
                  const SizedBox(height: 16),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 10),
                  Text('Description', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(widget.book.description, style: textTheme.bodyMedium),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BookEditScreen(book: book)),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async{
                    final confirm = await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Hapus Buku?"),
                        content: const Text("Yakin ingin menghapus buku ini?"),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Tidak jadi")),
                          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus")),
                        ],
                      )
                    );
                    if (confirm == true) {
                      await Provider.of<BookProvider>(context, listen: false)
                          .deleteBook(book.docId!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                    );
                    }
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
