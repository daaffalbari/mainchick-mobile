import 'package:analysis/presentation/pages/solution_page.dart';
import 'package:cage/presentation/provider/cage_list_notifier.dart';
import 'package:core/presentation/widgets/app_bar_actions.dart';
import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/presentation/widgets/cutom_tab_bar.dart';
import 'package:core/presentation/widgets/loading_indicator.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/date_extension.dart';
import 'package:core/utils/state_enum.dart';
import 'package:cage/presentation/pages/cage_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'correlation_check_page.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  static const routeName = '/analysis';

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> myTabs = [
    Tab(text: 'Humidity'),
    Tab(text: 'Temperature'),
    Tab(text: 'Ammonia'),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CageListNotifier>(context, listen: false).fetchCage());
    _tabController = TabController(
      length: myTabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = DateFormat('MMMM y').format(now);
    final weekOfMonth = now.weekOfMonth;

    String weekDescription() {
      if (weekOfMonth == 1) {
        return "st";
      } else if (weekOfMonth == 2) {
        return "nd";
      } else if (weekOfMonth == 3) {
        return "rd";
      } else if (weekOfMonth == 4) {
        return "th";
      } else {
        return "th";
      }
    }

    String period = 'Period $weekOfMonth${weekDescription()} Cycle $date';

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeading(),
        title: const AppBarTitle(title: 'Correlation Analysis'),
        actions: appBarActions(context),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          left: defaultMargin,
          top: 24,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cage State Analysis',
              style: TextStyle(
                color: indigo,
                fontSize: kBodyLarge,
                fontFamily: medium,
              ),
            ),
            const SizedBox(height: 16),
            CustomTabBar(
              controller: _tabController,
              tabs: myTabs,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 24),
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Unstable Humidity',
                                  style: TextStyle(
                                    color: kDarkColor1,
                                    fontSize: 16,
                                    fontFamily: medium,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  period,
                                  style: const TextStyle(
                                    color: Color(0xFF5C6370),
                                    fontSize: kBodyMedium,
                                    fontFamily: regular,
                                  ),
                                ),
                              ],
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF397ED5),
                                  width: 2,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SolutionPage.routeName);
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Solution',
                                    style: TextStyle(
                                      color: Color(0xFF397ED5),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF397ED5),
                                  ),
                                  // SvgPicture.asset('assets/icons/arrow_right.svg'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Image.asset('assets/images/humidity_image.png'),
                        const SizedBox(height: 24),
                        Text(
                          'Description',
                          style: TextStyle(
                            color: kDarkColor1,
                            fontSize: 16,
                            fontFamily: medium,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Humidity in the coop is unstable due to erratic weather factors and indoor temperature conditions which can cause chickens to die.',
                          style: TextStyle(
                            color: Color(0xFF454A54),
                            fontFamily: light,
                            fontSize: kBodyMedium,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Occurs In',
                          style: TextStyle(
                            color: kDarkColor1,
                            fontSize: 16,
                            fontFamily: medium,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Consumer<CageListNotifier>(
                          builder: (context, data, child) {
                            if (data.state == RequestState.loading) {
                              return const Loading();
                            } else if (data.state == RequestState.loaded) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final cage = data.cage[index];
                                  return Card(
                                    margin: EdgeInsets.zero,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          CageDetailPage.routeName,
                                          arguments: cage,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 21,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Cage ${index + 1}',
                                                  style: TextStyle(
                                                    color: kDarkColor1,
                                                    fontSize: 16,
                                                    fontFamily: medium,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                const Text(
                                                  '20 Oct 2022',
                                                  style: TextStyle(
                                                    color: Color(0xFF9E9E9E),
                                                    fontSize: kBodySmall,
                                                    fontFamily: regular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Icon(Icons.chevron_right),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                itemCount: 6,
                              );
                            } else {
                              return Center(
                                key: const Key('error_message'),
                                child: Text(data.message),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 24),
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Temperature Too High',
                                  style: TextStyle(
                                    color: kDarkColor1,
                                    fontSize: 16,
                                    fontFamily: medium,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  period,
                                  style: const TextStyle(
                                    color: Color(0xFF5C6370),
                                    fontSize: kBodyMedium,
                                    fontFamily: regular,
                                  ),
                                ),
                              ],
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF397ED5),
                                  width: 2,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SolutionPage.routeName);
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Solution',
                                    style: TextStyle(
                                      color: Color(0xFF397ED5),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF397ED5),
                                  ),
                                  // SvgPicture.asset('assets/icons/arrow_right.svg'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Image.asset('assets/images/temperature_image.png'),
                        const SizedBox(height: 24),
                        Text(
                          'Description',
                          style: TextStyle(
                            color: kDarkColor1,
                            fontSize: 16,
                            fontFamily: medium,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'The temperature is too high due to erratic weather factors and indoor temperature conditions which can cause chickens to die.',
                          style: TextStyle(
                            color: Color(0xFF454A54),
                            fontFamily: light,
                            fontSize: kBodyMedium,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Occurs in',
                          style: TextStyle(
                            color: kDarkColor1,
                            fontSize: 16,
                            fontFamily: medium,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Consumer<CageListNotifier>(
                          builder: (context, data, child) {
                            if (data.state == RequestState.loading) {
                              return const Loading();
                            } else if (data.state == RequestState.loaded) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final cage = data.cage[index];
                                  return Card(
                                    margin: EdgeInsets.zero,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          CageDetailPage.routeName,
                                          arguments: cage,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 21,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Cage ${index + 1}',
                                                  style: TextStyle(
                                                    color: kDarkColor1,
                                                    fontSize: 16,
                                                    fontFamily: medium,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                const Text(
                                                  '20 Oct 2022',
                                                  style: TextStyle(
                                                    color: Color(0xFF9E9E9E),
                                                    fontSize: kBodySmall,
                                                    fontFamily: regular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Icon(Icons.chevron_right),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                itemCount: 6,
                              );
                            } else {
                              return Center(
                                key: const Key('error_message'),
                                child: Text(data.message),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 24),
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Excess Ammonia Content',
                                  style: TextStyle(
                                    color: kDarkColor1,
                                    fontSize: 16,
                                    fontFamily: medium,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  period,
                                  style: const TextStyle(
                                    color: Color(0xFF5C6370),
                                    fontSize: kBodyMedium,
                                    fontFamily: regular,
                                  ),
                                ),
                              ],
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF397ED5),
                                  width: 2,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SolutionPage.routeName);
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Solution',
                                    style: TextStyle(
                                      color: Color(0xFF397ED5),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF397ED5),
                                  ),
                                  // SvgPicture.asset('assets/icons/arrow_right.svg'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Image.asset('assets/images/humidity_image.png'),
                        const SizedBox(height: 24),
                        Text(
                          'Description',
                          style: TextStyle(
                            color: kDarkColor1,
                            fontSize: 16,
                            fontFamily: medium,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'The temperature is too high due to erratic weather factors and indoor temperature conditions which can cause chickens to die.',
                          style: TextStyle(
                            color: Color(0xFF454A54),
                            fontFamily: light,
                            fontSize: kBodyMedium,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Occurs in',
                          style: TextStyle(
                            color: kDarkColor1,
                            fontSize: 16,
                            fontFamily: medium,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Consumer<CageListNotifier>(
                          builder: (context, data, child) {
                            if (data.state == RequestState.loading) {
                              return const Loading();
                            } else if (data.state == RequestState.loaded) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final cage = data.cage[index];
                                  return Card(
                                    margin: EdgeInsets.zero,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          CageDetailPage.routeName,
                                          arguments: cage,
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 21,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Cage ${index + 1}',
                                                  style: TextStyle(
                                                    color: kDarkColor1,
                                                    fontSize: 16,
                                                    fontFamily: medium,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                const Text(
                                                  '20 Oct 2022',
                                                  style: TextStyle(
                                                    color: Color(0xFF9E9E9E),
                                                    fontSize: kBodySmall,
                                                    fontFamily: regular,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Icon(Icons.chevron_right),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 16),
                                itemCount: 6,
                              );
                            } else {
                              return Center(
                                key: const Key('error_message'),
                                child: Text(data.message),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 26.5,
          horizontal: defaultMargin,
        ),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Check variable associations\n'
              'manual correlation',
              style: TextStyle(
                color: Colors.black,
                fontSize: kBodyMedium,
                fontFamily: light,
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                side: const BorderSide(
                  color: Color(0xFF397ED5),
                  width: 2,
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    'Manual Check',
                    style: TextStyle(
                      color: Color(0xFF397ED5),
                      fontSize: kBodySmall,
                      fontFamily: medium,
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xFF397ED5),
                  ),
                  // SvgPicture.asset('assets/icons/icons/arrow_right.svg'),
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, CorrelationCheckPage.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 24),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: kDarkColor1,
                      fontSize: 16,
                      fontFamily: medium,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Period: Cycle 1 December 2022',
                    style: TextStyle(
                      color: Color(0xFF5C6370),
                      fontSize: kBodyMedium,
                      fontFamily: regular,
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFF397ED5),
                    width: 2,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, SolutionPage.routeName);
                },
                child: const Row(
                  children: [
                    Text(
                      'Solution',
                      style: TextStyle(
                        color: Color(0xFF397ED5),
                        fontFamily: bold,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFF397ED5),
                    ),
                    // SvgPicture.asset('assets/icons/arrow_right.svg'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Image.asset('assets/images/humidity_image.png'),
          const SizedBox(height: 24),
          Text(
            'Description',
            style: TextStyle(
              color: kDarkColor1,
              fontSize: 16,
              fontFamily: medium,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Kelembaban dalam kandang tidak stabil dikarenakan faktor cuaca yang tidak menentu serta kondisi suhu dalam ruangan yang dapat menyebabkan ayam mati.',
            style: TextStyle(
              color: Color(0xFF454A54),
              fontFamily: light,
              fontSize: kBodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Terjadi Pada',
            style: TextStyle(
              color: kDarkColor1,
              fontSize: 16,
              fontFamily: medium,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 21,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cage ${index + 1}',
                            style: TextStyle(
                              color: kDarkColor1,
                              fontSize: 16,
                              fontFamily: medium,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '20 Okt 2022',
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: kBodySmall,
                              fontFamily: regular,
                            ),
                          ),
                        ],
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: 5,
          ),
        ],
      ),
    );
  }
}
