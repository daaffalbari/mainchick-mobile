import 'package:cage/presentation/provider/cage_block_notifier.dart';
import 'package:core/presentation/widgets/app_bar_actions.dart';
import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/presentation/widgets/cutom_tab_bar.dart';
import 'package:core/presentation/widgets/cutom_tab_bar_view.dart';
import 'package:core/presentation/widgets/loading_indicator.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../domain/entities/cage.dart';
import '../../domain/entities/chart_framework.dart';
import '../provider/cage_list_notifier.dart';
import '../provider/chart_notifier.dart';

class CageDetailPage extends StatefulWidget {
  const CageDetailPage({Key? key, required this.cage}) : super(key: key);

  final Cage cage;
  static const routeName = '/cage-detail';

  @override
  State<CageDetailPage> createState() => _CageDetailPageState();
}

class _CageDetailPageState extends State<CageDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> myTabs = [
    Tab(text: 'Block'),
    Tab(text: 'Chart'),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CageListNotifier>(context, listen: false).fetchCage();
      Provider.of<CageBlockNotifier>(context, listen: false)
          .fetchCageBlock(widget.cage.key);
      Provider.of<ChartNotifier>(context, listen: false)
          .fetchChart(widget.cage.key);
    });
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
    String key = widget.cage.key.getLastChar(1);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const AppBarLeading(),
        title: AppBarTitle(title: 'Detail Cage $key'),
        actions: appBarActions(context),
      ),
      backgroundColor: greyBackground,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          left: defaultMargin,
          top: 16,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last update: 07-12-2022 12:01',
              style: TextStyle(
                color: Color(0xFF979797),
                fontSize: kBodySmall,
                fontFamily: regular,
              ),
            ),
            const SizedBox(height: 16),
            chickenData(),
            const SizedBox(height: 36),
            Text(
              'Cage Analysis',
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
            CustomTabBarView(
              controller: _tabController,
              children: [
                cagePlan(),
                chart(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget chickenData() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          // Overflow
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TODO belum ada data pakan, ayam hidup, dan mati
            chickenDataContent(2345.14, 'Average weight ', ' gram'),
            chickenDataContent(425, 'Chickens'),
            chickenDataContent(32, 'Number Of Death'),
          ],
        ),
      ),
    );
  }

  Widget chickenDataContent(dynamic value, String description,
      [String unit = '', bool position = true]) {
    return Column(
      crossAxisAlignment:
          (position) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              '$value',
              style: kHeading4.copyWith(
                color: indigo,
              ),
            ),
            Text(
              unit,
              style: TextStyle(
                color: indigo,
                fontSize: kBodySmall,
                fontFamily: light,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(
            color: Color(0xFFA8A8A8),
            fontSize: kBodySmall,
            fontFamily: regular,
          ),
        ),
      ],
    );
  }

  Widget cagePlan() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Click On The Cage Block To see Details Of The State Of The Cage And Click The Sensor Icon To View Sensor Details',
            style: TextStyle(
              color: Color(0xFF979797),
              fontSize: kBodySmall,
              fontFamily: regular,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // cagePlanCard(),
          Consumer<CageBlockNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Loading();
              } else if (data.state == RequestState.loaded) {
                final cagePlan = data.cageBlock;
                return SizedBox(
                  height: 322,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            insetPadding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 12,
                            ),
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: kPrimaryColor[80],
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: kBodyLarge,
                                          fontFamily: regular,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Number Chicken',
                                          style: TextStyle(
                                            color: Color(0xFFA8A8A8),
                                            fontSize: kBodyMedium,
                                            fontFamily: regular,
                                          ),
                                        ),
                                        const SizedBox(height: 9),
                                        Text(
                                          '$randomNumber Chickens',
                                          style: TextStyle(
                                            color: indigo,
                                            fontSize: kBodyLarge,
                                            fontFamily: bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                blockCard(
                                  'assets/icons/temperature.svg',
                                  'Temperature',
                                  'Too hot',
                                  cagePlan[index].suhu,
                                  '°C',
                                ),
                                const SizedBox(height: 16),
                                blockCard(
                                  'assets/icons/humidity.svg',
                                  'Humidity',
                                  'Stable Condition',
                                  cagePlan[index].kelembapan,
                                  '%',
                                ),
                                const SizedBox(height: 16),
                                blockCard(
                                  'assets/icons/ammonia.svg',
                                  'Ammonia',
                                  'Stable Condition',
                                  cagePlan[index].amonia,
                                  'PPM',
                                ),
                                const SizedBox(height: 16),
                                blockCard(
                                  'assets/icons/chicken_weight.svg',
                                  'Chicken Weight',
                                  'Excess weight',
                                  cagePlan[index].berat,
                                  'gram',
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: cagePlanCard(index + 1),
                      );
                    },
                    itemCount: 6,
                  ),
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
    );
  }

  Widget cagePlanCard(int number) {
    return SizedBox(
      height: 156,
      child: Card(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        color: const Color(0xFFFFF8EF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: kPrimaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: kPrimaryColor[80],
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: kBodyLarge,
                    fontFamily: regular,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // const Text(
              //   'Chickens',
              //   style: TextStyle(
              //     color: Color(0xFFA8A8A8),
              //     fontSize: kBodyMedium,
              //     fontFamily: regular,
              //   ),
              // ),
              // const SizedBox(height: 9),
              // Text(
              //   '$randomNumber',
              //   style: TextStyle(
              //     color: indigo,
              //     fontSize: kBodyLarge,
              //     fontFamily: bold,
              //   ),
              // ),
              const Text(
                'Status',
                style: TextStyle(
                  color: Color(0xFFA8A8A8),
                  fontSize: kBodyMedium,
                  fontFamily: regular,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFD858B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/temperature_small.svg"),
                    const SizedBox(width: 2),
                    const Text(
                      'High Temperature ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cageBlock() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 24),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Blok 1',
                style: TextStyle(
                  color: indigo,
                  fontSize: kBodyLarge,
                  fontFamily: medium,
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: const BorderSide(
                    color: Color(secondaryColorValue),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/change_block.svg'),
                    const Text(
                      'Ganti Blok',
                      style: TextStyle(
                        color: Color(secondaryColorValue),
                        fontSize: kBodySmall,
                        fontFamily: medium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Consumer<CageBlockNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Loading();
              } else if (data.state == RequestState.loaded) {
                final cageBlock = data.cageBlock[0];
                return Column(
                  children: [
                    blockCard(
                      'assets/icons/temperature.svg',
                      'Suhu',
                      'Terlalu panas',
                      cageBlock.suhu,
                      '°C',
                    ),
                    const SizedBox(height: 16),
                    blockCard(
                      'assets/icons/humidity.svg',
                      'Kelembaban',
                      'Kondisi stabil',
                      cageBlock.kelembapan,
                      '%',
                    ),
                    const SizedBox(height: 16),
                    blockCard(
                      'assets/icons/ammonia.svg',
                      'Amonia',
                      'Kondisi stabil',
                      cageBlock.amonia,
                      'PPM',
                    ),
                    const SizedBox(height: 16),
                    blockCard(
                      'assets/icons/chicken_weight.svg',
                      'Berat ayam',
                      'Berat berlebih',
                      cageBlock.berat,
                      'gram',
                    ),
                  ],
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
    );
  }

  Widget blockCard(
    String asset,
    String title,
    String condition,
    dynamic value,
    String unit,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(asset),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: indigo,
                          fontSize: 16,
                          fontFamily: semiBold,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        condition,
                        style: const TextStyle(
                          color: Color(0xFFDE7878),
                          fontSize: kBodyMedium,
                          fontFamily: regular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  text: '$value ',
                  style: TextStyle(
                    color: indigo,
                    fontSize: kBodyLarge,
                    fontFamily: bold,
                  ),
                  children: [
                    TextSpan(
                      text: unit,
                      style: TextStyle(
                        color: indigo,
                        fontSize: kBodyLarge,
                        fontFamily: light,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget censor() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Indoor Sensor',
            style: TextStyle(
              color: indigo,
              fontSize: kBodyLarge,
              fontFamily: medium,
            ),
          ),
          const SizedBox(height: 16),
          indoorAndOutdoorCensorCard(),
          const SizedBox(height: 24),
          Text(
            'Outdoor Sensor',
            style: TextStyle(
              color: indigo,
              fontSize: kBodyLarge,
              fontFamily: medium,
            ),
          ),
          const SizedBox(height: 16),
          indoorAndOutdoorCensorCard(),
          const SizedBox(height: 24),
          Text(
            'Wind Sensor',
            style: TextStyle(
              color: indigo,
              fontSize: kBodyLarge,
              fontFamily: medium,
            ),
          ),
          const SizedBox(height: 16),
          windCensorCard(),
        ],
      ),
    );
  }

  Widget indoorAndOutdoorCensorCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 24.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No. Sensor:',
                  style: TextStyle(
                    color: indigo,
                    fontSize: 16,
                    fontFamily: regular,
                  ),
                ),
                Text(
                  'S1',
                  style: TextStyle(
                    color: indigo,
                    fontSize: kBodyXLarge,
                    fontFamily: bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Suhu:',
                  style: TextStyle(
                    color: indigo,
                    fontSize: 16,
                    fontFamily: regular,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '28.18 ',
                      style: TextStyle(
                        color: indigo,
                        fontSize: kBodyXLarge,
                        fontFamily: bold,
                      ),
                    ),
                    Text(
                      '°C',
                      style: TextStyle(
                        color: indigo,
                        fontSize: kBodyXLarge,
                        fontFamily: light,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kelembaban:',
                  style: TextStyle(
                    color: indigo,
                    fontSize: 16,
                    fontFamily: regular,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '65.00 ',
                      style: TextStyle(
                        color: indigo,
                        fontSize: kBodyXLarge,
                        fontFamily: bold,
                      ),
                    ),
                    Text(
                      '%',
                      style: TextStyle(
                        color: indigo,
                        fontSize: kBodyXLarge,
                        fontFamily: light,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Diperbaharui:',
                  style: TextStyle(
                    color: indigo,
                    fontSize: 16,
                    fontFamily: regular,
                  ),
                ),
                Text(
                  '20-11-2020 16:40',
                  style: TextStyle(
                    color: indigo,
                    fontSize: kBodyXLarge,
                    fontFamily: bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card windCensorCard() {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 24.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No. Sensor:',
                  style: TextStyle(
                    color: indigo,
                    fontSize: 16,
                    fontFamily: regular,
                  ),
                ),
                Text(
                  'W1',
                  style: TextStyle(
                    color: indigo,
                    fontSize: kBodyLarge,
                    fontFamily: bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Suhu:',
                  style: TextStyle(
                    color: indigo,
                    fontSize: 16,
                    fontFamily: regular,
                  ),
                ),
                Text(
                  '5.23 km/h',
                  style: TextStyle(
                    color: indigo,
                    fontSize: kBodyLarge,
                    fontFamily: bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Diperbaharui:',
                  style: TextStyle(
                    color: indigo,
                    fontSize: 16,
                    fontFamily: regular,
                  ),
                ),
                Text(
                  '20-11-2020 16:40',
                  style: TextStyle(
                    color: indigo,
                    fontSize: kBodyLarge,
                    fontFamily: bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget chart() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Periode:',
                style: TextStyle(
                  color: indigo,
                  fontSize: kBodyLarge,
                  fontFamily: medium,
                ),
              ),
              Container(
                width: 153,
                height: 34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFF3EA1F1),
                    )),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset('assets/icons/date.svg'),
                  const SizedBox(width: 6),
                  const Text(
                    'Weekly',
                    style: TextStyle(
                      color: Color(0xFF3EA1F1),
                      fontSize: kBodySmall,
                      fontFamily: regular,
                    ),
                  ),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Broiler Weight',
            style: TextStyle(
              color: indigo,
              fontSize: kBodyLarge,
              fontFamily: medium,
            ),
          ),
          const SizedBox(height: 16),
          Consumer<ChartNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Loading();
              } else if (data.state == RequestState.loaded) {
                // TODO fix chart
                final dateFormat = DateFormat('dd MMMM');
                var firstDate = dateFormat.format(data.chart[0].date);
                var secondDate = dateFormat.format(data.chart[1].date);
                var thirdDate = dateFormat.format(data.chart[2].date);
                var fourDate = dateFormat.format(data.chart[3].date);
                var fifthDate = dateFormat.format(data.chart[4].date);
                var sixDate = dateFormat.format(data.chart[5].date);
                var sevenDate = dateFormat.format(data.chart[6].date);

                return SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<ChartFramework, dynamic>(
                      dataSource: <ChartFramework>[
                        ChartFramework(
                          data.chart[0].weight.data,
                          data.chart[0].weight.ideal,
                          firstDate,
                        ),
                        ChartFramework(
                          data.chart[1].weight.data,
                          data.chart[1].weight.ideal,
                          secondDate,
                        ),
                        ChartFramework(
                          data.chart[2].weight.data,
                          data.chart[2].weight.ideal,
                          thirdDate,
                        ),
                        ChartFramework(
                          data.chart[3].weight.data,
                          data.chart[3].weight.ideal,
                          fourDate,
                        ),
                        ChartFramework(
                          data.chart[4].weight.data,
                          data.chart[4].weight.ideal,
                          fifthDate,
                        ),
                        ChartFramework(
                          data.chart[5].weight.data,
                          data.chart[5].weight.ideal,
                          sixDate,
                        ),
                        ChartFramework(
                          data.chart[6].weight.data,
                          data.chart[6].weight.ideal,
                          sevenDate,
                        ),
                      ],
                      xValueMapper: (ChartFramework data, _) => data.date,
                      yValueMapper: (ChartFramework data, _) => data.real,
                      name: 'Real Weight',
                      color: Colors.blue,
                    ),
                    LineSeries<ChartFramework, dynamic>(
                      dataSource: <ChartFramework>[
                        ChartFramework(
                          data.chart[0].weight.data,
                          data.chart[0].weight.ideal,
                          firstDate,
                        ),
                        ChartFramework(
                          data.chart[1].weight.data,
                          data.chart[1].weight.ideal,
                          secondDate,
                        ),
                        ChartFramework(
                          data.chart[2].weight.data,
                          data.chart[2].weight.ideal,
                          thirdDate,
                        ),
                        ChartFramework(
                          data.chart[3].weight.data,
                          data.chart[3].weight.ideal,
                          fourDate,
                        ),
                        ChartFramework(
                          data.chart[4].weight.data,
                          data.chart[4].weight.ideal,
                          fifthDate,
                        ),
                        ChartFramework(
                          data.chart[5].weight.data,
                          data.chart[5].weight.ideal,
                          sixDate,
                        ),
                        ChartFramework(
                          data.chart[6].weight.data,
                          data.chart[6].weight.ideal,
                          sevenDate,
                        ),
                      ],
                      xValueMapper: (ChartFramework data, _) => data.date,
                      yValueMapper: (ChartFramework data, _) => data.ideal,
                      name: 'Ideal Weight',
                      color: Colors.green,
                    ),
                  ],
                  legend: Legend(
                    position: LegendPosition.top,
                    isResponsive: true,
                    isVisible: true,
                  ),
                );
              } else {
                return Center(
                  key: const Key('error_message'),
                  child: Text(data.message),
                );
              }
            },
          ),
          Text(
            'Daily Broiler',
            style: TextStyle(
              color: indigo,
              fontSize: kBodyLarge,
              fontFamily: medium,
            ),
          ),
          Consumer<ChartNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Loading();
              } else if (data.state == RequestState.loaded) {
                // TODO fix chart
                final dateFormat = DateFormat('dd MMMM');
                var firstDate = dateFormat.format(data.chart[0].date);
                var secondDate = dateFormat.format(data.chart[1].date);
                var thirdDate = dateFormat.format(data.chart[2].date);
                var fourDate = dateFormat.format(data.chart[3].date);
                var fifthDate = dateFormat.format(data.chart[4].date);
                var sixDate = dateFormat.format(data.chart[5].date);
                var sevenDate = dateFormat.format(data.chart[6].date);

                return SfCartesianChart(
                  title: ChartTitle(
                    text: 'Daily Broiler Feed Chart (kg)',
                    textStyle: const TextStyle(
                      fontSize: kBodySmall,
                      fontFamily: regular,
                    ),
                  ),
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<ChartFramework, dynamic>(
                      dataSource: <ChartFramework>[
                        ChartFramework(
                          data.chart[0].feed.data,
                          data.chart[0].feed.ideal,
                          firstDate,
                        ),
                        ChartFramework(
                          data.chart[1].feed.data,
                          data.chart[1].feed.ideal,
                          secondDate,
                        ),
                        ChartFramework(
                          data.chart[2].feed.data,
                          data.chart[2].feed.ideal,
                          thirdDate,
                        ),
                        ChartFramework(
                          data.chart[3].feed.data,
                          data.chart[3].feed.ideal,
                          fourDate,
                        ),
                        ChartFramework(
                          data.chart[4].feed.data,
                          data.chart[4].feed.ideal,
                          fifthDate,
                        ),
                        ChartFramework(
                          data.chart[5].feed.data,
                          data.chart[5].feed.ideal,
                          sixDate,
                        ),
                        ChartFramework(
                          data.chart[6].feed.data,
                          data.chart[6].feed.ideal,
                          sevenDate,
                        ),
                      ],
                      xValueMapper: (ChartFramework data, _) => data.date,
                      yValueMapper: (ChartFramework data, _) => data.real,
                      name: 'Real Weight',
                      color: Colors.blue,
                    ),
                    LineSeries<ChartFramework, dynamic>(
                      dataSource: <ChartFramework>[
                        ChartFramework(
                          data.chart[0].feed.data,
                          data.chart[0].feed.ideal,
                          firstDate,
                        ),
                        ChartFramework(
                          data.chart[1].feed.data,
                          data.chart[1].feed.ideal,
                          secondDate,
                        ),
                        ChartFramework(
                          data.chart[2].feed.data,
                          data.chart[2].feed.ideal,
                          thirdDate,
                        ),
                        ChartFramework(
                          data.chart[3].feed.data,
                          data.chart[3].feed.ideal,
                          fourDate,
                        ),
                        ChartFramework(
                          data.chart[4].feed.data,
                          data.chart[4].feed.ideal,
                          fifthDate,
                        ),
                        ChartFramework(
                          data.chart[5].feed.data,
                          data.chart[5].feed.ideal,
                          sixDate,
                        ),
                        ChartFramework(
                          data.chart[6].feed.data,
                          data.chart[6].feed.ideal,
                          sevenDate,
                        ),
                      ],
                      xValueMapper: (ChartFramework data, _) => data.date,
                      yValueMapper: (ChartFramework data, _) => data.ideal,
                      name: 'Ideal Weight',
                      color: Colors.green,
                    ),
                  ],
                  legend: Legend(
                    position: LegendPosition.top,
                    isResponsive: true,
                    isVisible: true,
                  ),
                );
              } else {
                return Center(
                  key: const Key('error_message'),
                  child: Text(data.message),
                );
              }
            },
          ),
          /*Text(
            'Daily Broiler',
            style: TextStyle(
              color: indigo,
              fontSize: kBodyLarge,
              fontFamily: medium,
            ),
          ),
          Consumer<ChartNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Loading();
              } else if (data.state == RequestState.loaded) {
                // TODO fix chart
                final dateFormat = DateFormat('dd MMMM');
                var firstDate = dateFormat.format(data.chart[0].date);
                var secondDate = dateFormat.format(data.chart[1].date);
                var thirdDate = dateFormat.format(data.chart[2].date);
                var fourDate = dateFormat.format(data.chart[3].date);
                var fifthDate = dateFormat.format(data.chart[4].date);
                var sixDate = dateFormat.format(data.chart[5].date);
                var sevenDate = dateFormat.format(data.chart[6].date);

                return SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    LineSeries<Dead, dynamic>(
                      dataSource: <Dead>[
                        Dead(
                          data.chart[0].feed.data,
                          data.chart[0].feed.ideal,
                          firstDate,
                        ),
                        Dead(
                          data.chart[1].feed.data,
                          data.chart[1].feed.ideal,
                          secondDate,
                        ),
                        Dead(
                          data.chart[2].feed.data,
                          data.chart[2].feed.ideal,
                          thirdDate,
                        ),
                        Dead(
                          data.chart[3].feed.data,
                          data.chart[3].feed.ideal,
                          fourDate,
                        ),
                        Dead(
                          data.chart[4].feed.data,
                          data.chart[4].feed.ideal,
                          fifthDate,
                        ),
                        Dead(
                          data.chart[5].feed.data,
                          data.chart[5].feed.ideal,
                          sixDate,
                        ),
                        Dead(
                          data.chart[6].feed.data,
                          data.chart[6].feed.ideal,
                          sevenDate,
                        ),
                      ],
                      xValueMapper: (Dead data, _) => data.date,
                      yValueMapper: (Dead data, _) => data.real,
                      name: 'Real Weight',
                      color: Colors.blue,
                    ),
                    LineSeries<Dead, dynamic>(
                      dataSource: <Dead>[
                        Dead(
                          data.chart[0].feed.data,
                          data.chart[0].feed.ideal,
                          firstDate,
                        ),
                        Dead(
                          data.chart[1].feed.data,
                          data.chart[1].feed.ideal,
                          secondDate,
                        ),
                        Dead(
                          data.chart[2].feed.data,
                          data.chart[2].feed.ideal,
                          thirdDate,
                        ),
                        Dead(
                          data.chart[3].feed.data,
                          data.chart[3].feed.ideal,
                          fourDate,
                        ),
                        Dead(
                          data.chart[4].feed.data,
                          data.chart[4].feed.ideal,
                          fifthDate,
                        ),
                        Dead(
                          data.chart[5].feed.data,
                          data.chart[5].feed.ideal,
                          sixDate,
                        ),
                        Dead(
                          data.chart[6].feed.data,
                          data.chart[6].feed.ideal,
                          sevenDate,
                        ),
                      ],
                      xValueMapper: (Dead data, _) => data.date,
                      yValueMapper: (Dead data, _) => data.ideal,
                      name: 'Ideal Weight',
                      color: Colors.green,
                    ),
                  ],
                  legend: Legend(
                    position: LegendPosition.top,
                    isResponsive: true,
                    isVisible: true,
                  ),
                );
              } else {
                return Center(
                  key: const Key('error_message'),
                  child: Text(data.message),
                );
              }
            },
          ),*/
        ],
      ),
    );
  }
}
