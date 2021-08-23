import 'package:flutter/material.dart';
import 'package:infinite_list_bloc/model/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              post.title ?? 'tidak ada judul',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Text(post.body ?? 'tidak ada body')
          ],
        ),
      ),
    );
  }
}
