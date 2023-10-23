import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/rounded_text_field.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/models/edit_profile_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final EditProfileModel editProfileModel = ref.watch(editProfileProvider);
    final TextEditingController textEditingController =
        TextEditingController(text: editProfileModel.userName);

    return Scaffold(
      appBar: AppBar(
        title: const Text(editProfilePageTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          editProfileModel.croppedFile == null
              ? UserImage(
                  length: 100.0,
                  userImageURL: firestoreUser.userImageURL,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(160),
                  child: Image.file(
                    editProfileModel.croppedFile!,
                    fit: BoxFit.fill,
                  ),
                ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedTextField(
                  keyboardType: TextInputType.name,
                  onChanged: (value) => editProfileModel.userName = value,
                  controller: textEditingController,
                  color: Colors.blueGrey,
                  hintText: firestoreUser.userName,
                  labelText: "New Profile Name",
                  prefixIcon: const Icon(Icons.account_box)),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Center(
            child: RoundedButton(
                onPressed: () => editProfileModel.updateUserName(
                      context: context,
                      mainModel: mainModel,
                    ),
                color: Colors.lightGreen,
                text: upDateText,
                widthRate: 0.85),
          ),
        ],
      ),
    );
  }
}
