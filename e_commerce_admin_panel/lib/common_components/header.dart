import 'package:e_commerce_admin_panel/common_components/custom_text.dart';
import 'package:e_commerce_admin_panel/utils/contants.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const Header({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: text,
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        Spacer(),
        Flexible(
          flex:1,
          child: TextField(
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              suffixIconColor: Colors.white,
              hintText: "Search",
              filled: true,
              fillColor: componentColors,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              suffixIcon: IconButton(onPressed:onPressed, icon: Icon(Icons.search)),
            ),
          ),
        ),
        SizedBox(width:10),
        Flexible(
          flex:1,
          child: Card(
            color: componentColors,
            elevation: 4,
            child: ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: IconButton(onPressed: (){}, icon: Icon(Icons.person)),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down_outlined)),
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(20)) ),
              title: Text(
                'Hi ishani',
                //maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        )
    
      ],
    );
  }
}
