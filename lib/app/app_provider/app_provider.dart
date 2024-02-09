import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/app/ui/splash/bloc/splash_bloc.dart';

class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SplashBloc(
            splashUseCase: injection(),
          )..add(SplashStart()),
        ),
      ],
      child: child,
    );
  }
}

class MainProvider extends StatelessWidget {
  final Widget child;

  const MainProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: child,
    );
  }
}
