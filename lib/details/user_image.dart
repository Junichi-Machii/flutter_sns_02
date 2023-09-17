import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/details/circle_image.dart';

class UserImage extends StatelessWidget {
  const UserImage(
      {super.key, required this.length, required this.userImageURL});

  final double length;
  final String userImageURL;

  @override
  Widget build(BuildContext context) {
    return userImageURL.isEmpty
        ? Container(
            width: length,
            height: length,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightGreen),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_sharp,
              size: length,
            ),
          )
        : CircleImage(length: length, image: NetworkImage(userImageURL));
  }
}
