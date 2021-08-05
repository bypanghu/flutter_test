import 'package:common_utils/common_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_deer/login/created/create_page.dart';
import 'package:flutter_deer/login/created/page_index.dart';
import 'package:flutter_deer/login/created/qr_scan.dart';
import 'package:flutter_deer/routers/i_router.dart';

import 'page/login_page.dart';
import 'page/register_page.dart';
import 'page/reset_password_page.dart';
import 'page/sms_login_page.dart';
import 'page/update_password_page.dart';


class LoginRouter implements IRouterProvider{

  static String loginPage = '/login';
  static String registerPage = '/login/register';
  static String smsLoginPage = '/login/smsLogin';
  static String resetPasswordPage = '/login/resetPassword';
  static String updatePasswordPage = '/login/updatePassword';

//  注册初始化家庭页面
  static String createHomeInitPage = '/createHomeInit';
  static String qrcodeScanPage = '/createHomeInit/qrCode';
  static String createHomeCreatePage = '/createHomeInit/create';
  @override
  void initRouter(FluroRouter router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, __) => const LoginPage()));
    router.define(registerPage, handler: Handler(handlerFunc: (_, __) => const RegisterPage()));
    router.define(smsLoginPage, handler: Handler(handlerFunc: (_, __) => const SMSLoginPage()));
    router.define(resetPasswordPage, handler: Handler(handlerFunc: (_, __) => const ResetPasswordPage()));
    router.define(updatePasswordPage, handler: Handler(handlerFunc: (_, __) => const UpdatePasswordPage()));
    router.define(createHomeInitPage, handler: Handler(handlerFunc: (_, __) => const CreateInitPage()));
    router.define(qrcodeScanPage, handler: Handler(handlerFunc: (_, __) => const QrCodeScanPage()));
    router.define(createHomeCreatePage,  handler: Handler(handlerFunc: (_, Map<String, List<String>> params) {
      final bool isAdd = params['isAdd']?.first == 'true';
      final bool isScan = params['isScan']?.first == 'true';
      final String name = params['name']?.first ?? '';
      final String scanCode = params['scanCode']?.first ?? 'scanCode';
      return CreatePage(isAdd: isAdd, isScan: isScan, name: name, scanCode: scanCode,);
    }));
  }

}