import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/posts_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_sns_u_02/models/main/home_model.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.mainModel});

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
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: ListTile(
                          leading: UserImage(
                              length: 32,
                              userImageURL:
                                  post.uid == mainModel.firestoreUser.uid
                                      ? mainModel.firestoreUser.userImageURL
                                      : post.imageURL),
                          trailing: mainModel.likePostIds.contains(post.postId)
                              ? InkWell(
                                  child: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onTap: () async => await postsModel.unLike(
                                    postRef: postDoc.reference,
                                    postDoc: postDoc,
                                    post: post,
                                    mainModel: mainModel,
                                  ),
                                )
                              : InkWell(
                                  child: const Icon(
                                    Icons.favorite_border,
                                  ),
                                  onTap: () async => await postsModel.like(
                                    postRef: postDoc.reference,
                                    postDoc: postDoc,
                                    post: post,
                                    mainModel: mainModel,
                                  ),
                                ),
                          title: Text(post.text),
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
