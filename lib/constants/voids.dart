import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flash/flash_helper.dart';
import 'package:flash/flash.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

void showFlashDialog(
    {required BuildContext context,
    required MainModel mainModel,
    required TextEditingController textEditingController,
    required void Function(String)? onChanged,
    required String titleString,
    required Color? indicatorColor,
    required Color? barrierColor,
    required Widget Function(BuildContext, FlashController<String>) builder}) {
  context.showFlash<String>(
      persistent: true,
      barrierColor: barrierColor,
      barrierDismissible: true,
      builder: builder);
}
