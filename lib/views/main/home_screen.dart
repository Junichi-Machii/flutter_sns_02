import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sns_u_02/details/post_card.dart';
import 'package:flutter_sns_u_02/details/reload_screen.dart';

import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/posts_model.dart';
import 'package:flutter_sns_u_02/models/main/home_model.dart';

import 'package:flutter_sns_u_02/domain/post/post.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
    required this.mainModel,
  });

  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final PostsModel postsModel = ref.watch(postsProvider);
    final postdocs = homeModel.postDocs;
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    return homeModel.postDocs.isEmpty
        ? ReloadScreen(homeModel: homeModel)
        : Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  key: refreshIndicatorKey,
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                  // controller: homeModel.refreshController,
                  // enablePullDown: true,
                  // enablePullUp: true,
                  onRefresh: homeModel.onRefresh,
                  // onLoading: homeModel.onLoading,
                  // header: WaterDropHeader(),
                  child: ListView.builder(
                    itemCount: postdocs.length,
                    itemBuilder: (context, index) {
                      final postDoc = postdocs[index];
                      final Post post = Post.fromJson(postDoc.data()!);

                      return PostCard(
                          post: post,
                          mainModel: mainModel,
                          commentsModel: commentsModel,
                          postDoc: postDoc,
                          postsModel: postsModel);
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
