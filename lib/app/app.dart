import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router/router.dart';
import 'theme/colors.dart';
import 'theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Socially',
      color: AppColors.primary,
      theme: theme,
      locale: Locale('en'),
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      builder: (context, child) {
        return child ?? SizedBox();
      },
      routerConfig: router,
    );
  }
}
