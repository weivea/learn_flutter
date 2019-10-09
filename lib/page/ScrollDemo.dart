import 'package:flutter/material.dart';

class ScrollDemo extends StatefulWidget {
  ScrollDemo({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ScrollDemoState createState() => _ScrollDemoState();
}

class _ScrollDemoState extends State<ScrollDemo> {
  final _tabs = <String>['TabA', 'TabB'];
  final colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.deepPurple
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerScrolled) => <Widget>[
                    SliverOverlapAbsorber(
                      // 传入 handle 值，直接通过 `sliverOverlapAbsorberHandleFor` 获取即可
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      child: SliverAppBar(
                        pinned: true,
                        title: const Text('NestedScrollView'),

                        expandedHeight: 200.0,
                        flexibleSpace: FlexibleSpaceBar(
                          
                          background: Image.asset('assets/img/zhuzhu.jpeg', fit: BoxFit.cover)
                        ),
                        // bottom: Btab(child: Text('data'),height: 50,),
                        bottom: TabBar(
                            indicator: BoxDecoration(
                              border: new Border.all(width: 2.0, color: Colors.red),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Color.fromRGBO(255,255,255, 0.1),
                            ),
                            labelColor: Colors.black87,
                            unselectedLabelColor: Colors.black38,
                      
                            labelPadding: EdgeInsets.zero,
                            tabs: _tabs
                                .map((tab) =>Tab(text: tab))
                                .toList()),
                        forceElevated: innerScrolled,
                      ),
                    )
                  ],
              body: TabBarView(
                  children: _tabs
                      // 这边需要通过 Builder 来创建 TabBarView 的内容，否则会报错
                      // NestedScrollView.sliverOverlapAbsorberHandleFor must be called with a context that contains a NestedScrollView.
                      .map((tab) => Builder(
                            builder: (context) => CustomScrollView(
                              // key 保证唯一性
                              key: PageStorageKey<String>(tab),
                              slivers: <Widget>[
                                // 将子部件同 `SliverAppBar` 重叠部分顶出来，否则会被遮挡
                                SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context)),
                                SliverGrid(
                                    delegate: SliverChildBuilderDelegate(
                                        (_, index) =>
                                            Image.asset('assets/img/g1.jpeg'),
                                        childCount: 8),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 10.0,
                                            crossAxisSpacing: 10.0)),
                                SliverFixedExtentList(
                                    delegate: SliverChildBuilderDelegate(
                                        (_, index) => Container(
                                            child: Text(
                                                '$tab - item${index + 1}',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: colors[index % 6])),
                                            alignment: Alignment.center),
                                        childCount: 20),
                                    itemExtent: 50.0)
                              ],
                            ),
                          ))
                      .toList()))),
    );
  }
}

class Btab extends StatelessWidget implements PreferredSizeWidget {

  final double _h;
  final Widget child;
  Btab({double height, @required this.child}) : _h = height ?? 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _h,
      child: child,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_h);
}
