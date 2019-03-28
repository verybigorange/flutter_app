import 'package:flutter/material.dart';
import 'package:flutter_project/pages/home_page.dart';
import 'package:flutter_project/pages/my_page.dart';
import 'package:flutter_project/pages/search_page.dart';
import 'package:flutter_project/pages/travel_page.dart';

class TapNavigator extends StatefulWidget {
  @override
  _TapNavigatorState createState() => _TapNavigatorState();
}

class _TapNavigatorState extends State<TapNavigator> {
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.blue;
  int _currentIndex = 0;

  // PageView的PageController用于控制页面调转
  var _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _activeColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(
                    color: _currentIndex == 0 ? _activeColor : _defaultColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _activeColor,
              ),
              title: Text(
                '搜索',
                style: TextStyle(
                    color: _currentIndex == 1 ? _activeColor : _defaultColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _activeColor,
              ),
              title: Text(
                '旅行',
                style: TextStyle(
                    color: _currentIndex == 2 ? _activeColor : _defaultColor),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _defaultColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: _activeColor,
              ),
              title: Text(
                '我的',
                style: TextStyle(
                    color: _currentIndex == 3 ? _activeColor : _defaultColor),
              ))
        ],
      ),
    );
  }
}
