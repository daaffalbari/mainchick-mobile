import 'package:analysis/presentation/pages/analysis_page.dart';
import 'package:cage/presentation/pages/cage_list_page.dart';
import 'package:feed/presentation/pages/feed_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:history/presentation/pages/history_page.dart';
import 'package:profile/presentation/pages/profile_page.dart';

import '../../styles/colors.dart';
import '../../styles/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CageListPage(),
    const AnalysisPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const CageListPage();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      currentScreen = _screens[_selectedIndex];
    });
  }

  Color _color(int index) =>
      _selectedIndex == index ? kPrimaryColor : kDisableButtonColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackground,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, FeedPage.routeName);
          },
          elevation: 3,
          backgroundColor: const Color(0xFF3CA2F2),
          child: SvgPicture.asset('assets/icons/feed.svg'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(33),
        ),
        child: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.only(bottom: 40),
            height: 98,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildGestureDetector(
                  0,
                  'assets/icons/cage.svg',
                  'Cage',
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AnalysisPage.routeName);
                  },
                  child: SizedBox(
                    width: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset('assets/icons/analysis.svg',
                            color: _color(1)),
                        Text(
                          'Analysis',
                          style: TextStyle(
                            color: _color(1),
                            fontSize: kBodySmall,
                            fontFamily: regular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Feed',
                  style: TextStyle(
                    color: kDisableButtonColor,
                    fontSize: kBodySmall,
                    fontFamily: regular,
                  ),
                ),
                _buildGestureDetector(
                  2,
                  'assets/icons/history.svg',
                  'History',
                ),
                _buildGestureDetector(
                  3,
                  'assets/icons/profile.svg',
                  'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGestureDetector(
    int index,
    String asset,
    String text,
  ) {
    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
      },
      child: SizedBox(
        width: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              asset,
              color: _color(index),
            ),
            Text(
              text,
              style: TextStyle(
                color: _color(index),
                fontSize: kBodySmall,
                fontFamily: regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
