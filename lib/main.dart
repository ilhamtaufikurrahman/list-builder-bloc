import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_bloc/bloc/post_bloc.dart';

import 'view/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider<PostBloc>(
            create: (context) => PostBloc()..add(PostEvent()),
            child: MainPage()));
  }
}
