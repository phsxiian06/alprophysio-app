import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpro_physio/ProBaseState/export.dart';
import 'package:alpro_physio/ProBaseState/widget.dart';

abstract class NavigatorDelegate{
  void onMoveTabTo(int index);
}

class MainNav extends NavState{

  GlobalKey<MainPage> menuPage;

  MainNav(this.menuPage, {this.tabIndex, this.index});

  int index = 0;
  int tabIndex = 0;

  void _animateTo(int index) {
    menuPage?.currentState?.onMoveTabTo(index);
  }

  void changeImg(int index){
    if(index == 0){
      setState(() {
        tabIndex = 0;
      });
    }else if(index == 1){
      setState(() {
        tabIndex = 1;
      });
    }else if(index == 2){
      setState(() {
        tabIndex = 2;
      });
    }else if(index == 3){
      setState(() {
        tabIndex = 3;
      });
    }else if(index == 4){
      setState(() {
        tabIndex = 4;
      });
    }
  }

  void login() async {
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProRoute(LoginPage(), gotAppBar: false)));
  }

  @override
  Widget handleBottomNav(BuildContext context) {
    // TODO: implement handleBottomNav
    MediaQueryData queryData = MediaQuery.of(context);
    return (menuPage?.currentState?._keyboardShown ?? false) ? Center() : Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(offset: Offset(0, 0), color: Colors.black38, blurRadius: 2)],
      ),
      height: 75 /*+ queryData.padding.bottom*/,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: _navBar('home', 'home', 0, (){
              FocusScope.of(context).requestFocus(FocusNode());
              _animateTo(0);
              tabIndex = 0;
            }),
          ),
          Expanded(
            child: _navBar('home', 'home', 1, (){
              FocusScope.of(context).requestFocus(FocusNode());
              _animateTo(1);
              tabIndex = 1;
            }),
          ),
          /*Expanded(
            child:_navBar('moment', 'OG動態', 2, (){
              FocusScope.of(context).requestFocus(FocusNode());
              _animateTo(2);
              tabIndex = 2;
            }),
          ),*/
          Expanded(
            child: _navBar('home', 'home', 2, (){
              FocusScope.of(context).requestFocus(FocusNode());
              _animateTo(2);
              tabIndex = 2;
            }),
          ),
          Expanded(
            child: _navBar('home', 'home', 3, (){
              FocusScope.of(context).requestFocus(FocusNode());
              _animateTo(3);
              tabIndex = 3;
              /*if(!isLogin){
                login();
              } else{
                FocusScope.of(context).requestFocus(FocusNode());
                _animateTo(4);
                tabIndex = 4;
              }*/
            }),
          ),
        ],
      ),
    );
  }

  Widget _navBar(String img, String label, int index, VoidCallback callback){
    return InkWell(
      child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              Image.asset('assets/$img.png', width: 25, height: 25, color: tabIndex == index ? themePurple : themeGrey,),
              SizedBox(height: 5,),
              Text(label, style: TextStyle(color: tabIndex == index ? themePurple : themeGrey),),
            ],
          )
      ),
      onTap: callback,
    );
  }
}


class MainPage extends ProState with TickerProviderStateMixin implements NavigatorDelegate{

  TabController tabController;
  GlobalKey<MainNav> menuNav;
  int index;
  MainPage(this.menuNav, this.index);

  bool _keyboardShown = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KeyboardVisibility.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      if(mounted) {
        setState(() {
          _keyboardShown = visible;
        });
      }
    });
    tabController = TabController(length: 4, initialIndex: index, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    print('on Tab Selected Call');
    menuNav?.currentState?.changeImg(tabController?.index);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
        /*audio == 1 ? Positioned(
          bottom: 85,
            left: 0,
            right: 0,
            child: audioPlaying(audioImage, audioName, audioAuthor, (){
              setState(() {
                if(pause == 1){
                  pause = 0;
                } else{
                  pause = 1;
                }
              });
            }, (){
              setState(() {
                audio = 0;
              });
            })
        ) : Center(),*/
      ],
    );
  }

  @override
  void onMoveTabTo(int index) {
    // TODO: implement onMoveTabTo
    _animateTo(index);
  }

  void _animateTo(int i) {
    if (tabController?.index != i) {
      tabController?.animateTo(i);
    }
  }

}