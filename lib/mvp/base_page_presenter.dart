import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_deer/mvp/base_presenter.dart';

import 'mvps.dart';

class BasePagePresenter<V extends IMvpView> extends BasePresenter<V> {

  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  late CancelToken _cancelToken;

  @override
  void dispose() {
    /// 销毁时，将请求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }



}
