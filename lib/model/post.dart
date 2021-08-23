import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  int? id;
  String? title;
  String? body;

  Post({this.id, this.title, this.body});

  factory Post.createPost(Map<String, dynamic> object) {
    return Post(id: object['id'], title: object['title'], body: object['body']);
  }

  static Future<List<Post>> listPost(int start, int limit) async {
    String url =
        'http://jsonplaceholder.typicode.com/posts?_start=${start.toString()}&_limit=${limit.toString()}';

    var conn = await http.get(Uri.parse(url));
    var jsonObject = json.decode(conn.body) as List;

    return jsonObject
        .map<Post>((item) =>
            Post(id: item['id'], title: item['title'], body: item['body']))
        .toList();
  }
}
