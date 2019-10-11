import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TabViewDemo extends StatefulWidget {
  TabViewDemo({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _TabViewDemoState createState() => _TabViewDemoState();
}

class _TabViewDemoState extends State<TabViewDemo> with TickerProviderStateMixin {


  TabController mController;
  List<TabPayload> tabList;
  ScrollController scontroller = ScrollController(keepScrollOffset:true);
  @override
  void initState() {
    super.initState();
    initTabData();
    mController = TabController(
      length: tabList.length+1,
      vsync: this,
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }
  
  initTabData() {
    tabList = [
      new TabPayload('推荐', 10),
      new TabPayload('热点', 20),
      new TabPayload('社会', 10),
      new TabPayload('娱乐', 2, tailNum: 10),
      new TabPayload('体育', 3, tailNum: 20),
      new TabPayload('美文', 4, tailNum: 12),
      new TabPayload('科技', 5),
      new TabPayload('财经', 6),
      new TabPayload('时尚', 7)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Map routeArguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(routeArguments['title']),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xfff4f5f6),
            height: 40,
            child: TabBar(
              isScrollable: true,
              //是否可以滚动
              controller: mController,
              labelColor: Colors.red,
              unselectedLabelColor: Color(0xff666666),
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: _getTabs(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: mController,
              children: _getTabViews(),
            ),
          )
        ],
      )
    );
  }
  List<Widget> _getTabs() {
    List<Widget> re = tabList.map((item) {
      return Tab(
        text: item.title,
      );
    }).toList();
    re.add(Tab(
      text: '说明',
    ));
    return re;
  }
  List<Widget> _getTabViews() {
    List<Widget> re = tabList.map((tabPayload) {
      Widget r = TabPage(tabPayload);
      return r;
    }).toList();
    re.add(ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: MarkdownBody(data: _desc),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return Scaffold(
                body: Center(
                  child: Text('哈哈哈哈~'),
                ),
              );
            }));
          },
          child: Text("点我"),
          textColor: Color(0xffff0000),
          color: Color(0xfff1f1f1),
          highlightColor: Color(0xff00ff00),
        )
      ],
    ));
    return re;
  }
}


/*
 *tab分页
 *   */
class TabPage extends StatefulWidget{
  final TabPayload tabPayload;
  TabPage(this.tabPayload, {Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}
class _TabPageState extends State<TabPage> with AutomaticKeepAliveClientMixin {


  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget sw= super.build(context);
    print('------------------------');
    print(sw);
    print('------------------------');
    var tabPayload = widget.tabPayload;
    int itemCount = tabPayload.contentNum;
    if (tabPayload.tailNum != null) {
      itemCount++;
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: ListView.separated (
        itemCount: itemCount,
        separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black26,),
        itemBuilder: (BuildContext context, int index) {
          return _listItem(context, index, tabPayload);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive {
    print('wantKeepAlive-${widget.tabPayload.title}');
    return true;
  }

  Widget _listItem(BuildContext context, int index, TabPayload tabPayload){
    if (tabPayload.contents.length>index)
      print(tabPayload.contents[index]);
    if (index < tabPayload.contentNum) {
      return ListTile(
        leading: Container(
          width: 30,
          child: Center(
            child: Text((index+1).toString()),
          ),
        ),
        title: Text(tabPayload.contents[index]),
      );
    } else {
      return Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tabPayload.tailNum,
          itemBuilder: (BuildContext context, int index){
            return Container(
              color: Colors.lightBlue,
              height: 100,
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text('横向滚动$index',style: TextStyle(fontSize: 28.0)),
                
              ),
            );
          },
        ),
      );
    }
  }
}


class TabPayload {
  String title;
  int contentNum;
  int tailNum;
  List<String> _contents;

  TabPayload(this.title, this.contentNum, {this.tailNum}):assert(contentNum>0) {
    var re = <String>[];
    var list = List<String>(contentNum);
    for(var i=0; i < contentNum; i++) {
      list[i] = '$title:data-$i';
    }
    re.addAll(list);

    _contents = list;
  }

  List<String> get contents => _contents;
}

var _desc = '''
# Flutter: PageView/TabBarView等控件保存状态的问题解决方案
## 前言:
通常在用到 PageView + BottomNavigationBar 或者 TabBarView + TabBar 的时候大家会发现当切换到另一页面的时候, 前一个页面就会被销毁, 再返回前一页时, 页面会被重建, 随之数据会重新加载, 控件会重新渲染 带来了极不好的用户体验.
下面是一些解决方案:

### 解决方案一:
使用 AutomaticKeepAliveClientMixin (官方推荐做法)
由于TabBarView内部也是用的是PageView, 因此两者的解决方式相同. 下面以PageView为例
这种方式在老版本并不好用, 需要更新到比较新的版本.

Flutter 0.5.8-pre.277 • channel master • github.com/flutter/flu…
Framework • revision e5432a2843 (6 days ago) • 2018-08-08 16:45:08 -0700
Engine • revision 3777931801
Tools • Dart 2.0.0-dev.69.5.flutter-eab492385c

以上我在写这篇文章的时候的版本, 但具体以哪个版本为分界线我不清楚.
通过以下命令可以查看Flutter的版本

flutter --version

通过以下命令可以切换Flutter Channel(对应于它的git的branch)

flutter channel master

master 是 channel 的名字, 目前有: beta dev 和 master. 从代码更新频率上讲 master > dev > beta

### 具体做法:
让 PageView(或TabBarView) 的 children 的State 继承 AutomaticKeepAliveClientMixin
示例如下:

```
import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    home: Test6(),
  ));
}

class Test6 extends StatefulWidget {
  @override
  Test6State createState() {
    return new Test6State();
  }
}

class Test6State extends State<Test6> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    List<int> pages = [1, 2, 3, 4];
    List<int> data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        children: pages.map((i) {
          return Container(
            height: double.infinity,
            color: Colors.red,
            child: Test6Page(i, data),
          );
        }).toList(),
        controller: _pageController,
      ),
    );
  }
}

class Test6Page extends StatefulWidget {
  final int pageIndex;
  final List<int> data;

  Test6Page(this.pageIndex, this.data);

  @override
  _Test6PageState createState() => _Test6PageState();
}

class _Test6PageState extends State<Test6Page> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.data.map((n) {
        return ListTile(
          title: Text("第\${widget.pageIndex}页的第\$n个条目"),
        );
      }).toList(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
```

### 总结:
PageView 的children需要继承自 StatefulWidget
PageView 的children对应的 State 需要继承自 AutomaticKeepAliveClientMixin


**注意: 上述方法有一些朋友反馈说在一些情况下, 例如跳转进入子页面在返回时, 页面还是会刷新.**
这时你需要检查你混入了 AutomaticKeepAliveClientMixin 的 State
在 AutomaticKeepAliveClientMixin 源码中, 若干方法都调用了 _ensureKeepAlive(), 这是之所以能够保持状态的关键.
这其中包括了 build(BuildContext context). 而在此之前你很可能就已经实现了 State 的 build 方法, 因此没有注意到 AutomaticKeepAliveClientMixin 的 build 方法有一个 @mustCallSuper 的注解.
那么解决方法也就是在你实现的 build 方法顶部加上 super.build(context);
另外也需要注意其它涉及到的方法是否都按照要求实现, 善用 Lint 工具.


具体参考：https://juejin.im/post/5b73c3b3f265da27d701473a

''';