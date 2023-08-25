
import 'package:flutter/material.dart';

class MySearchField extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? iconColor;
  final Function? onFieldSubmitted;
  final Function? onTab;
  final Function? onChanged;
   MySearchField({super.key, 
     this.onFieldSubmitted,
     this.onTab,
     this.onChanged, 
     this.color,
     this.iconColor,
     
     required this.title, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     // margin: const EdgeInsets.symmetric(vertical: defaultmargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color??Colors.grey.shade200,
      ),
      child: TextFormField(
    //     onFieldSubmitted: (_) {
    //       onFieldSubmitted!();
    //     },
    //     onChanged: (value) {
    //       onChanged!(value);
    //     },
    //     onTap: () {

    //  onTab!();
    //     },
        decoration:  InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: InputBorder.none,
          prefixIcon:  Icon(
            Icons.search,
            size: 25,
            color: iconColor??Colors.black26,
          ),
        ),
      ),
    );
  }
}