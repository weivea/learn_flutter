import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

typedef CutomItemBuilder = Widget Function(BuildContext context, int ind);

class NetworkImageDemo extends StatelessWidget {
  
  final _builderList = <CutomItemBuilder>[];

  @override
  Widget build(BuildContext context) {
    // 获取裸游参数
    final Map routeArguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(routeArguments['title']),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 24,
        itemBuilder: _listItemBuilder,
      ),
    );
  }
  Widget _listItemBuilder(BuildContext context, int position) {
    if (_builderList.isEmpty) {
      // 网络图片: 展示加载进度
      _builderList.addAll([
        (context, position) => ListTile(title: Text('网络图片: 展示加载进度')),
        _processNetImage,
      ]);

      // 来20个网络懒加载图片
      _builderList.add((context, position) => ListTile(title: Text('网络图片: 懒加载动效')));
      var list = List<CutomItemBuilder>(20);
      list.fillRange(0, 20, _lazyImage);
      _builderList.addAll(list);
      // _builderList.add(_lazyImage);

      // 描述
      _builderList.add((context, position) => Padding(
        padding: EdgeInsets.all(18),
        child: MarkdownBody(data: _desc),
      ));

    }

    CutomItemBuilder builder = (position <= _builderList.length-1) ? _builderList[position] : (context, position) => Text('null');
    return builder(context, position);
  }
  // 展示加载进度
  Widget _processNetImage(BuildContext context, int ind) {

    return Padding(
      padding: EdgeInsets.all(18),
      child: Container(
        height: 200,
        child: Center(
          child: Image.network(
            "https://i0.hdslb.com/bfs/article/da7df8e1b4080635932de94ec90aa8c40ec81821.jpg", 
            height: 200, 
            fit: BoxFit.fitHeight,
            loadingBuilder: _loadingBuilder,
          ),
        )
      ),
    );
  }
  
  // 懒加载图片 渐变淡入效果
  Widget _lazyImage(BuildContext context, int ind) {
    // 为了看效果，这里是为了造不一样的URL，flutter 自己回缓存相同URL的图片
    var src = 'https://img20.360buyimg.com/vc/g6/M03/05/16/rBEGC1DZxdEIAAAAAAFbYvZtZPcAABHVwJAsKUAAVt6230.jpg?tttt1=${ind.toString()}21';
    print(src);
    return Padding(
      padding: EdgeInsets.all(18),
      child: Container(
        height: 100,
        child: Center(
          child: Image.network(
            src, 
            height: 100, 
            fit: BoxFit.fitHeight,
            frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded){
              if (wasSynchronouslyLoaded){
                return child;
              }
              
              return AnimatedOpacity(
                child: child,
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
              );
            },
          ),
        )
      ),
    );
  }
  
  // 加载进度
  Widget _loadingBuilder(BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
    if (loadingProgress == null)
      return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
      : null,
      ),
    );
  }
}

const _desc = '''
# 说明
相同url的图片被加载后flutter会缓存对应图片在内存，下次打开没有相应的动画，而是直接展示~; 
下次打开app后需要再次从网络请求~

## 这里访问了网络，需要添加access配置：
Android 项目下 AndroidManifest.xml
```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.weivea.learn_flutter">

    <!-- 访问网络 -->
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    
    <!-- 其它配置 -->

</manifest>
```
''';