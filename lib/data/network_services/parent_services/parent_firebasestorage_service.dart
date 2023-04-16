import 'dart:io' as io;
import 'dart:math';

import 'package:image_picker/image_picker.dart';

class Parent_firebasestorage_service {

  
  Future<String> pick_img_and_returnpath() async {
    XFile? pickedimg;

    pickedimg = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedimg != null) {
      // file = io.File(pickedimg!.path);
      return pickedimg.path.toString();
    }

    return "";
  }
}
