import 'package:fluro/fluro.dart';
import 'package:flutter_deer/mine/pages/mine_page.dart';
import 'package:flutter_deer/routers/i_router.dart';



class OrderRouter implements IRouterProvider{

  static String minePage = '/mine';


  @override
  void initRouter(FluroRouter router) {
    router.define(minePage, handler: Handler(handlerFunc: (_, __) => const MinePage()));
  }

}