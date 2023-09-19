import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/models/main/profile_model.dart';

import 'package:flutter_sns_u_02/models/main_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final int followerCount = firestoreUser.followerCount;
    final int plusOnefollowerCount = firestoreUser.followerCount + 1;
    final bool isFollowing =
        mainModel.followingUids.contains(firestoreUser.uid);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        profileModel.croppedFile == null
            ? UserImage(
                length: 100.0,
                userImageURL: firestoreUser.userImageURL,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(160),
                child: Image.file(
                  profileModel.croppedFile!,
                  fit: BoxFit.fill,
                ),
              ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Following : " + firestoreUser.followingCount.toString(),
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 12),
            Text(
              mainModel.followingUids.contains(firestoreUser.uid)
                  ? "Follower : " + plusOnefollowerCount.toString()
                  : "Follower : " + followerCount.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        RoundedButton(
          onPressed: () async => await profileModel.uploadUserImage(
              currentUserDoc: mainModel.currentUserDoc),
          color: Colors.lightGreen,
          text: upLoadText,
          widthRate: 0.85,
        ),
        const SizedBox(
          height: 8,
        ),
        isFollowing
            ? RoundedButton(
                onPressed: () => profileModel.unfollow(
                    mainModel: mainModel, passiveFirestoreUser: firestoreUser),
                color: Theme.of(context).colorScheme.errorContainer,
                text: "Un Follow",
                widthRate: 0.85,
              )
            : RoundedButton(
                onPressed: () => profileModel.follow(
                    mainModel: mainModel, passiveFirestoreUser: firestoreUser),
                color: Colors.lightGreen,
                text: "Follow",
                widthRate: 0.85,
              ),
      ],
    );
  }
}
