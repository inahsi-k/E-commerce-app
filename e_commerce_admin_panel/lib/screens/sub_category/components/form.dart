import 'package:e_commerce_admin_panel/common_components/custom_dropdown.dart';
import 'package:e_commerce_admin_panel/common_components/custom_text.dart';
import 'package:e_commerce_admin_panel/common_components/custom_textformfield.dart';
import 'package:e_commerce_admin_panel/core/data/data_provider.dart';
import 'package:e_commerce_admin_panel/models/category.dart';
import 'package:e_commerce_admin_panel/models/sub_category.dart';
import 'package:e_commerce_admin_panel/screens/sub_category/provider/sub_category_provider.dart';
import 'package:e_commerce_admin_panel/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubCategoryForm extends StatelessWidget {
  final SubCategory? subCategory;
  const SubCategoryForm({super.key, this.subCategory});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: Provider.of<SubCategoryProvider>(context).addSubCategoryFormKey,
        child: Container(
          width: size.width * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 71, 70, 102),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Consumer<SubCategoryProvider>(
                        builder: (context, provider, child) {
                          return CustomDropdown(
                            initialValue: provider.selectedCategory,
                            hintText:
                                provider.selectedCategory?.name ??
                                'Select category',
                            onChanged: (value) {
                              if (value != null) {
                                provider.selectedCategory = value;
                                provider.notifyListeners();
                              }
                            },
                            items:
                                Provider.of<DataProvider>(context).categories,
                            displayItem:
                                (Category? category) => category?.name ?? '',
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a category';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTextformfield(
                        hintText: "Sub Category Name",
                        controller:
                            Provider.of<SubCategoryProvider>(
                              context,
                            ).subCategoryNameController,
                        inputType: TextInputType.text,
                        lines: 1,
                        onSave: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a sub category name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: componentColors,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 7),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: componentColors,
                      ),
                      onPressed: () {
                        if (Provider.of<SubCategoryProvider>(
                          context,
                        ).addSubCategoryFormKey.currentState!.validate()) {
                          Provider.of<SubCategoryProvider>(
                            context,
                          ).addSubCategoryFormKey.currentState!.save();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showAddSubCategoryForm(BuildContext context, SubCategory? subCategory) {
  showDialog(
    barrierColor: Colors.black45,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: const Color.fromARGB(255, 71, 70, 102)),
        ),
        backgroundColor: componentColors,
        title: CustomText(
          text: "Add Category",
          size: 17,
          color: Colors.white,
          weight: FontWeight.normal,
        ),
        content: SubCategoryForm(subCategory: subCategory),
      );
    },
  );
}
