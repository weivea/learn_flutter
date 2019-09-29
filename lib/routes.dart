import 'package:flutter/material.dart';
import 'page/FirstDemo.dart';
import 'page/AssetsDemo.dart';
import 'page/NetworkImageDemo.dart';
import 'page/RouteDemo.dart';
final Map<String, WidgetBuilder> appRoutes = {
  '第一个demo -> ' : (context) => FirstDemo(),
  '资源获取 -> ' : (context) => AssetsDemo(),
  '网络图片 -> ' : (context) => NetworkImageDemo(),
  '路由跳转 -> ' : (context) => RouteDemo(),
};


class AnimationRoute extends PageRouteBuilder {

  final Widget widget;

  AnimationRoute(this.widget, {RouteSettings settings})
      : super(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 400), //设置动画时长500毫秒
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation){
        return widget;
      },
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child
          ){
        //渐变过渡
//      return FadeTransition(//渐变过渡 0.0-1.0
//        opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//          parent: animation1, //动画样式
//          curve: Curves.fastOutSlowIn, //动画曲线
//        )),
//        child: child,
//      );
        //翻转缩放
//      return RotationTransition(
//        turns: Tween(begin: 0.0, end: 1.0).
//        animate(
//          CurvedAnimation(
//            parent: animation1,
//            curve: Curves.fastOutSlowIn,
//          )
//        ),
//        child: ScaleTransition(
//          scale: Tween(begin: 0.0, end: 1.0).
//          animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
//          child: child,
//        ),
//      );
        //左右滑动
        return SlideTransition(
          // 右边划进来
          position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
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

 /*          ---------------- */
//          child: SlideTransition(
//            // push进来新的页面时， 当前页面从左边划出去
//            position: Tween<Offset>(
//              begin: Offset.zero,
//              end: const Offset(-1.0, 0.0),
//            ).animate(CurvedAnimation(parent: secondaryAnimation, curve: Curves.fastOutSlowIn)),
//            child: child,
//          ),
        );
      }

  );


}
