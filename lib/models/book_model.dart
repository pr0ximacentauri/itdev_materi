import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String? docId;
  final int id;
  final String title;
  final String description;
  final String author;
  final String publisher;
  final String category;
  final String image;

  BookModel({
    this.docId,
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.publisher,
    required this.category,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'author': author,
      'publisher': publisher,
      'category': category,
      'image': image,
    };
  }

  factory BookModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookModel(
      docId: doc.id, // ambil ID dokumen
      id: data['id'] ?? 0,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      author: data['author'] ?? '',
      publisher: data['publisher'] ?? '',
      category: data['category'] ?? '',
      image: data['image'] ?? '',
    );
  }

  BookModel copyWith({
    String? docId,
    int? id,
    String? title,
    String? description,
    String? author,
    String? publisher,
    String? category,
    String? image,
  }) {
    return BookModel(
      docId: docId ?? this.docId,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      category: category ?? this.category,
      image: image ?? this.image,
    );
  }
}