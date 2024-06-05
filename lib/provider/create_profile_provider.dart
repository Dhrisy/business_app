import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProfileProvider extends ChangeNotifier {
  File? selectImage;
  String? filePath;


  void setImage(File path) {
    selectImage = path;
    notifyListeners();
  }

  void setFilePath(String path){
filePath = path;
notifyListeners();
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    debugPrint("Clicked button");

    try {
      debugPrint("Start");
      final returnImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (returnImage != null) {
        debugPrint("path not null");
        final provider =
            Provider.of<CreateProfileProvider>(context, listen: false);
        provider.setImage(File(returnImage.path));

        String filePath = returnImage.path;
        setFilePath(filePath);
        saveImageFilePath(filePath);
      }
    } catch (e) {
      debugPrint("Got error : $e");
    }
  }

  Future<void> saveImageFilePath(String filePath) async {
    print("Enter into set shared function");
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('camera_image_file_path', filePath);
    print("the saved file path is : $result");
  }


Future<String?> getImageFilePath() async {
  final prefs = await SharedPreferences.getInstance();
  final res = prefs.getString('camera_image_file_path');
  print("$res");
  return prefs.getString('camera_image_file_path');
}

}
