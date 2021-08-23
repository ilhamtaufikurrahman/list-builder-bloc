import 'package:bloc/bloc.dart';
import 'package:infinite_list_bloc/model/post.dart';

class PostEvent {}

abstract class PostState {}

class PostUninitialized extends PostState {}

class PostLoaded extends PostState {
  List<Post>? posts;
  //apakah data sudah diload semua
  bool? hasReacheMax;

  PostLoaded({this.posts, this.hasReacheMax});

  PostLoaded copyWith({required List<Post> posts, required bool hasReacheMax}) {
    return PostLoaded(posts: posts, hasReacheMax: hasReacheMax);
  }
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostUninitialized());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    List<Post> posts;

    if (state is PostUninitialized) {
      posts = await Post.listPost(0, 10);
      yield PostLoaded(posts: posts, hasReacheMax: false);
    } else {
      PostLoaded postLoaded = state as PostLoaded;
      posts = await Post.listPost(postLoaded.posts!.length, 10);
      yield (posts.isEmpty)
          ? postLoaded.copyWith(posts: postLoaded.posts!, hasReacheMax: true)
          : PostLoaded(posts: postLoaded.posts! + posts, hasReacheMax: false);
    }
  }
}
