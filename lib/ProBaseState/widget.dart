import 'package:alpro_physio/model/banner.dart';
import 'package:flutter/material.dart';
import 'export.dart';

Widget loader(bool isLoading, String label, {Color color = Colors.white}){
  return (isLoading ? GestureDetector(
    child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themePurple),
                backgroundColor: Colors.black12,),
              SizedBox(height: 5,),
              Text(label, style: TextStyle(color: color),),
            ],
          ),
        )
    ),
    onTap: (){},
  ) : Center());
}

Widget lineBox(
    {double height = 1, Color color = Colors.black26, double padding = 0}) {
  return Container(
    padding: EdgeInsets.only(left: padding, right: padding),
    width: double.infinity,
    height: height,
    color: color,
  );
}

Widget circleClip(double radius, {Widget child, Color color = Colors.white}) {
  return Container(
    width: radius,
    height: radius,
    child: ClipOval(
      clipBehavior: Clip.antiAlias,
      child: OverflowBox(
        maxHeight: radius,
        maxWidth: radius,
        child: Center(
          child: Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: child == null ? Center() : child,
          ),
        ),
      ),
    ),
  );
}

Widget labelCheckBox(
  double size,
  bool value,
  String label,
  Function onTap,
) {
  return InkWell(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size + 2,
            height: size + 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: value ? themePurple : Colors.transparent,
                border: Border.all(
                    color: value ? Colors.transparent : Colors.black87)),
            child: value
                ? Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: size,
                    ),
                  )
                : Container(),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: size,
              color: Colors.black54,
            ),
          )
        ],
      ),
    ),
    onTap: onTap,
  );
}

Widget simpleAppBar(String title, Function onBack) {
  return AppBar(
    backgroundColor: themePurple,
    leading: InkWell(
      child: Transform.scale(
        scale: 0.4,
        child: Image.asset(
          'assets/ic_back.png',
        ),
      ),
      onTap: onBack,
    ),
    title: title != null
        ? Text(
            title,
            style: TextStyle(
              color: Colors.black,
            ),
          )
        : Container(),
  );
}

Widget imageTitleAppBar() {
  return AppBar(
    backgroundColor: themePurple,
    centerTitle: true,
    title: Image.asset(
      'assets/ic_appbar_image.png',
      height: 40.0,
    ),
  );
}

Widget tabBar(TabController controller, List<Widget> tabs) {
  return Material(
    color: themePurple,
    child: TabBar(
      controller: controller,
      indicatorColor: themePurple,
      unselectedLabelColor: Colors.black,
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
      ),
      labelColor: themePurple,
      labelStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      tabs: tabs,
    ),
  );
}

Widget tabItem(String label, {int count = 0}) {
  return Container(
    padding: EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        count != 0
            ? SizedBox(
                width: 5.0,
              )
            : Container(),
        count != 0
            ? Container(
                padding: EdgeInsets.all(5.0),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: themePurple),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(),
      ],
    ),
  );
}

Widget infinityButton(String text, onTapCallBack,
    {double height = 40,
    double radius = 20,
    Color buttonColor = themePurple,
    Color textColor = Colors.black,
    double marginLeft = 0,
    double marginTop = 0,
    double marginRight = 0,
    double marginBottom = 0,
    double fontSize = 15,
    bool needShadow = false}) {
  return InkWell(
    child: Container(
      height: height,
      width: double.infinity,
      margin:
          EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: needShadow
            ? [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 3.0,
                  offset: Offset(1.5, 1.5),
                ),
              ]
            : [],
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600)),
      ),
    ),
    onTap: () {
      onTapCallBack();
    },
  );
}

Widget line(double height, Color color, {double width = double.infinity}){
  return Container(
    width: width,
    height: height,
    color: color,
  );
}

Widget button(String label, Color color, {VoidCallback callback, double top = 15, double left = 20, double bottom = 15, double right = 20,
  FontWeight fontWeight = FontWeight.bold, double fontSize = 16, bool gotImage = false, String img, double width = 85, Color fontColor = themeBlack,
  bool border = false, Color borderColor = themePurple, double borderWidth = 2, bool gotIcon = false, IconData icon}) {
  return InkWell(
    child: Container(
      constraints: BoxConstraints(
          minWidth: width
      ),
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: color,
        border: Border.all(width: border ? borderWidth : 0, color: border ? borderColor : Colors.transparent)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gotIcon ? Icon(icon, size: 20, color: themePurple) : Center(),
          gotImage ? Image.asset('assets/$img.png', width: 20, height: 20) : Center(),
          SizedBox(width: gotImage ? 10 : 0),
          Text(label, style: TextStyle(fontWeight: fontWeight, color: fontColor, fontSize: fontSize),),
        ],
      ),
    ),
    onTap: callback,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
  );
}

Widget customAppBar(String title, VoidCallback callback, {bool gotImage = false, bool gotIcon = false, IconData icon, String img, VoidCallback iconCallback}){
  return Container(
    padding: EdgeInsets.fromLTRB(0, 38, 0, 15),
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [themePurple, themeDarkPurple],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
              padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
              child: Icon(Icons.chevron_left, size: 30, color: themeWhite)
          ),
          onTap: callback,
        ),
        Expanded(
          child: Center(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: themeWhite))),
        ),
        gotImage ? InkWell(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Image.asset('assets/$img.png', width: 30, height: 30,)
          ),
          onTap: iconCallback,
        ) : Container(width: gotIcon ? 0 : 30,),
        gotIcon ? InkWell(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(icon, size: 25, color: Colors.white,),
          ),
          onTap: iconCallback,
        ) : Center(),
      ],
    ),
  );
}

Widget bannerIndicator(BannerList item, int pageViewIndex, int index){
  return Container(
    padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
    child: Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: pageViewIndex == index ? Colors.white : Colors.grey
      ),
    ),
  );
}