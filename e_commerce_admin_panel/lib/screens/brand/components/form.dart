import 'package:e_commerce_admin_panel/common_components/custom_dropdown.dart';
import 'package:e_commerce_admin_panel/common_components/custom_text.dart';
import 'package:e_commerce_admin_panel/common_components/custom_textformfield.dart';
import 'package:e_commerce_admin_panel/core/data/data_provider.dart';
import 'package:e_commerce_admin_panel/models/brand.dart';
import 'package:e_commerce_admin_panel/models/sub_category.dart';
import 'package:e_commerce_admin_panel/screens/brand/provider/brand_provider.dart';
import 'package:e_commerce_admin_panel/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandForm extends StatelessWidget {
  final Brand? brand;
  const BrandForm({super.key, this.brand});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: Provider.of<BrandProvider>(context).addBrandFormKey,
        child: Container(
          width: size.width * 0.4,
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
                    Flexible(
                      flex: 1,
                      child: Consumer<BrandProvider>(
                        builder: (context, provider, child) {
                          return CustomDropdown(
                            initialValue: provider.selectedSubCategory,
                            hintText:
                                provider.selectedSubCategory?.name ??
                                'Select Sub Category',
                            onChanged: (value) {
                              if (value != null) {
                                provider.selectedSubCategory = value;
                                provider.notifyListeners();
                              }
                            },
                            items:
                                Provider.of<DataProvider>(context).subCategories,
                            displayItem:
                                (SubCategory? subCategory) => subCategory?.name ?? '',
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a Sub Category';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width:10
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomTextformfield(
                        hintText: "Sub Brand Name",
                        controller:
                            Provider.of<BrandProvider>(
                              context,
                            ).brandNameController,
                        inputType: TextInputType.text,
                        lines: 1,
                        onSave: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a brand name';
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
                        if (Provider.of<BrandProvider>(
                          context,
                        ).addBrandFormKey.currentState!.validate()) {
                          Provider.of<BrandProvider>(
                            context,
                          ).addBrandFormKey.currentState!.save();
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

void showAddBrandForm(BuildContext context, Brand? brand) {
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
          text: "Add Brand",
          size: 17,
          color: Colors.white,
          weight: FontWeight.normal,
        ),
        content: SingleChildScrollView(child: BrandForm(brand: brand)),
      );
    },
  );
}
