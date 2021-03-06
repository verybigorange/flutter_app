import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/**
 * 轮播 使用第三方组件flutter_swiper
 * 自定义appBar，监听滚动通知，通过滚动值设置透明度，NotificationListener通知监听。
 * 在NotificationListener通知中判断是否是滚动notification is ScrollUpdateNotification，并且通知深度depth为0
 */

// 问题1：fromJson

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final List swiperImages = [
    'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2881408673,3616376270&fm=26&gp=0.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554207929906&di=e4bc91b66e09b1bd48117d63f2df86b3&imgtype=0&src=http%3A%2F%2Fy1.ifengimg.com%2F2ac40edab0b13ed8%2F2015%2F1113%2Frdn_56459f9bdb4d1.jpg',
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=606702204,954914287&fm=26&gp=0.jpg',
    'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2419591398,3599638563&fm=26&gp=0.jpg'
  ];
  double _appBarOpacity = 0;

  List<dynamic> rangeList = [];

  _onscroll(offset) {
    var alpha = offset / 100;
    if (alpha > 1) alpha = 1.0;
    if (alpha < 0) alpha = 0;

    setState(() {
      _appBarOpacity = alpha;
    });
  }

  void _getRangeData() {
    http.get('https://api.apiopen.top/musicRankings').then((response) {
      var res = json.decode(response.body);
      if (res["code"] == 200) {
        setState(() {
          rangeList = List.from(res["result"]);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRangeData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification &&
                notification.depth == 0) {
              _onscroll(notification.metrics.pixels);
            }
          },
          child: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  Container(
                    height: 200,
                    child: new Swiper(
                      itemHeight: 200,
                      itemBuilder: (BuildContext context, int index) {
                        return new Image.network(
                          swiperImages[index],
                          fit: BoxFit.fill,
                        );
                      },
                      autoplay: true,
                      itemCount: swiperImages.length,
                      pagination: new SwiperPagination(),
                      control: new SwiperControl(color: Colors.grey[50]),
                    ),
                  ),
                  Container(
                      height: 800,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Row(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.hot_tub,
                                      color: Colors.red,
                                    )),
                                Text('排行榜')
                              ],
                            ),
                          ),
                          Padding(
                            child: Column(
                              children: _buildRangeItem(rangeList),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          )
                        ],
                      ))
                ],
              ),
              Opacity(
                opacity: _appBarOpacity,
                child: Container(
                  height: 80,
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Text('音乐'),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

List<Widget> _buildRangeItem(List<dynamic> rangeList) {
  List<Widget> items = [];
  rangeList.forEach((value) => {items.add(_rangeItem(value))});

  return items;
}

Widget _rangeItem(item) {
  return Container(
      child: Padding(
    padding: EdgeInsets.only(bottom: 30),
    child: Row(
      children: <Widget>[
        Padding(
          child: Image.network(
            item['pic_s444'],
            height: 100,
            width: 120,
            fit: BoxFit.fill,
          ),
          padding: EdgeInsets.only(right: 10),
        ),
        Row(
          children: <Widget>[
            Column(
              children: _Music(item['content']),
              crossAxisAlignment: CrossAxisAlignment.start,
            )
          ],
        )
      ],
    ),
  ));
}

List<Widget> _Music(List<dynamic> list) {
  List<Widget> items = [];
  list.forEach((value) => {items.add(_MusicItem(value))});
  return items.sublist(0, 3);
}

// 排行榜中的每个歌曲元素
Widget _MusicItem(item) {
  return Container(
      child: Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            children: <Widget>[
              Padding(
                child: Image.network(item['pic_big'], height: 40, width: 40),
                padding: EdgeInsets.only(right: 10),
              ),
              Column(
                children: <Widget>[
                  ConstrainedBox(
                    child: Text(
                      item['title'],
                      overflow: TextOverflow.ellipsis,
                    ),
                    constraints: BoxConstraints(maxWidth: 200),
                  ),
                  Text(
                    item['author'],
                    maxLines: 2,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              )
            ],
          )));
}
