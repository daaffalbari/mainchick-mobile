import 'package:core/presentation/widgets/app_bar_actions.dart';
import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

class SolutionPage extends StatefulWidget {
  const SolutionPage({Key? key}) : super(key: key);

  static const routeName = '/solution';

  @override
  State<SolutionPage> createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _pageOne(),
      _pageTwo(),
      _pageThree(),
      _pageFour(),
      _pageFive(),
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: const AppBarLeading(),
        title: const AppBarTitle(title: 'Solution'),
        actions: appBarActions(context),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          return pages[index];
        },
        onPageChanged: (page) {
          setState(() {
            _activePage = page;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buildContent(
    String image,
    String title,
    String description,
    Widget button,
  ) {
    return Stack(
      children: [
        Image.asset(image),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          // width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: defaultMargin,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: kDarkColor1,
                    fontFamily: medium,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(
                    color: kGreyScaleColor[600],
                    fontFamily: regular,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _activePage == index
                          ? Container(
                              width: 30,
                              height: 11,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFF29C38),
                              ),
                            )
                          : const Icon(
                              Icons.circle,
                              color: Color(0xFFC4C4C4),
                              size: 11,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                button,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOneButton(
    String text,
    VoidCallback voidCallback,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: voidCallback,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: medium,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTwoButton() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                _previousPage();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: const BorderSide(
                  color: Color(0xFFE0E0E0),
                ),
              ),
              child: Text(
                'Back',
                style: TextStyle(
                  color: kGreyScaleColor[500],
                  fontFamily: medium,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                _nextPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontFamily: medium,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _pageOne() {
    return _buildContent(
      'assets/solution/first_solution.png',
      'know the causative factors',
      'Erratic weather factors, as well as indoor temperature conditions that can cause chickens to die',
      _buildOneButton(
        'Continue',
        _nextPage,
      ),
    );
  }

  Widget _pageTwo() {
    return _buildContent(
      'assets/solution/second_solution.png',
      'Always Provide Water During High Temperatures',
      'When the temperature reaches 50 degrees, provide enough water in the coop and don\'t empty it because the average chicken will feel thirsty',
      _buildTwoButton(),
    );
  }

  Widget _pageThree() {
    return _buildContent(
      'assets/solution/third_solution.png',
      'Avoid Feeding During the Day When the Temperature Is Over 60°C',
      'Feeding the chickens during the day when the temperature is above 60 degrees will affect the chickens being out of control at night',
      _buildTwoButton(),
    );
  }

  Widget _pageFour() {
    return _buildContent(
      'assets/solution/fourth_solution.png',
      'Keep the Cage Always Clean',
      'Do not let there be a lot of dirt left in parts of the cage, clumped chicken manure will affect humidity',
      _buildTwoButton(),
    );
  }

  Widget _pageFive() {
    return _buildContent(
      'assets/solution/fifth_solution.png',
      'Make Sure All Stages Are Applied',
      'If everything is maintained, the humidity in the chicken coop will be controlled and the temperature in the coop will return to normal',
      _buildOneButton(
        'Got it',
        () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.decelerate,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 1),
      curve: Curves.decelerate,
    );
  }
}
