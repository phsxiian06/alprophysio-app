import 'package:OEGlobal/model/banner.dart';
import 'package:flutter/material.dart';
import 'export.dart';

var inputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black,
  ),
  borderRadius: BorderRadius.circular(5.0),
);

var focusBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.black,
  ),
  borderRadius: BorderRadius.circular(5.0),
);

var inputBorderGrey = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey[200],
  ),
  borderRadius: BorderRadius.circular(5.0),
);

var focusBorderGrey = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey[200],
  ),
  borderRadius: BorderRadius.circular(5.0),
);

var inputBorderWhite = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.white,
  ),
  borderRadius: BorderRadius.circular(5.0),
);

var focusBorderWhite = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.white,
  ),
  borderRadius: BorderRadius.circular(5.0),
);

var inputPadding = EdgeInsets.symmetric(
  vertical: 10.0,
  horizontal: 12.0,
);

var inputTitleStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.black,
);

var inputTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.black,
);

var buttonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(5.0),
);

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

Widget searchAppBar(
  TextEditingController textEditingController,
  Function onBack, {
  String hint,
  Function(String value) onSearch,
}) {
  return AppBar(
    backgroundColor: themePurple,
    centerTitle: true,
    leading: InkWell(
      child: Transform.scale(
        scale: 0.4,
        child: Image.asset(
          'assets/ic_back.png',
        ),
      ),
      onTap: onBack,
    ),
    actions: [
      Container(
        width: 40,
      ),
    ],
    title: TextField(
      style: inputTextStyle,
      controller: textEditingController,
      textInputAction: TextInputAction.search,
      onSubmitted: onSearch,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        enabledBorder: inputBorderWhite,
        focusedBorder: focusBorderWhite,
        contentPadding: inputPadding,
        hintText: hint,
        suffixIcon: InkWell(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          onTap: () {
            onSearch(textEditingController.text);
          },
        ),
        suffixIconConstraints: BoxConstraints(),
      ),
    ),
  );
}

Widget greyTextField(
  TextEditingController controller,
  TextInputType inputType, {
  Function(String) onSubmitted,
}) {
  return TextField(
    style: inputTextStyle,
    controller: controller,
    decoration: InputDecoration(
      fillColor: Colors.grey[200],
      filled: true,
      isDense: true,
      enabledBorder: inputBorderGrey,
      focusedBorder: focusBorderGrey,
      contentPadding: inputPadding,
    ),
    keyboardType: inputType,
    onSubmitted: onSubmitted,
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
          gotIcon ? Icon(icon, size: 20, color: themePurple,) : Center(),
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

Widget titleBar(String title, VoidCallback callback, {bool hideMore = false}){
  return Container(
    padding: EdgeInsets.only(left: 10),
    child: Row(
      children: [
        Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),)),
        hideMore ? Center() : InkWell(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 3),
            child: Row(
              children: [
                Text('查看更多', style: TextStyle(color: themePurple),),
                Icon(Icons.chevron_right, color: themePurple,)
              ],
            ),
          ),
          onTap: callback,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    ),
  );
}

Widget leaderBoardView(String title, VoidCallback callback, {double width = 280}){
  return InkWell(
    child: Container(
      width: width,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
            image: AssetImage('assets/bulk.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.srcATop)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: themeWhite, fontWeight: FontWeight.w500, fontSize: 20),),
          Text('Top10', style: TextStyle(color: themeWhite, fontWeight: FontWeight.w500, fontSize: 20),),
          SizedBox(height: 5,),
          numberLabel('1', '面对焦虑，突破挑战，迎向未来'),
          numberLabel('2', '洞见趋势: 察觉别人忽略的细节'),
          numberLabel('3', '思维决定出路，观念决定方向'),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.only(left: 13.0),
            child: Row(
              children: [
                Text('查看更多', style: TextStyle(color: themeWhite, fontSize: 13),),
                Icon(Icons.chevron_right, color: themeWhite,)
              ],
            ),
          ),
        ],
      ),
    ),
    onTap: callback,
  );
}

Widget numberLabel(String num, String label){
  return Row(
    children: [
      Text(num, style: TextStyle(color: themeWhite),),
      SizedBox(width: 5,),
      Expanded(child: Text(label, style: TextStyle(color: themeWhite), maxLines: 1, overflow: TextOverflow.ellipsis,)),
    ],
  );
}

Widget subscribe(String title, String des, VoidCallback callback){
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
    child: InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          color: themeLightPurple,
          border: Border.all(width: 1, color: themePurple),
        ),
        child: Row(
          children: [
            Image.asset('assets/star.png', width: 35, height: 35,),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: themePurple, fontWeight: FontWeight.bold),),
                  Text(des, style: TextStyle(),),
                ],
              ),
            ),
            Row(
              children: [
                Text('马上开启', style: TextStyle(),),
                Icon(Icons.chevron_right,)
              ],
            ),
          ],
        ),
      ),
      onTap: callback,
    ),
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

Widget audioPlaying(String img, String name, String author, VoidCallback play, VoidCallback close){
  return Container(
    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 65,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft:  Radius.circular(8),
                ),
                child: Image.asset('assets/$img.png', fit: BoxFit.cover,)
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis,),
                SizedBox(height: 2,),
                Text(author, style: TextStyle(color: themeGrey, fontSize: 12),),
              ],
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Image.asset(pause == 1 ? 'assets/play.png' : 'assets/pause.png', width: 40, height: 40,),
            ),
            onTap: play,
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Image.asset('assets/close.png', width: 25, height: 25,),
            ),
            onTap: close,
          ),
        ],
      ),
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