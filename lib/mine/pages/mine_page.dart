import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/my_card.dart';
import 'package:flutter_deer/widgets/my_flexible_space_bar.dart';
import 'package:flutter_deer/widgets/person_card.dart';

class MinePage extends StatefulWidget{
  const MinePage({Key? key}) : super(key: key);
  @override
  _MinePage createState()=> _MinePage();
}
class _MinePage extends State<MinePage>{

  String title = "王の家";




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        key: const Key('statistic_list'),
        physics: const ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }
  bool isDark = false;
  List<Widget> _sliverBuilder() {
    isDark = context.isDark;
    return <Widget>[
      SliverAppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        expandedHeight: 100.0,
        pinned: true,
        flexibleSpace: MyFlexibleSpaceBar(
          background: Container(height: 115.0, decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              gradient: LinearGradient(
                  colors: [Color(0xFF7BE3E1), Color(0xFF96E8E2)],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          centerTitle: true,
          titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
          collapseMode: CollapseMode.pin,
          title: Text(title, style: TextStyle(color: ThemeUtils.getIconColor(context)),),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              gradient: LinearGradient(
                  colors: [Color(0xFF9BECE7), Colors.white],
                  begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              height: 120.0,
              child: MyCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PersionCard(),
                    Padding(
                      padding: EdgeInsets.only(top: 15,bottom: 15 ,left: 20,right: 20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          gradient: LinearGradient(
                              colors : [Color(0xFF58C9D2),Color(0xFF58C9D2)],
                              begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        ),
                        child: IconButton(
                            onPressed: () => Toast.show('添加人物'),
                            color: Colors.white,
                            icon: Icon(Icons.add)
                        ),
                      ),
                    )
                  ]
                ),
              ),
            ),
          )
          , 120.0,
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top : 20 , left: 10 , right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("我的设备",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: IconButton(
                                padding: new EdgeInsets.all(0.0),
                                onPressed: () => Toast.show('添加设备'),
                                color: Colors.black,
                                iconSize: 18,
                                icon: Icon(Icons.add)
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      )
    ];
  }




}