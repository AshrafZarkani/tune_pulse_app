import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:tune_pulse/app/services/storage/local_provider.dart';
import 'app/config/barrel_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final providerContainer = ProviderContainer();

void main(List<String> args) {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    final localeNotifier = ref.watch(localeProvider.notifier);
    final selectedLocale = ref.watch(localeProvider);

    localeNotifier.loadSavedLocale();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: "TunePulse",
        themeMode: ThemeMode.light,
        theme: MyTheme.lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: selectedLocale,
      ),
    );
  }
}
