import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:OEGlobal/language/app_localization.dart';
import 'package:OEGlobal/ProBaseState/export.dart';
import 'package:OEGlobal/language/language_key.dart' as Lang;

Future<bool> requestCameraStoragePermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.photos,
    Permission.storage,
  ].request();

  bool isAllGranted = true;
  statuses.forEach((key, value) {
    if (!value.isGranted) {
      isAllGranted = false;
    }
  });

  return isAllGranted;
}

void showCameraStoragePermissionDialog(BuildContext context) {
  showConfirmCancel(
    context,
    AppLocalizations.of(context).translate(Lang.Dialog_Title_Notice) ??
        'Notice',
    Platform.isAndroid
        ? AppLocalizations.of(context).translate(
                Lang.Permission_CameraStorage_Message_GrantAccess_Android) ??
            'Please grant Camera and Storage permission from App Settings before proceeding.'
        : AppLocalizations.of(context).translate(
                Lang.Permission_CameraStorage_Message_GrantAccess_Android) ??
            'Please grant Camera and Photos permission from App Settings before proceeding.',
    positive: AppLocalizations.of(context)
            .translate(Lang.Dialog_Action_GoToAppSettings) ??
        'Go to App Settings',
    negative:
        AppLocalizations.of(context).translate(Lang.Dialog_Action_Cancel) ??
            'Cancel',
    confirm: () async {
      await AppSettings.openAppSettings();
    },
  );
}
