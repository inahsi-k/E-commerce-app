import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryPhotoCard extends StatelessWidget {
  final String labelText;
  final VoidCallback onTap;
  final File? imageFile;
  final String? imageUrlForUpdateImage;
  const CategoryPhotoCard({
    super.key,
    required this.labelText,
    required this.onTap,
    this.imageFile, this.imageUrlForUpdateImage,
  });

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                const Color.fromARGB(255, 26, 28, 53),
                const Color.fromARGB(255, 183, 185, 202),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageFile != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: kIsWeb
                      ? Image.network(imageFile?.path ?? '', width: double.infinity, fit: BoxFit.cover)
                      : Image.file(imageFile!, width: double.infinity, fit: BoxFit.cover),
                )
              else if(imageUrlForUpdateImage!=null)
                ClipRRect(
                  borderRadius:BorderRadius.circular(8),
                  child:Image.network(
                    imageUrlForUpdateImage??'',
                    width: double.infinity,
                    fit:BoxFit.cover
                  )
                )
              else
                Icon(Icons.camera_alt),
                SizedBox(height: 10,),
                Text(labelText,style: TextStyle(fontWeight: FontWeight.w700),),
                
            ],
          ),
        ),
      ),
    );
  }
}
