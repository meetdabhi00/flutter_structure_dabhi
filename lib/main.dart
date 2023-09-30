import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure_meet/constants/app_colors.dart';
import 'package:flutter_project_structure_meet/constants/route_path.dart';
import 'package:flutter_project_structure_meet/constants/shared_preference_constants.dart';
import 'package:flutter_project_structure_meet/data/remote/network_api_service.dart';
import 'package:flutter_project_structure_meet/data/service/dio_connectivity_retrier.dart';
import 'package:flutter_project_structure_meet/data/service/logging_interceptor.dart';
import 'package:flutter_project_structure_meet/data/service/retrier_interceptor.dart';
import 'package:flutter_project_structure_meet/global.dart';
import 'package:flutter_project_structure_meet/provider/app_provider.dart';
import 'package:flutter_project_structure_meet/provider/common_provider.dart';
import 'package:flutter_project_structure_meet/utils/router.dart';
import 'package:flutter_project_structure_meet/utils/shared_preference.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize easy localization for internationalization
  await EasyLocalization.ensureInitialized();

  // initialize shared preference
  await SharedPref.instance.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      //change the path of the translation files
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppProvider()),
          ChangeNotifierProvider(create: (_) => CommonProvider()),
        ],
        builder: (context, child) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    interceptorsDio();
    AppColor.loadLight();
  }

  // initialize dio and add interceptors
  void interceptorsDio() {
    var dio = NetworkApiService.client;
    dio.interceptors.addAll([
      LoggingInterceptor(),
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        // designSize: const Size(600, 1020),
        designSize: const Size(834, 1194),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            navigatorKey: navigator,
            locale: context.locale,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            onGenerateRoute: generateRoute,
            initialRoute: SharedPref.instance.shared
                        .getString(SharePrefConstants.token) !=
                    null
                ? RoutePath.home_screen
                : RoutePath.home_screen,
          );
        });
  }
}
