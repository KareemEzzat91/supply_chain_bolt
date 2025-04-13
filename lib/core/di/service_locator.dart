import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supply_chain_bolt/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:supply_chain_bolt/features/orders/data/repositories/order_repository.dart';
import 'package:supply_chain_bolt/features/orders/presentation/cubit/order_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Dio
  sl.registerLazySingleton(() => Dio());

  // Data Sources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(
      dio: sl(),
      baseUrl: 'https://your-api-base-url.com/api',
    ),
  );

  // Repositories
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(sl()),
  );

  // Cubits
  sl.registerFactory(() => OrderCubit(sl()));
}
