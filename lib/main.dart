import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:untitled/app/resources/resources.dart';
import 'package:untitled/app/ui/base_app/base_app_part.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUiOverlayStyle);

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );

  await AppDependencies().setDependencies();

  Bloc.observer = TalkerBlocObserver(
    talker: injection(),
    settings: const TalkerBlocLoggerSettings(printChanges: true),
  );

  runApp(const BaseApp());
}


