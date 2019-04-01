import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
/**
 * 轮播 使用第三方组件flutter_swiper
 * 自定义appBar，监听滚动通知，通过滚动值设置透明度，NotificationListener通知监听。
 * 在NotificationListener通知中判断是否是滚动notification is ScrollUpdateNotification，并且通知深度depth为0
 */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List swiperImages = [
    'http://bjascdn.scv.pw/uploads/userfiles/1/images/pageimg/20190328/1-1Z32Q5500Y-4.jpg',
    'http://bjascdn.scv.pw/uploads/userfiles/1/images/pageimg/20190328/1-1Z32Q550096-0.jpg',
    'http://bjascdn.scv.pw/uploads/userfiles/1/images/pageimg/20190328/1-1Z32Q550118-1.jpg'
  ];
  double _appBarOpacity = 0;

  _onscroll(offset) {
    var alpha = offset / 100;
    if (alpha > 1) alpha = 1.0;
    if (alpha < 0) alpha = 0;

    setState(() {
      _appBarOpacity = alpha;
    });
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
                    child: ListTile(
                      title: Text('内容'),
                    ),
                  )
                ],
              ),
              Opacity(
                opacity: _appBarOpacity,
                child: Container(
                  height: 80,
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Text('首页'),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
