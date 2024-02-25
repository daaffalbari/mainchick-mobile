import 'package:core/presentation/widgets/app_bar_actions.dart';
import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/presentation/widgets/loading_indicator.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:history/presentation/provider/history_list_notifier.dart';
import 'package:provider/provider.dart';

import '../widgets/history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  static const routeName = '/history';

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<HistoryListNotifier>(context, listen: false)
            .fetchHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeading(),
        title: const AppBarTitle(title: 'Harvest History'),
        actions: appBarActions(context),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: 22,
          horizontal: defaultMargin,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List of Chicken Cage',
                  style: TextStyle(
                    color: indigo,
                    fontFamily: medium,
                    fontSize: 21,
                  ),
                ),
                // SizedBox(
                //   width: 111,
                //   height: 36,
                //   child: OutlinedButton.icon(
                //     style: OutlinedButton.styleFrom(
                //       side: const BorderSide(
                //         color: Color(0xFF3EA1F1),
                //         strokeAlign: StrokeAlign.inside,
                //       ),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(6),
                //       ),
                //     ),
                //     onPressed: () {},
                //     icon: SvgPicture.asset('assets/filter.svg'),
                //     label: const Text(
                //       'Filter',
                //       style: TextStyle(
                //         color: Color(0xFF3EA1F1),
                //         fontFamily: regular,
                //         fontSize: 14,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            Consumer<HistoryListNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Loading();
                } else if (data.state == RequestState.loaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var history = data.history[index];
                      return HistoryCard(history);
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
    );
  }
}
