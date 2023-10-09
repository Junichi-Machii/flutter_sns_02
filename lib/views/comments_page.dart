import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/details/post_like_button.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

class CommentsPage extends ConsumerWidget {
  const CommentsPage(
      {super.key,
      required this.mainModel,
      required this.postDoc,
      required this.post});

  final MainModel mainModel;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  final Post post;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final commentDocs = commentsModel.commentDocs;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: commentDocs.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: RoundedButton(
                    onPressed: () async =>
                        commentsModel.onReload(postDoc: postDoc),
                    color: Theme.of(context).colorScheme.inversePrimary,
                    text: "Reload",
                    widthRate: 0.85,
                  ),
                ),
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
                    onRefresh: () async =>
                        await commentsModel.onRefresh(postDoc: postDoc),
                    // onLoading: homeModel.onLoading,
                    // header: WaterDropHeader(),
                    child: ListView.builder(
                      itemCount: commentDocs.length,
                      itemBuilder: (context, index) {
                        final postDoc = commentDocs[index];
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
                                            ? mainModel
                                                .firestoreUser.userImageURL
                                            : post.imageURL),
                                    Text(
                                      post.text,
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.comment),
                                          onPressed: () async =>
                                              await commentsModel.init(
                                                  context: context,
                                                  mainModel: mainModel,
                                                  postDoc: postDoc,
                                                  post: post),
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
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
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.new_label),
        onPressed: () => commentsModel.showCommentDialog(
            postDoc: postDoc, context: context, mainModel: mainModel),
      ),
    );
  }
}
