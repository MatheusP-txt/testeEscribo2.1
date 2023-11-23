import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class BookData {
  String id;
  String bookCover;
  String bookTitle;
  String author;
  String downloadUrl;

  BookData({
    required this.id,
    required this.bookCover,
    required this.bookTitle,
    required this.author,
    required this.downloadUrl,
  });

  factory BookData.fromJson(Map<String, dynamic> json) {
    return BookData(
      id: json["id"].toString(),
      bookCover: json["cover_url"],
      bookTitle: json["title"],
      author: json["author"],
      downloadUrl: json["download_url"],
    );
  }
  Future<void> downloadBook() async {
    try {
      var response = await http.get(Uri.parse(downloadUrl));

      File file = File('${bookTitle}.epub');
      await file.writeAsBytes(response.bodyBytes);

      print('Download concluído para ${file.path}');
    } catch (error) {
      print('Erro no download: $error');
    }
  }
  
}
