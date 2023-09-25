import 'package:expensetrackermobileapp/provider/profile_image_provider.dart';
import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BottomSheetForImagePicking {
  static ImagePicker picker = ImagePicker();
  static XFile? imagePath;
  static bottomSheet(BuildContext context) {
    ProfileImageProvider profileImageProvider =
        Provider.of<ProfileImageProvider>(context, listen: false);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                onTap: () async {
                  imagePath =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (imagePath.runtimeType != Null) {
                    profileImageProvider.selectedImage(imagePath!);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  } else {
                    if (context.mounted) {
                      ReusableSnackBar.showSnackBar(context, "Task failed");
                      Navigator.of(context);
                    }
                  }
                },
                title: const Text("Select Image"),
              )
            ],
          );
        });
  }
}
