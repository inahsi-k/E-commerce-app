import 'package:e_commerce_admin_panel/common_components/custom_text.dart';
import 'package:e_commerce_admin_panel/common_components/header.dart';
import 'package:e_commerce_admin_panel/screens/sub_category/components/form.dart';
import 'package:e_commerce_admin_panel/screens/sub_category/components/sub_category_list.dart';
import 'package:e_commerce_admin_panel/utils/contants.dart';
import 'package:flutter/material.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 71, 70, 102),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Header(text: 'Sub Categories', onPressed: () {}),
                SizedBox(height: 20),
                Row(
                  children: [
                    CustomText(
                      text: "My SubCategories",
                      size: 17,
                      color: Colors.white,
                      weight: FontWeight.w500,
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: componentColors,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        showAddSubCategoryForm(context, null);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 9),
                          CustomText(
                            text: "Add new",
                            size: 12,
                            color: Colors.white,
                            weight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.restore, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SubCategoryList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
