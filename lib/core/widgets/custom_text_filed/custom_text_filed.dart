import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../responsive/responsive.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final double height;
  final bool isPassword;
  final Icon icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.text,
    required this.height,
    required this.icon,
    this.isPassword = false,
    this.validator,
    required this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  late FocusNode _focusNode;
  Color _iconColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _iconColor =
            _focusNode.hasFocus ? const Color(0xff0186c7) : Colors.grey;
      });
    });
  }

  double textSize(context,
      {required double isExtraSmallSize,
      required double isMobileSize,
      required double isMobileLarge,
      required double isIpadSize,
      required double isTabletSize,
      required double isLargeTabletSize,
      required double defaultSize}) {
    return Responsive.isExtraSmall(context)
        ? isExtraSmallSize
        : Responsive.isMobile(context)
            ? isMobileSize
            : Responsive.isMobileLarge(context)
                ? isMobileLarge
                : Responsive.isTablet(context)
                    ? isIpadSize
                    : Responsive.isTablet(context)
                        ? isTabletSize
                        : Responsive.isLargeTablet(context)
                            ? isLargeTabletSize
                            : isLargeTabletSize;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height * .01,
        ),
        TextFormField(
          obscureText: _obscureText && widget.isPassword,
          enabled: true,
          validator: widget.validator,
          focusNode: _focusNode, // Assign the focus node
          controller: widget.controller,
          style: TextStyle(
              fontSize: textSize(context,
                  isExtraSmallSize: 13,
                  isMobileSize: 15,
                  isMobileLarge: 21,
                  isIpadSize: 27,
                  isTabletSize: 32,
                  isLargeTabletSize: 40,
                  defaultSize: 18)),
          cursorHeight: 19,
          decoration: InputDecoration(
            enabled: true,
            focusColor: const Color(0xff0186c7),
            hintText: " ${widget.text}",
            hintStyle: TextStyle(color: _iconColor),
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff0186c7)),
              borderRadius: BorderRadius.circular(15),
            ),
            prefixIcon: Icon(
              widget.icon.icon,
              color: _iconColor, // Change icon color dynamically
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: _iconColor,
                    ),
                  )
                : null,
          ),
          cursorColor: const Color(0xff0186c7),
        ),
      ],
    );
  }
}
