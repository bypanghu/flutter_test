import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/util/toast_utils.dart';
import 'package:flutter_deer/util/other_utils.dart';
import 'package:flutter_deer/widgets/my_app_bar.dart';
import 'package:flutter_deer/widgets/my_button.dart';
import 'package:flutter_deer/widgets/my_scroll_view.dart';
import 'package:flutter_deer/login/widgets/my_text_field.dart';
import 'package:dio/dio.dart';

import '../login_router.dart';

/// design/1注册登录/index.html#artboard4
class SMSLoginPage extends StatefulWidget {
  const SMSLoginPage({Key? key}) : super(key: key);

  @override
  _SMSLoginPageState createState() => _SMSLoginPageState();
}
class _SMSLoginPageState extends State<SMSLoginPage> {
  Dio _dio = new Dio();
  
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _clickable = false;

  @override
  Map<ChangeNotifier, List<VoidCallback>?>? changeNotifier() {
    final List<VoidCallback> callbacks = <VoidCallback>[_verify];
    return <ChangeNotifier, List<VoidCallback>?>{
      _phoneController: callbacks,
      _vCodeController: callbacks,
      _nodeText1: null,
      _nodeText2: null,
    };
  }

  void _verify() {
    final String name = _phoneController.text;
    final String vCode = _vCodeController.text;
    bool clickable = true;
    if (name.isEmpty || name.length < 11) {
      clickable = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      clickable = false;
    }
    if (clickable != _clickable) {
      setState(() {
        _clickable = clickable;
      });
    }
  }

  void _login() {
    Toast.show('去登录......');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        actionName: "账号密码登录",
        onPressed: () {
          NavigatorUtils.push(context, LoginRouter.loginPage);
        },
      ),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(context, <FocusNode>[_nodeText1, _nodeText2]),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody(),
      ),
    );
  }

  List<Widget> _buildBody() {
    return <Widget>[
      Text(
        "手机号登录",
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        focusNode: _nodeText1,
        controller: _phoneController,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: "请输入手机号码",
      ),
      Gaps.vGap8,
      MyTextField(
        focusNode: _nodeText2,
        controller: _vCodeController,
        maxLength: 6,
        keyboardType: TextInputType.number,
        hintText: "请输入验证码",
        getVCode: () {
          if(_phoneController.value.text == null || _phoneController.value.text.isEmpty){
            Toast.show("请输入手机号码");
            return  Future<bool>.value(false);
          }else{
            Toast.show("获取验证码");
            getCode(_phoneController.value.text);
            return Future<bool>.value(true);
          }

        },
      ),
      Gaps.vGap8,
      Container(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: "没有登录过的手机会被注册成新账号",
            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14),
            children: <TextSpan>[
              TextSpan(
                text: "注册",
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    NavigatorUtils.push(context, LoginRouter.registerPage);
                  },
              ),
              TextSpan(text: Utils.getCurrLocale() == 'zh' ? '。' : '.',),
            ],
          ),
        ),
      ),
      Gaps.vGap24,
      MyButton(
        onPressed: _clickable ? _login : null,
        text: "登录",
      ),
      Container(
        height: 40.0,
        alignment: Alignment.centerRight,
        child: GestureDetector(
          child: Text(
            "忘记密码",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          onTap: () => NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
        ),
      )
    ];
  }

  void getCode(String text) async{
    print("手机号码是$text");
    var data={'mobile':text,"type" : 1};
    const request = await  _dio.post("http://devapp.hisazo.com:88/api/login/sendMobileVerifyCode",queryParameters: data);
    _dio.post("http://devapp.hisazo.com:88/api/login/sendMobileVerifyCode",queryParameters: data)
  }
}
