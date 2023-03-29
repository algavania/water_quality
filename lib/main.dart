import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import 'app/common/app_theme_data.dart';
import 'app/common/color_values.dart';
import 'app/repositories/repositories.dart';
import 'app/routes/router.gr.dart';
import 'services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, __, ___) {
      return GlobalLoaderOverlay(
        useDefaultLoading: false,
        closeOnBackButton: true,
        overlayWidget: const Center(
            child: SpinKitChasingDots(
              color: ColorValues.primaryBlue,
              size: 50.0,
            )),
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => MeterRepository(),
            ),
          ],
          child: MaterialApp.router(
            theme: AppThemeData.getTheme(context),
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
          ),
        ),
      );
    });
  }
}