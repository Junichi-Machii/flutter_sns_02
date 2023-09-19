import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/models/main/profile_model.dart';

import 'package:flutter_sns_u_02/models/main_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ProfileModel profileModel = ref.watch(profileProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        profileModel.croppedFile == null
            ? Container(
                // alignment: Alignment.center,
                child: UserImage(
                length: 100.0,
                userImageURL: mainModel.firestoreUser.userImageURL,
              ))
            : ClipRRect(
                borderRadius: BorderRadius.circular(160),
                child: Image.file(
                  profileModel.croppedFile!,
                  fit: BoxFit.fill,
                ),
              ),
        SizedBox(
          height: 8,
        ),
        RoundedButton(
          onPressed: () async => await profileModel.uploadUserImage(
              currentUserDoc: mainModel.currentUserDoc),
          color: Colors.lightGreen,
          text: 'Up Loading',
          widthRate: 0.85,
        )
      ],
    );
  }
}
