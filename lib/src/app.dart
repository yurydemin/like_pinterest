import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_pinterest/src/blocs/images/images_bloc.dart';
import 'package:like_pinterest/src/blocs/images/images_event.dart';
import 'package:like_pinterest/src/di/main_module.dart';
import 'package:like_pinterest/src/internals/routes.dart';
import 'package:like_pinterest/src/screens/main_screen.dart';

class LikePinterestApp extends StatelessWidget {
  const LikePinterestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      routes: {
        LikePinterestAppRoutes.main: (context) {
          return BlocProvider(
            create: (context) =>
                MainModule().get<ImagesBloc>()..add(LoadImages()),
            child: const MainScreen(),
          );
        }
      },
    );
  }
}
