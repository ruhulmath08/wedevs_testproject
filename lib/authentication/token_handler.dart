import 'dart:async';

import 'package:wedevs_testproject/constants/enum.dart';

class TokenHandler {
  static final _controller = StreamController<TokenStatus>();

  Stream<TokenStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield TokenStatus.validate;
    yield* _controller.stream;
  }

  static void refreshToken() {
    _controller.add(TokenStatus.expired);
  }

  void dispose() => _controller.close();
}
