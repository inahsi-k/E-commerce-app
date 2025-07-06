import 'package:e_commerce_admin_panel/core/data/data_provider.dart';
import 'package:e_commerce_admin_panel/models/category.dart';
import 'package:e_commerce_admin_panel/models/sub_category.dart';
import 'package:e_commerce_admin_panel/services/api_services.dart';
import 'package:flutter/material.dart';

class SubCategoryProvider extends ChangeNotifier {
  ApiServices services = ApiServices();
  final DataProvider _dataProvider;
  final addSubCategoryFormKey = GlobalKey<FormState>();
  TextEditingController subCategoryNameController = TextEditingController();
  SubCategoryProvider(this._dataProvider);
  Category? selectedCategory;
  SubCategory? subCategoryForUpdate;

  clearFields() {
    subCategoryNameController.clear();
    selectedCategory = null;
    subCategoryForUpdate = null;
  }

  setDataForUpdateCategory(SubCategory? subCategory) {
    if (subCategory != null) {
      subCategoryForUpdate = subCategory;
      subCategoryNameController.text = subCategory.name ?? '';
      for (var elements in _dataProvider.categories) {
        if (elements.sId == subCategory.categoryId) {
          selectedCategory = elements;
          break;
        }
      }
    } else {
      clearFields();
    }

     updateUi() {
      notifyListeners();
    }
  }
}
