import 'package:flutter/material.dart';
import 'dart:math';

class CutomNestScroll extends StatefulWidget {
  CutomNestScroll({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _CutomNestScrollState createState() => _CutomNestScrollState();
}

class _CutomNestScrollState extends State<CutomNestScroll> {
  ScrollController scrollController;
  ScrollController scrollController2;
  int overscrollNotificationCount = 0;
  double scrollController2Offset = 0.0;
  bool shuldResetScrollController2 = false;
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController2 = ScrollController();
    scrollController.addListener((){
      // 内部的 滚动offset不能保持，当它不在视窗之后，offset会重置为0~，打个补丁~
      if (scrollController2.positions.isEmpty) {
        shuldResetScrollController2 = true;
      } else {
        if (shuldResetScrollController2) {
          scrollController2.jumpTo(scrollController2Offset);
          shuldResetScrollController2 = false;
        }
        scrollController2Offset = scrollController2.offset;
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(CutomNestScroll oldWidget) {
    overscrollNotificationCount = 0;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollController2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Map routeArguments = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(routeArguments['title']),
      ),
      body: ListView(
        controller: scrollController,
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Container(
            height: 300.0,
            color: Colors.black12,
            child: NotificationListener(
              onNotification: _handleInnerScrollDrag,
              child: ListView(
                controller: scrollController2,
                children: <Widget>[
                  Container(
                    height: 80.0,
                    child: Text('内部嵌套滚动', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent)),
                  ),
                  Container(
                    height: 80.0,
                    child: Text('内部嵌套滚动', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent)),
                  ),
                  Container(
                    height: 80.0,
                    child: Text('内部嵌套滚动', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent)),
                  ),
                  Container(
                    height: 80.0,
                    child: Text('内部嵌套滚动', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent)),
                  ),
                  Container(
                    height: 80.0,
                    child: Text('内部嵌套滚动', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent)),
                  ),
                  Container(
                    height: 80.0,
                    child: Text('data', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent)),
                  ),
                  Container(
                    height: 80.0,
                    child: Text('data', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent)),
                  ),
                  Container(
                    height: 80.0,
                    child: Text('data', style: TextStyle(fontSize: 20.0, color: Colors.blueAccent)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 80.0),
            child: Text('占位置'),
          ),
        ],
      ),
    );
  }

  bool _handleInnerScrollDrag(Notification notification) {
    // 内部overscroll触发第二次才开始手动滚动外部scroll
    if (notification is OverscrollNotification) {
      if (overscrollNotificationCount > 0) {
        print(notification.overscroll);
        scrollController.jumpTo(scrollController.offset + notification.overscroll);
      }
      overscrollNotificationCount++;
    } else if (notification is ScrollEndNotification) {
      // 内部滚动结束
      overscrollNotificationCount = 0; // 重置
      if (notification.dragDetails != null) { // 此时如果还有拖拽的速度，则实现一个惯性动画
        // 初速的
        double v= notification.dragDetails.primaryVelocity;
        // 处理一下
        if (v==0) {
          return false;
        } else if (v>0) {
          v = pow(v, 2.6/3);
        } else if (v<0) {
          v = 0 - pow(v.abs(), 2.6/3);
        }
        
        double a = 600.0;//减速度
        double t = (v.abs()/a); // 时间
        double s= v*t/2; // 距离
        int milliseconds = (t*1000.0).toInt();
        scrollController.animateTo(scrollController.offset - s, duration: Duration(milliseconds: milliseconds), curve: Curves.easeOutExpo);
      }
      
    }
    return false;
  }

}