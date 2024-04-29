import 'package:analysis/presentation/pages/analysis_page.dart';
import 'package:analysis/presentation/pages/correlation_check_page.dart';
import 'package:analysis/presentation/pages/solution_page.dart';
import 'package:cage/domain/entities/cage.dart';
import 'package:chatbot/domain/entities/prediction.dart';
import 'package:chatbot/presentation/provider/prediction_notifier.dart';
import 'package:cage/presentation/pages/cage_detail_page.dart';
import 'package:cage/presentation/pages/cage_list_page.dart';
import 'package:cage/presentation/provider/cage_block_notifier.dart';
import 'package:cage/presentation/provider/cage_list_notifier.dart';
import 'package:cage/presentation/provider/censor_notifier.dart';
import 'package:cage/presentation/provider/chart_notifier.dart';
import 'package:chatbot/presentation/pages/chatbot_page.dart';
import 'package:chatbot/presentation/pages/prediction_detail_page.dart';
import 'package:chatbot/presentation/provider/chatbot_notifier.dart';
import 'package:chatbot/presentation/provider/pick_image_notifier.dart';
import 'package:login/login_page.dart';
import 'package:notification/presentation/pages/notification_page.dart';
import 'package:core/presentation/pages/splash_screen_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/styles/colors.dart';
import 'package:core/utils/utils.dart';
import 'package:feed/domain/entities/feed.dart';
import 'package:feed/presentation/pages/feed_detail_page.dart';
import 'package:feed/presentation/pages/feed_list_page.dart';
import 'package:feed/presentation/provider/feed_detail_notifier.dart';
import 'package:feed/presentation/provider/feed_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:history/presentation/pages/history_page.dart';
import 'package:history/presentation/provider/history_list_notifier.dart';
import 'package:profile/presentation/pages/profile_page.dart';
import 'package:provider/provider.dart';

import 'injection.dart' as di;

void main() {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<CageListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CageBlockNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CensorNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ChartNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<FeedListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<FeedDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<HistoryListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PickImageNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ChatBotNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PredictionNotifier>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.rubikTextTheme(),
          primaryColor: kPrimaryColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: kSecondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            color: kPrimaryColor,
          ),
        ),
        home: const SplashScreenPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case LoginPage.routeName:
              return MaterialPageRoute(builder: (_) => const LoginPage());
            case HomePage.routeName:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case CageListPage.routeName:
              return MaterialPageRoute(builder: (_) => const CageListPage());
            case CageDetailPage.routeName:
              final cage = settings.arguments as Cage;
              return MaterialPageRoute(
                builder: (_) => CageDetailPage(cage: cage),
              );
            case AnalysisPage.routeName:
              return MaterialPageRoute(builder: (_) => const AnalysisPage());
            case SolutionPage.routeName:
              return MaterialPageRoute(builder: (_) => const SolutionPage());
            case CorrelationCheckPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const CorrelationCheckPage());
            case FeedPage.routeName:
              return MaterialPageRoute(builder: (_) => const FeedPage());
            case FeedDetailPage.routeName:
              final id = settings.arguments as Feed;
              return MaterialPageRoute(
                builder: (_) => FeedDetailPage(feed: id),
                settings: settings,
              );
            case HistoryPage.routeName:
              return MaterialPageRoute(builder: (_) => const HistoryPage());
            case ProfilePage.routeName:
              return MaterialPageRoute(builder: (_) => const ProfilePage());
            case ChatBotPage.routeName:
              return MaterialPageRoute(builder: (_) => const ChatBotPage());
            case PredictionDetailPage.routeName:
              final prediction = settings.arguments as Prediction;
              return MaterialPageRoute(
                builder: (_) => PredictionDetailPage(prediction: prediction),
              );
            case NotificationPage.routeName:
              return MaterialPageRoute(
                  builder: (_) => const NotificationPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
