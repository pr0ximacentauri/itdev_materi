import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itdev_materi/models/book_model.dart';

class BookProvider extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<BookModel> _books = [];
  List<BookModel> get books => _books;

  Future<void> getBooks() async{
    try{
      final snapshot = await _firestore.collection('books').get();
      _books = snapshot.docs.map((doc) => BookModel.fromDoc(doc)).toList();
      notifyListeners();
    }catch(e){
      print('Error mengambil data buku: $e');
    }
  }

  Future<void> addBook(BookModel book) async{
    try{
      final docRef = await _firestore.collection('books').add(book.toMap());
      final newBook = book.copyWith(docId: docRef.id);
      _books.add(newBook);
      notifyListeners();
    }catch(e){
      print('Error menambah data buku: $e');
    }
  }

  Future<void> updateBook(BookModel book) async{
    try{
      await _firestore.collection('books').doc(book.docId.toString()).update(book.toMap());
      int index = _books.indexWhere((b) => b.docId == book.docId);
      if(index != 1){
        _books[index] = book;
      }
      notifyListeners();
    }catch(e){
      print('Error mengubah data buku: $e');
    }
  }

  Future<void> deleteBook(String docId) async {
    try {
      await _firestore.collection('books').doc(docId).delete();
      _books.removeWhere((b) => b.docId == docId);
      notifyListeners();
    } catch (e) {
      print('Error menghapus data buku: $e');
    }
  }
}