import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const AppBarTitle(title: 'Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: defaultMargin,
          top: 13,
          right: defaultMargin,
          bottom: 13,
        ),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.asset('assets/profile_image.png'),
            // const SizedBox(height: 24),
            const Text(
              'Yana',
              style: TextStyle(
                color: Color(0xFF5C6370),
                fontSize: 24,
                fontFamily: medium,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cageBlockSection('number_of_cages', 'Cages', 6),
                    const SizedBox(width: 32),
                    VerticalDivider(
                      thickness: 2,
                      color: kGreyScaleColor[200],
                    ),
                    const SizedBox(width: 32),
                    cageBlockSection('number_of_blocks', 'Blocks', 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildCard('password', 'Change Password'),
            _buildCard('settings', 'Settings'),
            _buildCard('terms', 'Privacy Policy'),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                ),
                onPressed: () {},
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontFamily: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cageBlockSection(String asset, String title, int number) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgPicture.asset('assets/icons/$asset.svg'),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF5C6370),
            fontSize: 16,
            fontFamily: medium,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          number.toString(),
          style: const TextStyle(
            color: Color(0xFF5C6370),
            fontSize: 30,
            fontFamily: medium,
          ),
        ),
      ],
    );
  }

  Card _buildCard(String asset, String title) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/icons/$asset.svg'),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: TextStyle(
                    color: kDarkColor1,
                    fontSize: 16,
                    fontFamily: semiBold,
                  ),
                ),
              ],
            ),
            Icon(
              CupertinoIcons.chevron_right,
              color: kGreyScaleColor[300],
            ),
          ],
        ),
      ),
    );
  }
}
