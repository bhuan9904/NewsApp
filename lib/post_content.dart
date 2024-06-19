import 'package:flutter/material.dart';

class PostContent extends StatelessWidget {
  final String postImage;
  final String postTitle;
  final String app;
  final String postingDate;
  final String categoryName;
  final String url;

  const PostContent({
    Key? key,
    required this.postImage,
    required this.postTitle,
    required this.app,
    required this.postingDate,
    required this.categoryName,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,  // Set the desired height here
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
          ),
          width: double.infinity,
          child: Image.network(
            postImage,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }
            },
          ),
        ),
        Container(
          height: 40,
          width: double.infinity,
          child: Image.asset("assets/Narada Logo.png"),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postTitle,
                    style: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Roboto'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$app',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Posting Date: $postingDate',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Category Name: $categoryName',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
