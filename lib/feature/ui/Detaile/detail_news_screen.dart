import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/feature/data/new_model.dart';

class NewsDetail extends StatelessWidget {
  final Article newsModel; // Assuming your news items are of type ArticleModel

  const NewsDetail({Key? key, required this.newsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('News'), // Display the title in the app bar
      ),
      body: SingleChildScrollView(
        // Add scrolling behavior
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image or a placeholder text
              Material(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Image.network(
                  newsModel.urlToImage != null &&
                          newsModel.urlToImage!.startsWith('http')
                      ? newsModel.urlToImage!
                      : 'https://via.placeholder.com/600', // Provide a valid placeholder URL
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    // Fallback to a placeholder image in case of error
                    return Lottie.asset(
                      'asset/image/news.json',
                      width: 390,
                      height: 118,
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
              SizedBox(height: 29),
              // Display the title
              Material(
                color: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    newsModel.title,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 13, 89, 219),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Display the description
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  newsModel.description ?? "Content not available",
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Display the content
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  newsModel.content ?? "Content not available",
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Display additional details like author and published date
              Material(
                color: Colors.white,
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Author: ${newsModel.author ?? 'Unknown'}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Material(
                elevation: 20,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Published at: ${newsModel.publishedAt != null ? DateFormat('yyyy-MM-dd').format(newsModel.publishedAt!) : 'Unknown'}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
