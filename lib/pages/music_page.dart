import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/**
 * 轮播 使用第三方组件flutter_swiper
 * 自定义appBar，监听滚动通知，通过滚动值设置透明度，NotificationListener通知监听。
 * 在NotificationListener通知中判断是否是滚动notification is ScrollUpdateNotification，并且通知深度depth为0
 */
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
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
