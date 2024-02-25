import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    Key? key,
    required this.onChange,
    required this.isChecked,
  }) : super(key: key);

  final Function onChange;
  final bool isChecked;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChange(isChecked);
        });
      },
      child: AnimatedContainer(
        height: 23,
        width: 23,
        padding: const EdgeInsets.all(2),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: white,
            border: Border.all(color: kDarkColor1)),
        child: isChecked
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: kDarkColor1,
                  border: Border.all(color: kDarkColor1),
                ),
              )
            : null,
      ),
    );
  }
}
