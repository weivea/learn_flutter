import 'package:flutter/material.dart';
import 'routes.dart';
import 'page/MainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'weivea learn flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        pageTransitionsTheme: PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.iOS: _IosPageTransitionsBuilder(), 
          }
        ),
        // platform: TargetPlatform.iOS,
        primarySwatch: Colors.teal,
      ),

      // routes: appRoutes,
      home: MainViewPage(appRoutes.keys.toList(growable: false)),
    );
  }
}


class _IosPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(PageRoute<T> route, BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    print(child.runtimeType);
    print('aaaaaaaaaaaaaaaa');
    return SlideTransition(
          // 右边划进来
          position: Tween<Offset>(
              begin: Offset(-1.0, 0.0),
              end: Offset(0.0, 0.0)
          ).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
          // child: child,
          child:FadeTransition(//渐变过渡 0.0-1.0
            opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animation, //动画样式
              curve: Curves.fastOutSlowIn, //动画曲线
            )),
            child: child,
          ),
        );
  }
}