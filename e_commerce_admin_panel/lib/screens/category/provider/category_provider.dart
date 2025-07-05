import 'dart:io';
import 'package:e_commerce_admin_panel/core/data/data_provider.dart';
import 'package:e_commerce_admin_panel/services/api_services.dart';
import 'package:e_commerce_admin_panel/models/category.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class CategoryProvider extends ChangeNotifier {
  ApiServices services = ApiServices();
  Category? categoryToUpdate;
  TextEditingController categoryController = TextEditingController();
  final DataProvider _dataProvider;
  DataProvider get dataProvider => _dataProvider;
  final addCategoryFormKey = GlobalKey<FormState>();
  File? selectedImage;
  XFile? imgXFile;
  CategoryProvider(this._dataProvider);

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path); //to show in device
      imgXFile = image; //not dart core: conatins metadata,filename, bytes
      notifyListeners();
    }
  }


  setDataForUpdateCategory(Category? category) {
    if (category != null) {
      clearFields();
      categoryToUpdate = category;
      categoryController.text = category.name ?? '';
    } else {
      clearFields();
    }
  }


  //add the textformfields
  Future<http.MultipartRequest> createFormData({
    required XFile? imgXFile,
    required Map<String, String> formData,
    required Uri uri,
  }) async {
    final request = http.MultipartRequest('POST', uri);

    // Add image file if available
    if (imgXFile != null) {
      final filename = kIsWeb ? imgXFile.name : basename(imgXFile.path);
      final mimeType =
          lookupMimeType(filename)?.split('/') ?? ['image', 'jpeg'];
      http.MultipartFile multipartFile;
      if (kIsWeb) {
        // Web: read bytes and send from memory
        Uint8List byteImg = await imgXFile.readAsBytes();
        multipartFile = http.MultipartFile.fromBytes(
          'img',
          byteImg,
          filename: filename,
          contentType: MediaType(mimeType[0], mimeType[1]),
        );
      } else {
        // Mobile/Desktop: send from path
        multipartFile = await http.MultipartFile.fromPath(
          'img',
          imgXFile.path,
          filename: filename,
          contentType: MediaType(mimeType[0], mimeType[1]),
        );
      }
      request.files.add(multipartFile);
    }
    return request;
  }


  clearFields() {
    categoryController.clear();
    selectedImage = null;
    imgXFile = null;
    categoryToUpdate = null;
  }
}
