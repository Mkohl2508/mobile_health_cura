import 'package:flutter/material.dart';

class TextInputLogin extends StatefulWidget {
  final Icon? startIcon;
  final Color? verticalDevColor;
  final String? textHint;
  final bool isPassword;
  final TextEditingController? controller;
  const TextInputLogin(
      {Key? key,
      Icon? icon,
      Color? color,
      String? hint,
      bool isPassword = false,
      this.controller})
      : startIcon = icon,
        textHint = hint,
        verticalDevColor = color,
        // ignore: prefer_initializing_formals
        isPassword = isPassword,
        super(key: key);

  @override
  _TextInputLoginState createState() => _TextInputLoginState(
      startIcon, verticalDevColor, textHint, isPassword, controller);
}

class _TextInputLoginState extends State<TextInputLogin> {
  final Icon? startIcon;
  final Color? verticalDevColor;
  final String? textHint;
  final bool isPassword;
  final TextEditingController? controller;

  _TextInputLoginState(this.startIcon, this.verticalDevColor, this.textHint,
      this.isPassword, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      color: Colors.white,
      child: Row(
        children: [
          Padding(padding: const EdgeInsets.only(left: 15), child: startIcon),
          VerticalDivider(
            color: verticalDevColor,
            thickness: 3,
            indent: 13,
            endIndent: 13,
            width: 20,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              obscureText: isPassword,
              enableSuggestions: !isPassword,
              autocorrect: !isPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: textHint,
              ),
              textAlign: TextAlign.start,
            ),
          ))
        ],
      ),
    );
  }
}
