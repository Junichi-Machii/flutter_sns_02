import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sns_u_02/details/post_card.dart';
import 'package:flutter_sns_u_02/models/mute_user_model.dart';
import 'package:flutter_sns_u_02/views/refresh_screen.dart';
import 'package:flutter_sns_u_02/views/reload_screen.dart';

import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/posts_model.dart';
import 'package:flutter_sns_u_02/models/main/home_model.dart';

import 'package:flutter_sns_u_02/domain/post/post.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
    required this.mainModel,
    required this.muteUserModel,
  });

  final MainModel mainModel;
  final MuteUserModel muteUserModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeModel homeModel = ref.watch(homeProvider);
    final PostsModel postsModel = ref.watch(postsProvider);
    final postDocs = homeModel.postDocs;
    final CommentsModel commentsModel = ref.watch(commentsProvider);

    return postDocs.isEmpty
        ? ReloadScreen(
            onReload: () => homeModel.onReload(),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: RefreshScreen(
                onLoading: () async => await homeModel.onLoading(),
                refreshController: homeModel.refreshController,
                child: ListView.builder(
                  itemCount: postDocs.length,
                  itemBuilder: (context, index) {
                    final postDoc = postDocs[index];
                    final Post post = Post.fromJson(postDoc.data()!);

                    return PostCard(
                        onTap: () => muteUserModel.showPopUp(
                            docs: postDocs,
                            mainModel: mainModel,
                            passiveUid: post.uid,
                            context: context),
                        post: post,
                        mainModel: mainModel,
                        commentsModel: commentsModel,
                        postDoc: postDoc,
                        postsModel: postsModel);
                  },
                ),
                onRefresh: () async => await homeModel.onRefresh()),
          );
  }
}
