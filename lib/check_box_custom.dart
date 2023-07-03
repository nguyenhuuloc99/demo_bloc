import 'package:flutter/material.dart';
class CustomCheckBox extends StatefulWidget {
  double? size;
  double? iconSize;
  Function(bool) onChange;
  Color? backgroundColor;
  Color? iconColor;
  Color? borderColor;
  IconData? icon;
  bool isChecked;

  CustomCheckBox({
    Key? key,
    this.size,
    this.iconSize,
    required this.onChange,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    this.borderColor,
    required this.isChecked,
  }) : super(key: key);



  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    print("2 Build");
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onChange(isChecked);
        });
      },
      child: AnimatedContainer(
          height: widget.size ?? 25,
          width: widget.size ?? 25,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: isChecked
                  ? widget.backgroundColor ?? Colors.blue
                  : Colors.transparent,
              border: Border.all(color: widget.borderColor ?? Colors.black)),
          child: isChecked
              ? Icon(
            widget.icon ?? Icons.check,
            color: widget.iconColor ?? Colors.white,
            size: widget.iconSize ?? 20,
          )
              : null),
    );
  }
}
