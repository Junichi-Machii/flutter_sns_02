import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/models/main/profile_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/passive_user_proflie_model.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  PassiveUserProfilePage(
      {super.key, required this.passiveUser, required this.mainModel});

  final FirestoreUser passiveUser;
  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PassiveUserProfileModel passiveUserProfileModel =
        ref.watch(passiveUserProfileProvider);

    final bool isFollowing = mainModel.followingUids.contains(passiveUser.uid);
    final int followerCount = passiveUser.followerCount;
    final int plusOnefollowerCount = passiveUser.followerCount + 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(profileTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserImage(
            length: 100.0,
            userImageURL: passiveUser.userImageURL,
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(passiveUser.uid),
          ),
          const SizedBox(height: 12),
          Text(
            "Following : " + passiveUser.followingCount.toString(),
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 12),
          Text(
            mainModel.followingUids.contains(passiveUser.uid)
                ? "Follower : " + plusOnefollowerCount.toString()
                : "Follower : " + followerCount.toString(),
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 12),
          isFollowing
              ? RoundedButton(
                  onPressed: () => passiveUserProfileModel.unfollow(
                      mainModel: mainModel, passiveUser: passiveUser),
                  color: Theme.of(context).colorScheme.errorContainer,
                  text: "Un Follow",
                  widthRate: 0.85,
                )
              : RoundedButton(
                  onPressed: () => passiveUserProfileModel.follow(
                      mainModel: mainModel, passiveUser: passiveUser),
                  color: Colors.lightGreen,
                  text: "Follow",
                  widthRate: 0.85,
                ),
        ],
      ),
    );
  }
}
