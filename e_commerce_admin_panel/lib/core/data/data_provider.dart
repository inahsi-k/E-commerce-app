import 'package:e_commerce_admin_panel/models/category.dart';
import 'package:e_commerce_admin_panel/models/sub_category.dart';
import 'package:e_commerce_admin_panel/services/api_services.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  ApiServices services = ApiServices();
  
  final List<Category> _categories = [];
  final List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  final List<SubCategory> _subCategories = [];
  final List<SubCategory> _filteredSubCategories = [];
  List<SubCategory> get subCategories => _filteredSubCategories;
  
}
