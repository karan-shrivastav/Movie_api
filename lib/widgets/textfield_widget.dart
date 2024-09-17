import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  const TextfieldWidget({
    super.key,
    this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xfff0ebf0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
          fillColor: const Color(0xff1a1a1a),
          hintStyle: const TextStyle(
            fontSize: 13,
          ),
          contentPadding: const EdgeInsets.only(top: 10),
          suffixIcon: InkWell(
              onTap: () {
                controller?.clear();
              },
              child: const Icon(
                IconData(0xef28, fontFamily: 'MaterialIcons'),
              )),
        ),
      ),
    );
  }
}
