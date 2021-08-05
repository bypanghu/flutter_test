import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/routers/routers.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/widgets/selected_image.dart';
import 'package:flutter_deer/widgets/text_field_item.dart';


class CreatePage extends StatefulWidget{
  const CreatePage({
    Key? key,
    this.isAdd = true,
    this.isScan = false,
    this.name,
    this.scanCode
  }) : super(key: key);

  final bool isAdd;
  final bool isScan;
  final String? name;
  final String? scanCode;

  @override
  _CreatePage createState() => _CreatePage();

}
class _CreatePage extends State<CreatePage>{
  var _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: true,
      ),
      body: MyScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody,
        bottomButton: Padding(
          padding: EdgeInsets.only(left: 20 , right: 20,bottom: 20),
          child: Column(
            children: [
              MyButton(
                key: const Key('createhome'),
                onPressed: _next,
                text: "下一步",
                radius: 50,
              )
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
        "添加用户",
        style: TextStyle(fontSize: 22 ,fontWeight: FontWeight.w600),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(left: 10 , right: 10 ),
      child: Text(
        "为了确保信息准确，请核对一下信息",
        style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.w400),
      ),
    ),
    Gaps.vGap16,
    Center(
      child: SelectedImage(
        size: 96.0,
      ),
    ),
    Gaps.vGap8,
    Center(
      child: Text(
        '点击添加头像',
        style: Theme.of(context).textTheme.subtitle2,
      ),
    ),
    Gaps.vGap16,
    TextFieldItem(
      title: "昵称",
      hintText: '请输入昵称',
    ),
    TextFieldItem(
      title: widget.name ?? "",
      hintText: '填写简短描述',
    ),
    TextFieldItem(
      title: '身高',
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      hintText: '填写商品单品折后价格',
    ),
  ];

  void _next() {
    NavigatorUtils.push(context, Routes.home, clearStack: true);
  }
}
