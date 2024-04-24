import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

class Harvest extends StatelessWidget {
  const Harvest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164,
      height: 22,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF3EA1F1),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        // TODO belum ada data waktu panen
        child: Text(
          'Day $randomNumber',
          style: const TextStyle(
            color: Color(0xFF3EA1F1),
            fontSize: kBodySmall,
            fontFamily: regular,
          ),
        ),
      ),
    );
  }
}
