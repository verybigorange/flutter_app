import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
 
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Container(
          height: 200,
          child: new Swiper(
            itemBuilder: (BuildContext context, int index) {
              return new Image.network(
                swiperImages[index],
                fit: BoxFit.fill,
              );
            },
            autoplay:false,
            itemCount: swiperImages.length,
            pagination: new SwiperPagination(),
            control: new SwiperControl(
              color:Colors.grey[50]
            ),
          ),
        )
      ],
    ));
  }
}
