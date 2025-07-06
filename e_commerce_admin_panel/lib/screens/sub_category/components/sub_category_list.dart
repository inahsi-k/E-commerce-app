import 'package:e_commerce_admin_panel/common_components/custom_text.dart';
import 'package:e_commerce_admin_panel/core/data/data_provider.dart';
import 'package:e_commerce_admin_panel/models/sub_category.dart';
import 'package:e_commerce_admin_panel/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Color> colors = [
  const Color.fromARGB(255, 58, 139, 201),
  const Color.fromARGB(255, 224, 54, 111),
  Colors.purple,
  Colors.red
];

class SubCategoryList extends StatelessWidget {
  const SubCategoryList({super.key});

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
                      text: "Sub Category",
                      size: 14,
                      color: Colors.white,
                      weight: FontWeight.normal,
                    ),
                  ),
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
                  value.subCategories.length,
                  (index) => subCategoryDataRow(index+1,value.subCategories[index],delete: () {}, edit: () {}),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

DataRow subCategoryDataRow(
  int index,
  SubCategory subCategory, {
  Function? edit,
  Function? delete,
}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
              child: Text(index.toString(), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(subCategory.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(subCategory.categoryId?.name ?? '')),
      DataCell(Text(subCategory.createdAt ?? '')),
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
