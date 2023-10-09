import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/routes.dart' as routes;
import 'package:flutter_sns_u_02/details/post_card.dart';
import 'package:flutter_sns_u_02/details/post_like_button.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/posts_model.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

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
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RoundedButton(
                  onPressed: () async => homeModel.onReload(),
                  color: Theme.of(context).colorScheme.inversePrimary,
                  text: "Reload",
                  widthRate: 0.85,
                ),
              )
            ],
          )
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
