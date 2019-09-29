import 'package:flutter/material.dart';
import 'dart:math';

class RouteDemo extends StatefulWidget {
  RouteDemo({Key key}) : super(key: key);

  @override
  _RouteDemoState createState() {
    return _RouteDemoState();
  }
}


class _RouteDemoState extends State<RouteDemo> with TickerProviderStateMixin{
  AnimationController _controllerTest;

  @override
  void initState() {
    _controllerTest =  AnimationController(
      duration: const Duration(milliseconds: 2000), 
      vsync: this
    );
    print(_controllerTest);
    _controllerTest.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 获取裸游参数
    final Map routeArguments = ModalRoute.of(context).settings.arguments;
    GlobalKey _key = GlobalKey();
    
    print(_controllerTest);
    return Scaffold(
      appBar: AppBar(
        title: Text(routeArguments['title']),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 80,
            child: Center(
              child: Text('占个位置'),
            ),
          ),
          Container(
            color: Colors.lightBlue,
            child: ListTile(
              key: _key,
              // 小惊喜，闭包传参~啦啦啦
              onTap: ((param) => () {
                    print(param);
                    RenderBox box = _key.currentContext.findRenderObject();
                    Offset offset = box.localToGlobal(Offset.zero);
                    //获取size
                    Size size = box.size;
                    print(offset);
                    _routeToNextPage(context, param, offset: offset, size: size);
                  })('1111'),
              leading: Icon(
                Icons.adjust,
                size: 30,
                color: Colors.deepPurple,
              ),
              title: Text('路由跳转动画', style: TextStyle(color: Colors.white),),
            ),
          ),
          Container(
            height: 100.0,
            
            child: Stack(
              children: <Widget>[
                SizeTransition(
                  axis: Axis.vertical, //控制宽度或者高度缩放
                  sizeFactor: Tween(begin: 1.0, end: 0.5).animate(_controllerTest),
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.red,
                    child: Text('12345678'),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _routeToNextPage(BuildContext parentContext, dynamic params, {Offset offset, Size size}) {
    var contextSize = parentContext.size;
    Navigator.push(
        parentContext,
        PageRouteBuilder(
            settings: RouteSettings(arguments: params), // 传递数据到下一页
            transitionDuration: const Duration(milliseconds: 700), //设置动画时长500毫秒
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return NextPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              // 默认走正常的 slider 动画
              if (offset == null || size == null) {
                return SlideTransition(
                  // 右边划进来
                  position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(CurvedAnimation( 
                    parent: animation, 
                    curve: Curves.fastOutSlowIn)
                  ),
                  child: FadeTransition(
                    //渐变过渡 0.0-1.0
                    opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation, //动画样式
                      curve: Curves.fastOutSlowIn, //动画曲线
                    )),
                    child: child,
                  ),
                );
              }

              // 锚点切入动画
              
              var tweenHBegin = size.height/contextSize.height;
              tweenHBegin = (tweenHBegin > 1.0) ? 1.0 : tweenHBegin;
              var tweenOffsetY = offset.dy/contextSize.height;
              if (tweenOffsetY < -1.0) {
                tweenOffsetY = -1.0;
              } else if (tweenOffsetY > 1.0) {
                tweenOffsetY = 1.0;
              }
              var tweenOffsetBegin = Offset(0.0, tweenOffsetY);
              print(tweenOffsetBegin);
              print(tweenHBegin);
              var animationCustom = Tween(begin: acos(tweenHBegin), end: 0.0).animate(CurvedAnimation( 
                  parent: animation, 
                  curve: Curves.fastOutSlowIn));
              
              return SlideTransition(
                // 位置过度
                position: Tween<Offset>(begin: tweenOffsetBegin, end: Offset(0.0, 0.0)).animate(CurvedAnimation( 
                  parent: animation, 
                  curve: Curves.fastOutSlowIn)
                ),
                // child: child,
                child: FadeTransition(
                  //透明度渐变过渡 0.0-1.0
                  opacity: Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
                    parent: animation, //动画样式
                    curve: Curves.fastOutSlowIn, //动画曲线
                  )),
                  child: AnimatedBuilder(
                    animation: animationCustom,
                    child: child,
                    builder: (BuildContext ctx, Widget child) {
                      return  Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.rotationX(animationCustom.value),
                        child: child,
                      );
                    },
                  ),
                ),
              );
              
              

              
            }));
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 接收参数
    var routeArguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      
      // appBar: AppBar(
      //   title: Text('NextPage'),
      // ),
      backgroundColor: Colors.lightBlue,
      body: Center(
        
        child: Text('accept: ${routeArguments.toString()}', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}