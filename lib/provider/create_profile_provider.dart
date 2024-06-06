import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProfileProvider extends ChangeNotifier {
  File? profilePic;
  File? selectImage;
  String? filePath;

  List<File> _images = [];

  List<File> get images => _images;

  void setProfilePic(File path) {
    profilePic = path;
    notifyListeners();
  }

  void setImage(File path) {
    selectImage = path;
    notifyListeners();
  }

  void setFilePath(String path) {
    filePath = path;
    notifyListeners();
  }

  Future<void> pickImageForProfile(BuildContext context) async {
    try {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button to dismiss
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cmaera/Gallery'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Choose from below'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Camera'),
                onPressed: () async {
                   Navigator.of(context).pop();
                  try {
                    debugPrint("Start");
                    final returnImage = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (returnImage != null) {
                      setProfilePic(File(returnImage.path));
                      // provider.setImage(File(returnImage.path));

                      String filePath = returnImage.path;
                      setFilePath(filePath);
                      saveImageFilePath(filePath);
                    }
                  } catch (e) {
                    debugPrint("Got error : $e");
                  }
                },
              ),
              TextButton(
                child: Text('Gallery'),
                onPressed: () async{
                  Navigator.of(context).pop();
                  try {
                    debugPrint("Start");
                    final returnImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (returnImage != null) {
                      setProfilePic(File(returnImage.path));
                      // provider.setImage(File(returnImage.path));

                      String filePath = returnImage.path;
                      setFilePath(filePath);
                      saveImageFilePath(filePath);
                    }
                  } catch (e) {
                    debugPrint("Got error : $e");
                  }
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      debugPrint("Got error : $e");
    }
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
        // provider.setImage(File(returnImage.path));

        String filePath = returnImage.path;
        setFilePath(filePath);
        saveImageFilePath(filePath);
      }
    } catch (e) {
      debugPrint("Got error : $e");
    }
  }

  Future<void> saveImageFilePath(String filePath) async {
    debugPrint("Enter into set shared function : $filePath");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('camera_image_file_path', filePath);
    final res = await prefs.getString('camera_image_file_path');
    debugPrint(
        "the saved file path is : ${prefs.getString('camera_image_file_path')}");
    setImage(File(prefs.getString('camera_image_file_path').toString()));
    debugPrint("$selectImage");
    setToList();
  }

  Future<void> setToList() async {
    debugPrint("Set to list");
    final prefs = await SharedPreferences.getInstance();
    images.add(File(prefs.getString('camera_image_file_path').toString()));
    notifyListeners();
  }

  Future<void> loadImagesFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    print("aaaaaaaaaaaaaaa ${prefs.getString('camera_image_file_path')}");
    setToList();
    notifyListeners();
    // final List<String>? imagePaths = prefs.getStringList('camera_image_file_path');
    // if (imagePaths != null) {
    //   _images = imagePaths.map((path) => File(path)).toList();
    //   notifyListeners();
    // }
  }

  Future<void> deleteImage(int index) async {
    _images.removeAt(index);
    // await saveImagesToPreferences();
    notifyListeners();
  }

  void initializeProvider() {
    loadImagesFromPreferences();
  }
}
