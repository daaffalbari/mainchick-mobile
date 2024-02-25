import 'package:core/presentation/widgets/app_bar_actions.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/presentation/widgets/gradient_background.dart';
import 'package:core/presentation/widgets/loading_indicator.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cage_list_notifier.dart';
import '../widgets/cage_card.dart';

class CageListPage extends StatefulWidget {
  const CageListPage({Key? key}) : super(key: key);
  static const routeName = '/cage-list';

  @override
  State<CageListPage> createState() => _CageListPageState();
}

class _CageListPageState extends State<CageListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CageListNotifier>(context, listen: false).fetchCage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const AppBarTitle(title: "Dashboard"),
        actions: appBarActions(context),
      ),
      backgroundColor: greyBackground,
      body: Stack(
        children: [
          const GradientBackground(),
          Consumer<CageListNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.loading) {
                return const Loading();
              } else if (data.state == RequestState.loaded) {
                return ListView.separated(
                  padding: const EdgeInsets.only(
                    left: defaultMargin,
                    top: 18,
                    right: defaultMargin,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cage = data.cage[index];
                    return CageCard(cage);
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
    );
  }
}
