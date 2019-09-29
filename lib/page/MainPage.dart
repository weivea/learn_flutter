import 'package:flutter/material.dart';
import '../routes.dart';

class MainViewPage extends StatelessWidget {
  MainViewPage(this.verList);
  final List verList;
  @override
  Widget build(BuildContext context) {
    Widget divider=Divider(color: Color.fromRGBO(0, 0, 0, 0), height: 3,);
    return Scaffold(
      appBar: AppBar(
       title: Text("学习flutter"),
      ),

      // ListView加分割线生成列表
      body: ListView.separated(

        itemBuilder: (context, position) {
          return _buildItem(context, position);
        },
        itemCount: verList.length,
        separatorBuilder: (context, index) {
          return divider;
        },
      ),
    );
  }
  Widget _buildItem(context, int position) {
    return GestureDetector(
      onTap: () {
        _goRoutePage(context, verList[position]);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        color: Colors.teal[50],
        height: 60,
        child: Text(
          verList[position],
          style: TextStyle(color: Colors.black12, fontSize: 24.0),
        ),
        padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
      ),
    );
  }
  void _goRoutePage(context, String routeName) {
    Navigator.push(context, AnimationRoute(appRoutes[routeName](context), settings: RouteSettings(arguments: {'title': routeName})));
  }
}

