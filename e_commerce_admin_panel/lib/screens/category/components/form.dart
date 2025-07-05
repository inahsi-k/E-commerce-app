// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_admin_panel/common_components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_admin_panel/common_components/category_photo_card.dart';
import 'package:e_commerce_admin_panel/common_components/custom_textformfield.dart';
import 'package:e_commerce_admin_panel/models/category.dart';
import 'package:e_commerce_admin_panel/screens/category/provider/category_provider.dart';
import 'package:e_commerce_admin_panel/utils/contants.dart';

class CategoryForm extends StatelessWidget {
  final Category? category;
  const CategoryForm({super.key, this.category});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: Provider.of<CategoryProvider>(context).addCategoryFormKey,
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
                Consumer<CategoryProvider>(
                  builder: (context, value, child) {
                    return CategoryPhotoCard(
                      imageFile: value.selectedImage,
                      imageUrlForUpdateImage: category?.image,
                      labelText: "Category",
                      onTap: () {
                        value.pickImage();
                      },
                    );
                  },
                ),
                SizedBox(height: 18),
                CustomTextformfield(
                  hintText: "Category Name",
                  controller:
                      Provider.of<CategoryProvider>(context).categoryController,
                  inputType: TextInputType.text,
                  lines: 1,
                  validator: (value) {
                    if (value == null) {
                      return "Please enter a category name";
                    }
                    return null;
                  },
                  onSave: (value) {
                    // handle save logic here
                  },
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
                        Provider.of<CategoryProvider>(context).clearFields();
                        
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
                        if (Provider.of<CategoryProvider>(
                          context,
                        ).addCategoryFormKey.currentState!.validate()) {
                          Provider.of<CategoryProvider>(
                            context,
                          ).addCategoryFormKey.currentState!.save();
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

void showAddCategoryForm(BuildContext context, Category? category) {
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
        content: CategoryForm(category: category),
      );
    },
  );
}
