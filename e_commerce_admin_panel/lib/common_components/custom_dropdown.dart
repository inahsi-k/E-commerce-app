import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hintText;
  final T? initialValue;
  final List<T> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final String Function(T) displayItem;
  const CustomDropdown({super.key, this.hintText='Select An Option', required this.onChanged, this.validator, required this.items, this.initialValue, required this.displayItem});

  @override
  Widget build(BuildContext context) {
    return  DropdownButtonFormField<T>(
      isExpanded: true,
      hint: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          hintText,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          maxLines: 1,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: InputDecoration(
        // hintText: 
        // hintStyle: TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
      value: initialValue,
      items: items.map((T item)=>DropdownMenuItem(
        value:item,
        child: Text(displayItem(item),
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        maxLines: 1,))).toList(),
      onChanged:onChanged ,
      validator: validator,
    );
  }
}