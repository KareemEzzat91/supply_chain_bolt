import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supply_chain_bolt/core/api_helper/api_helper.dart';
import 'package:supply_chain_bolt/core/api_helper/dio_helper.dart';
import 'package:supply_chain_bolt/features/auth/logic/distributor_auth_cubit.dart';

import '../../features/auth/data/data_source/auth_api_service.dart';
import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/logic/manager_auth_cubit.dart';
import '../../features/orders/data/datasources/order_remote_data_source.dart';
import '../../features/orders/data/repositories/order_repository.dart';
import '../../features/orders/presentation/cubit/order_cubit.dart';

final GetIt locator = GetIt.instance;

Future<void> setupGetIt() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);

  // Dio
  locator.registerLazySingleton<ApiHelper>(() => DioHelper());

  // Data Sources
  locator.registerLazySingleton<AuthApiService>(() => AuthApiService(locator<ApiHelper>()),);
  locator.registerLazySingleton<AuthRepo>(() => AuthRepo(locator<AuthApiService>()),);
  locator.registerLazySingleton<DistributorAuthCubit>(() => DistributorAuthCubit(locator<AuthRepo>()),);
  locator.registerLazySingleton<ManagerAuthCubit>(() => ManagerAuthCubit(locator<AuthRepo>()),);














  locator.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(
      dio: locator(),
      baseUrl: 'https://your-api-base-url.com/api',
    ),
  );

  // Repositories
  locator.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(locator()),
  );

  // Cubits
  locator.registerFactory(() => OrderCubit(locator()));
}
