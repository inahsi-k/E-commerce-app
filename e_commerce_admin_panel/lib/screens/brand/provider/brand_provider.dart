import 'package:e_commerce_admin_panel/core/data/data_provider.dart';
import 'package:e_commerce_admin_panel/models/brand.dart';
import 'package:e_commerce_admin_panel/models/sub_category.dart';
import 'package:e_commerce_admin_panel/services/api_services.dart';
import 'package:flutter/material.dart';

class BrandProvider extends ChangeNotifier {
  ApiServices services = ApiServices();
  final DataProvider _dataProvider;
  final addBrandFormKey = GlobalKey<FormState>();
  TextEditingController brandNameController = TextEditingController();
  BrandProvider(this._dataProvider);
  Brand? brandForUpdate;
  SubCategory? selectedSubCategory;

  clearFields() {
    brandNameController.clear();
    selectedSubCategory = null;
    brandForUpdate = null;
  }

  setDataForUpdateBrand(Brand? brand) {
    if (brand != null) {
      brandForUpdate = brand;
      brandNameController.text = brand.name ?? '';
      for (var elements in _dataProvider.subCategories) {
        if (elements.sId == brand.subcategoryId?.sId) {
          selectedSubCategory = elements;
          break;
        }
      }
    } else {
      clearFields();
    }

    updateUi(){
      notifyListeners();
    }
  }
}
