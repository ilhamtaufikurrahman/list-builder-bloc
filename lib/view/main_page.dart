import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_bloc/bloc/post_bloc.dart';
import 'package:infinite_list_bloc/view/post_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController controller = ScrollController();
  PostBloc? bloc;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;

    if (currentScroll == maxScroll) {
      bloc!.add(PostEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<PostBloc>(context);
    controller.addListener(() => onScroll());

    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite List Bloc'),
      ),
      body: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        if (state is PostUninitialized) {
          return Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          PostLoaded postLoaded = state as PostLoaded;
          return ListView.builder(
            controller: controller,
            itemCount: (postLoaded.hasReacheMax!)
                ? postLoaded.posts!.length
                : postLoaded.posts!.length + 1,
            itemBuilder: (context, index) {
              if (index < postLoaded.posts!.length) {
                return PostCard(post: postLoaded.posts![index]);
              } else {
                return Container(
                  child: Center(
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          );
        }
      }),
    );
  }
}
