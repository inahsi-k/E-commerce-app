import 'package:e_commerce_admin_panel/common_components/custom_text.dart';
import 'package:e_commerce_admin_panel/core/data/data_provider.dart';
import 'package:e_commerce_admin_panel/models/category.dart';
import 'package:e_commerce_admin_panel/screens/category/components/form.dart';
import 'package:e_commerce_admin_panel/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //CustomText(text: "All categories", size: 14, color: Colors.white, weight: FontWeight.w400),
        SizedBox(
          width: double.infinity,
          child: Consumer<DataProvider>(
            builder: (context, value, child) {
              return DataTable(
                decoration: BoxDecoration(
                  color: componentColors,
                  borderRadius: BorderRadius.circular(10),
                ),
                columnSpacing: 13,
                columns: [
                  DataColumn(
                    label: CustomText(
                      text: "Category",
                      size: 14,
                      color: Colors.white,
                      weight: FontWeight.normal,
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      text: "Date added",
                      size: 14,
                      color: Colors.white,
                      weight: FontWeight.normal,
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      text: "Edit",
                      size: 14,
                      color: Colors.white,
                      weight: FontWeight.normal,
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      text: "Update",
                      size: 14,
                      color: Colors.white,
                      weight: FontWeight.normal,
                    ),
                  ),
                ],
                rows: List.generate(
                  value.categories.length,
                  (index) => categoryDataRow(
                    value.categories[index],
                    delete: () {},
                    edit: () {
                      showAddCategoryForm(
                        context,
                        value.categories[index],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

DataRow categoryDataRow(
  Category categoryInfo, {
  Function? edit,
  Function? delete,
}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Image.network(
              categoryInfo.image ?? '',
              height: 30,
              width: 30,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                return Icon(Icons.error);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(categoryInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(categoryInfo.createdAt ?? '')),
      DataCell(IconButton(onPressed: () {}, icon: Icon(Icons.edit))),
      DataCell(
        IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(Icons.delete),
          color: Colors.white,
        ),
      ),
      DataCell(
        IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(Icons.delete),
          color: Colors.red,
        ),
      ),
    ],
  );
}
