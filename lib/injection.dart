import 'package:cage/data/datasources/cage_remote_data_sources.dart';
import 'package:cage/data/respositories/cage_repository_impl.dart';
import 'package:cage/domain/repositories/cage_repository.dart';
import 'package:cage/domain/usecases/get_cage.dart';
import 'package:cage/domain/usecases/get_cage_block.dart';
import 'package:cage/domain/usecases/get_censor.dart';
import 'package:cage/domain/usecases/get_chart.dart';
import 'package:cage/presentation/provider/cage_block_notifier.dart';
import 'package:cage/presentation/provider/cage_list_notifier.dart';
import 'package:cage/presentation/provider/chart_notifier.dart';
import 'package:chatbot/data/datasources/chatbot_remote_data_sources.dart';
import 'package:chatbot/domain/repositories/chatbot_repository.dart';
import 'package:chatbot/data/respositories/chatbot_repository_impl.dart';
import 'package:chatbot/domain/usecases/post_prediction.dart';
import 'package:chatbot/presentation/provider/chatbot_notifier.dart';
import 'package:chatbot/domain/usecases/get_chatbot.dart';
import 'package:chatbot/presentation/provider/pick_image_notifier.dart';
import 'package:chatbot/presentation/provider/prediction_notifier.dart';
import 'package:feed/data/datasources/feed_remote_data_sources.dart';
import 'package:feed/data/repositories/feed_repository_impl.dart';
import 'package:feed/domain/repositories/feed_repository.dart';
import 'package:feed/domain/usecases/get_feed.dart';
import 'package:feed/domain/usecases/get_feed_detail.dart';
import 'package:feed/presentation/provider/feed_detail_notifier.dart';
import 'package:feed/presentation/provider/feed_list_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:history/data/datasources/history_remote_data_sources.dart';
import 'package:history/data/respositories/history_repository_impl.dart';
import 'package:history/domain/repositories/history_repository.dart';
import 'package:history/domain/usecases/get_history.dart';
import 'package:history/presentation/provider/history_list_notifier.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => CageListNotifier(
      getCage: locator(),
    ),
  );

  locator.registerFactory(
    () => CageBlockNotifier(
      getCageBlock: locator(),
    ),
  );

  locator.registerFactory(
    () => ChartNotifier(
      getChart: locator(),
    ),
  );

  locator.registerFactory(
    () => FeedListNotifier(
      getFeed: locator(),
    ),
  );

  locator.registerFactory(
    () => FeedDetailNotifier(
      getFeedDetail: locator(),
    ),
  );

  locator.registerFactory(
    () => HistoryListNotifier(
      getHistory: locator(),
    ),
  );

  locator.registerFactory(
    () => PickImageNotifier(),
  );

  locator.registerFactory(
    () => PredictionNotifier(
      postPrediction: locator(),
    ),
  );

  locator.registerFactory(
    () => ChatBotNotifier(
      getChatbot: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetCage(locator()));
  locator.registerLazySingleton(() => GetCageBlock(locator()));
  locator.registerLazySingleton(() => GetCensor(locator()));
  locator.registerLazySingleton(() => GetChart(locator()));
  locator.registerLazySingleton(() => GetFeed(locator()));
  locator.registerLazySingleton(() => GetFeedDetail(locator()));
  locator.registerLazySingleton(() => GetHistory(locator()));
  locator.registerLazySingleton(() => GetChatBot(locator()));
  locator.registerLazySingleton(() => PostPrediction(locator()));

  // repository
  locator.registerLazySingleton<CageRepository>(
      () => CageRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<FeedRepository>(
      () => FeedRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<ChatBotRepository>(
      () => ChatBotRepositoryImpl(remoteDataSource: locator()));

  // data sources
  locator.registerLazySingleton<CageRemoteDataSource>(
      () => CageRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<FeedRemoteDataSource>(
      () => FeedRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<HistoryRemoteDataSource>(
      () => HistoryRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<ChatBotRemoteDataSource>(
      () => ChatBotRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
