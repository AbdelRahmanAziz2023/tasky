import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   const CustomTextFormField({super.key, required this.name,required this.hintText,this.maxLines,required this.controller,this.validator});
  final String name;
  final String hintText;
  final int? maxLines;
  final TextEditingController controller;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        SizedBox(height: 8),
        TextFormField(
          enabled: true,
          readOnly: false,
          controller: controller,
          style: Theme.of(context).textTheme.displaySmall,
          cursorColor: Colors.white,
          maxLines:maxLines ,
          validator: validator != null ? (value) => validator!(value) : null,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
