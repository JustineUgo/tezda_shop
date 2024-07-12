import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@singleton
class EcoImageService {
  final ImagePicker picker;

  EcoImageService(this.picker);
  Future<File?> pickImage(BuildContext context,{required ImageSource source}) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      // Check if the file size is more than 3MB
      if (fileSize > 3 * 1024 * 1024) {
        // 3MB in bytes
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('File too large'),
              content: const Text('The selected image is larger than 3MB. Please select a smaller image.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        return file;
      }
    } 
    
  }
}
