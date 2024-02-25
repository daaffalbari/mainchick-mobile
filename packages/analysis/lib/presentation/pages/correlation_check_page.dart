import 'package:core/presentation/widgets/app_bar_actions.dart';
import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/presentation/widgets/custom_checkbox.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CorrelationCheckPage extends StatefulWidget {
  const CorrelationCheckPage({Key? key}) : super(key: key);

  static const routeName = '/correlation-check';

  @override
  State<CorrelationCheckPage> createState() => _CorrelationCheckPageState();
}

class _CorrelationCheckPageState extends State<CorrelationCheckPage> {
  List<Map> items = [
    {'name': 'Temperature', 'isChecked': false},
    {'name': 'Ammonia', 'isChecked': false},
    {'name': 'Humidity', 'isChecked': false},
    {'name': 'Death', 'isChecked': false},
    {'name': 'Success Ratio (IP)', 'isChecked': false},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _showAlert(context));
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 23,
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/check_correlation_guide.png'),
            const SizedBox(height: 16),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Choose at Least One ',
                style: TextStyle(
                  color: Color(0xFF5C6370),
                  fontFamily: regular,
                  fontSize: kBodyMedium,
                ),
                children: [
                  TextSpan(
                    text: 'Defining Factor ',
                    style: TextStyle(
                      color: Color(0xFF5C6370),
                      fontFamily: bold,
                      fontSize: kBodyMedium,
                    ),
                  ),
                  TextSpan(
                    text: 'And One ',
                    style: TextStyle(
                      color: Color(0xFF5C6370),
                      fontFamily: regular,
                      fontSize: kBodyMedium,
                    ),
                  ),
                  TextSpan(
                    text: 'Result ',
                    style: TextStyle(
                      color: Color(0xFF5C6370),
                      fontFamily: bold,
                      fontSize: kBodyMedium,
                    ),
                  ),
                  TextSpan(
                    text:
                        'to Determine the Relationship Between Variables Related to the Condition of the Cage.',
                    style: TextStyle(
                      color: Color(0xFF5C6370),
                      fontFamily: regular,
                      fontSize: kBodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Understand',
                  style: TextStyle(
                    fontFamily: medium,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeading(),
        title: const AppBarTitle(title: 'Check Correlation manually'),
        actions: appBarActions(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          defaultMargin,
          24,
          defaultMargin,
          32,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 11,
                horizontal: 18,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF8FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/information.svg'),
                  const SizedBox(width: 20),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'Choose at Least One ',
                        style: TextStyle(
                          color: indigo,
                          fontFamily: regular,
                          fontSize: kBodySmall,
                        ),
                        children: [
                          TextSpan(
                            text: 'Defining Factor ',
                            style: TextStyle(
                              color: indigo,
                              fontFamily: bold,
                              fontSize: kBodySmall,
                            ),
                          ),
                          TextSpan(
                            text: 'And One ',
                            style: TextStyle(
                              color: indigo,
                              fontFamily: regular,
                              fontSize: kBodySmall,
                            ),
                          ),
                          TextSpan(
                            text: 'Result ',
                            style: TextStyle(
                              color: indigo,
                              fontFamily: bold,
                              fontSize: kBodySmall,
                            ),
                          ),
                          TextSpan(
                            text:
                                'to Determine the Relationship Between Variables.',
                            style: TextStyle(
                              color: indigo,
                              fontFamily: regular,
                              fontSize: kBodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildCheckBox('Defining Factor'),
            const SizedBox(height: 16),
            _buildCheckBox('Result'),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 62,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Check Correlation',
                  style: TextStyle(
                    fontFamily: medium,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckBox(String title) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: indigo,
              fontFamily: medium,
              fontSize: kBodyLarge,
            ),
          ),
          Divider(
            color: kGreyScaleColor[300],
            thickness: 1,
          ),
          Column(
            children: items.map((items) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    CustomCheckbox(
                      onChange: (value) {
                        setState(() {
                          items['isChecked'] = value;
                        });
                        debugPrint('${items['name']}');
                        debugPrint('${items['isChecked']}');
                      },
                      isChecked: items['isChecked'],
                    ),
                    const SizedBox(width: 13),
                    Text(
                      items['name'],
                      style: TextStyle(
                        color: kDarkColor1,
                        fontFamily: regular,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
