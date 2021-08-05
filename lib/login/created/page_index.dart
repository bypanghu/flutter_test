import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';

import '../login_router.dart';

class CreateInitPage extends StatefulWidget{
  const CreateInitPage({Key ? key}) : super(key : key);
  @override
    _CreateInitPage createState() => _CreateInitPage();
}

class _CreateInitPage extends State<CreateInitPage>{

  final FocusNode _nodeText1 = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  String name = ''  ;

  void _printLatestValue() {
    this.setState(() {
      name = _nameController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_printLatestValue);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(
        isBack: true,
      ),
      body: MyScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody,
        bottomButton: Padding(
          padding: EdgeInsets.only(left: 20 , right: 20,bottom: 50),
          child: Column(
            children: [
              MyButton(
                key: const Key('createhome'),
                onPressed: _CreateHome,
                text: "一键创建家庭码",
                radius: 50,
              ),
              Gaps.vGap24,
              MyButton(
                key: const Key('openscan'),
                onPressed: _openScan,
                text: "扫描添加家庭码",
                backgroundColor: Colors.blue,
                radius: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> get _buildBody => <Widget>[
    Padding(
      padding: EdgeInsets.only(left: 10 , right: 10 , top: 10),
      child: Text(
        "创建您的家庭扫描进入家庭",
        style: TextStyle(fontSize: 22 ,fontWeight: FontWeight.w600),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(left: 10 , right: 10 ),
      child: Text(
        "请创建您的家庭名称或扫描加入已有家庭",
        style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.w400),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(top: 50 , left: 10 , right: 10),
      child: TextFieldItem(
          focusNode: _nodeText1,
          title: "家庭名称",
          hintText: '请输入家庭名称',
          controller: _nameController,
      ),
    ),
    Gaps.vGap50,

  ];

  void _CreateHome() {
    NavigatorUtils.push(context, '${LoginRouter.createHomeCreatePage}?isAdd=true&scan=false&name=${Uri.encodeComponent(name)}&scanCode=0');
  }

  void _openScan() {
    NavigatorUtils.push(context, LoginRouter.qrcodeScanPage);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}