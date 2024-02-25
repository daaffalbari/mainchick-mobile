import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/string_extension.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/cage.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
    required this.cage,
  }) : super(key: key);

  final Cage cage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Kandang ${cage.key.getLastChar(1)}",
          style: TextStyle(
            color: indigo,
            fontSize: kBodyLarge,
            fontFamily: medium,
          ),
        ),
        const Text(
          'Lihat Detail',
          style: TextStyle(
            color: Color(0xFF3EA1F1),
            fontSize: 16,
            fontFamily: regular,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
