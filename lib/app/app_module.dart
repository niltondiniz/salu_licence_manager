import 'modules/user/user/user_controller.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:dio/dio.dart';
import 'package:salu_licence_manager/shared/repositories/client_repository.dart';
import 'package:salu_licence_manager/shared/util/consts.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:salu_licence_manager/app/app_widget.dart';

import 'modules/home/home_controller.dart';
import 'modules/home/home_page.dart';
import 'modules/user/user/user_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $UserController,
        $AppController,
        $HomeController,
        Bind((i) => Dio(BaseOptions(baseUrl: URL_ENDPOINT))),
        Bind((i) => ClientRepository(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          Modular.initialRoute,
          child: (context, args) => AnimatedSplash(
            imagePath: "assets/images/salu.jpeg",
            home: HomePage(),
            duration: 5500,
            type: AnimatedSplashType.StaticDuration,
          ),
        ),
        ModularRouter("/user/:index",
            child: (_, args) => UserPage(
                  index: args.params['index'],
                )),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
