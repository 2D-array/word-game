import 'package:flutter/material.dart';
import 'package:word_game/core/router/app_router.dart';

import 'core/get_it/get_it.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(MaterialApp.router(
    routerConfig: AppRouter.router,
    theme: AppTheme.getTheme(),
  ));
}

