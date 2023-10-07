import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/routes.dart' as routes;
import 'package:flutter_sns_u_02/details/post_like_button.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/posts_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                child: SmartRefresher(
                  controller: homeModel.refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onRefresh: homeModel.onRefresh,
                  onLoading: homeModel.onLoading,
                  header: WaterDropHeader(),
                  child: ListView.builder(
                    itemCount: postdocs.length,
                    itemBuilder: (context, index) {
                      final postDoc = postdocs[index];
                      final Post post = Post.fromJson(postDoc.data()!);

                      return Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  UserImage(
                                      length: 54,
                                      userImageURL: post.uid ==
                                              mainModel.firestoreUser.uid
                                          ? mainModel.firestoreUser.userImageURL
                                          : post.imageURL),
                                  Text(
                                    post.text,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.comment),
                                        onPressed: () => routes.toCommentsPage(
                                            context: context,
                                            mainModel: mainModel,
                                            postDoc: postDoc,
                                            post: post),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      PostLikeButton(
                                          mainModel: mainModel,
                                          post: post,
                                          postsModel: postsModel,
                                          postDoc: postDoc),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
