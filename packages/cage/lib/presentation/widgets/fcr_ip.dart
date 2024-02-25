import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FcrIp extends StatelessWidget {
  const FcrIp({
    Key? key,
    required this.fcr,
    required this.ip,
    required this.growth,
  }) : super(key: key);

  final dynamic fcr;
  final dynamic ip;
  final String growth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildContent(
          'FCR',
          fcr,
        ),
        _buildContent(
          'IP',
          ip,
        ),
      ],
    );
  }

  Widget _buildContent(String title, dynamic value) {
    return IntrinsicWidth(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: ipFcrTextStyle(),
              ),
              const SizedBox(width: 8),
              // TODO icon increase and decrease
              // (value <= 10)
              //     ? SvgPicture.asset('assets/decrease.svg')
              SvgPicture.asset('assets/icons/increase.svg'),
              const SizedBox(width: 8),
              Text(
                '$value',
                style: ipFcrTextStyle(),
              )
            ],
          ),
          const SizedBox(height: 5.5),
          RichText(
            text: TextSpan(
              // TODO belum ada data nilai pertumbuhan
              text: growth,
              style: const TextStyle(
                color: Color(0xFFDD3E46),
                fontSize: 12,
                fontFamily: bold,
              ),
              children: const [
                TextSpan(
                  text: ' sejak kemarin',
                  // TODO warna increase and decrease
                  style: TextStyle(
                    color: Color(0xFFDD3E46),
                    fontFamily: regular,
                    fontSize: kBodySmall,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Divider(
            color: kGreyScaleColor[200],
            thickness: 1,
            height: 0,
          ),
          const SizedBox(height: 2),
          // TODO belum ada data kondisi baik/kurang
          const Text(
            'Keadaan Kurang Baik',
            style: TextStyle(
              color: Color(0xFFA8A8A8),
              fontFamily: regular,
              fontSize: kBodySmall,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle ipFcrTextStyle() {
    return TextStyle(
      color: indigo,
      fontSize: 16,
      fontFamily: medium,
    );
  }
}
