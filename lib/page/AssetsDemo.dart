import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;

// 加载文本assets
Future<String> _loadAsset() async {
  await Future.delayed(Duration(seconds: 3));
  return await rootBundle.loadString('README.md');
}

class AssetsDemo extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // 获取裸游参数
    final Map routeArguments = ModalRoute.of(context).settings.arguments;
    final padding = EdgeInsets.all(18);
    return Scaffold(
      appBar: AppBar(
        title: Text(routeArguments['title']),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(title: Text('图片:'),),
          Padding(
            padding: padding,
            child: Center(
              child: Image.asset('assets/img/g1.jpeg',),
            ),
          ),
          ListTile(title: Text('加载文本:'),),
          Padding(
            padding: padding,
            child: FutureBuilder<String>(
              future: _loadAsset(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 请求已结束
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // 请求成功，显示数据
                    return MarkdownBody(data: snapshot.data as String);
                  }
                } else {
                  // 请求未结束，显示loading
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ),
          Padding(
            padding: padding,
            child: MarkdownBody(data: _desc),
          )
        ],
      ),
    );
  }
}

const _desc = '''
# 说明
pubspec.yaml配置
```yaml
flutter:
  assets:
    - assets/img/ # 只会检索当前文件夹下的文件，不会再递归减速里边的文件夹
    - README.md # 直接写一个文件
```

此处使用了 flutter_markdown 包: https://pub.dev/packages/flutter_markdown
''';