import 'package:chatbot/domain/entities/prediction.dart';
import 'package:core/presentation/widgets/app_bar_actions.dart';
import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:core/presentation/pages/home_page.dart';

class PredictionDetailPage extends StatefulWidget {
  const PredictionDetailPage({Key? key, required this.prediction})
      : super(key: key);

  final Prediction prediction;
  static const routeName = '/prediction-detail';

  @override
  State<PredictionDetailPage> createState() => _PredictionDetailPageState();
}

class _PredictionDetailPageState extends State<PredictionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const AppBarLeading(),
        title: const AppBarTitle(title: 'Detail Result'),
        actions: appBarActions(context),
      ),
      backgroundColor: greyBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: Markdown(
                padding: const EdgeInsets.all(0),
                data: widget.prediction.candidates,
                styleSheet: MarkdownStyleSheet(
                  h2: TextStyle(
                      fontSize: 28, color: kDarkColor1, fontFamily: medium),
                  h3: TextStyle(
                      fontSize: 24, color: kDarkColor1, fontFamily: medium),
                  p: TextStyle(fontSize: 16, color: grey, fontFamily: regular),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomePage.routeName,
                    (route) => false,
                  );
                },
                child: const Text(
                  'Go to Cage',
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
}
