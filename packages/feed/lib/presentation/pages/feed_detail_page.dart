import 'dart:convert';

import 'package:core/presentation/widgets/app_bar_actions.dart';
import 'package:core/presentation/widgets/app_bar_leading.dart';
import 'package:core/presentation/widgets/app_bar_title.dart';
import 'package:core/presentation/widgets/loading_indicator.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/utils/string_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/models/feed_detail_model.dart';
import '../../domain/entities/feed.dart';
import '../provider/feed_detail_notifier.dart';
import '../widgets/feed_detail_card_list.dart';
import '../widgets/text_field.dart';

Future<FeedDetailModel> postFeed(
  int feed,
  int dead,
  String date,
  String key,
) async {
  final response = await http.post(
    Uri.parse('https://chicken-soul-api-codelabs.azurewebsites.net/feeds/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'feed': feed,
      'dead': dead,
      'date': date,
      'kandang_key': key,
    }),
  );

  if (response.statusCode == 200) {
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    return FeedDetailModel.fromJson(jsonDecode(response.body));
  } else {
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    throw Exception('Failed to Post.');
  }
}

class FeedDetailPage extends StatefulWidget {
  const FeedDetailPage({
    Key? key,
    required this.feed,
  }) : super(key: key);

  static const routeName = '/feed-detail';

  final Feed feed;

  @override
  State<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends State<FeedDetailPage> {
  final _feedController = TextEditingController();
  final _deadController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<FeedDetailNotifier>(context, listen: false)
            .fetchFeedDetail(widget.feed.kandangName));
  }

  @override
  Widget build(BuildContext context) {
    var cage = widget.feed.kandangName.getLastChar(1);
    final now = DateTime.now();
    final dateFormat = DateFormat('y-MM-dd');
    final todayDate = dateFormat.format(now);

    datePicker() async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2100));

      if (pickedDate != null) {
        if (kDebugMode) {
          print(pickedDate);
        } //pickedDate output format => 2021-03-10 00:00:00.000
        String formattedDate = DateFormat('y-MM-dd').format(pickedDate);
        if (kDebugMode) {
          print(formattedDate);
        } //formatted date output using intl package =>  2021-03-16
        setState(() {
          _dateController.text =
              formattedDate; //set output date to TextField value.
        });
      } else {}
    }

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeading(),
        title: const AppBarTitle(title: "Feed Data Details"),
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
              'Cage $cage',
              style: TextStyle(
                color: indigo,
                fontSize: kBodyLarge,
                fontFamily: medium,
              ),
            ),
            const SizedBox(height: 16),
            widget.feed.status
                ? Container(
                    padding: const EdgeInsets.all(11),
                    decoration: const BoxDecoration(
                      color: Color(0x1A3CA2F2),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/success.svg'),
                        const SizedBox(width: 20),
                        const Expanded(
                          child: Text(
                            'Today You Have Provided Feed, Keep Keep Feeding Your Chickens!',
                            style: TextStyle(
                              fontSize: kBodySmall,
                              fontFamily: regular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(11),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFEFEF),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/alert.svg'),
                        const SizedBox(width: 20),
                        const Expanded(
                          child: Text(
                            'Today You Have Not Feeded, Feed Now!',
                            style: TextStyle(
                              fontSize: kBodySmall,
                              fontFamily: regular,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 16),
            Consumer<FeedDetailNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: const Loading(),
                  );
                } else if (data.state == RequestState.loaded) {
                  return ListView.separated(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final feedDetail = data.feed[index];
                      return FeedDetailCard(feedDetail);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: data.feed.length,
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
              "Feed your chickens now!",
              style: TextStyle(
                color: Colors.black,
                fontSize: kBodyMedium,
                fontFamily: light,
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xFF397ED5),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    "Feed",
                    style: TextStyle(
                      fontSize: kBodySmall,
                      fontFamily: medium,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/arrow_right.svg',
                    color: const Color(0xFF397ED5),
                  ),
                ],
              ),
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  insetPadding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  titlePadding: const EdgeInsets.only(
                    left: 18,
                    top: 25,
                    right: 18,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 45,
                    horizontal: 18,
                  ),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Chicken Feed Data - $cage',
                        style: const TextStyle(
                          color: Color(0xFF5C6370),
                          fontSize: kBodyMedium,
                          fontFamily: regular,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset('assets/icons/close.svg'),
                      )
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      textFieldWidget(
                        _dateController,
                        'Date',
                        null,
                        true,
                        datePicker,
                      ),
                      const SizedBox(height: 18),
                      textFieldWidget(
                        _feedController,
                        'Chicken Food',
                        TextInputType.number,
                      ),
                      const SizedBox(height: 18),
                      textFieldWidget(
                        _deadController,
                        'Dead Chickens',
                        TextInputType.number,
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 62,
                        child: ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Save'),
                          onPressed: () {
                            setState(() {
                              postFeed(
                                int.parse(_feedController.text),
                                int.parse(_deadController.text),
                                todayDate,
                                widget.feed.kandangName,
                              );
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
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
  void dispose() {
    _feedController.dispose();
    _dateController.dispose();
    _deadController.dispose();
    super.dispose();
  }
}
