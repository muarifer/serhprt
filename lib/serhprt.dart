import 'dart:async';

import 'package:flutter/services.dart';

class Serhprt {
  static const ERROR = "-1";

  static const MethodChannel _channel = const MethodChannel('serhprt');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> connect(String name, String toothAddress) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'name': name,
      'toothAddress': toothAddress
    };

    return await _channel.invokeMethod('connect', params);
  }

  static Future<String> printBarcode(int tur, String barcode, int width,
      int height, int position, int justification) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'tur': tur,
      'barcode': barcode,
      'width': width,
      'height': height,
      'position': position,
      'justification': justification
    };
    return await _channel.invokeMethod('printBarcode', params);
  }

  static Future<String> printText(int alignment, bool isBold, bool isUnderline,
      bool isAntiWhite, int textSize, String data) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'alignment': alignment,
      'isBold': isBold,
      'isUnderline': isUnderline,
      'isAntiWhite': isAntiWhite,
      'textsize': textSize,
      'data': data
    };

    return await _channel.invokeMethod('printText', params);
  }

  static Future<String> printAndFeed(int distance) async {
    final Map<String, dynamic> params = <String, dynamic>{'distance': distance};
    return await _channel.invokeMethod('printAndFeed', params);
  }

  static Future<bool> isOpened() async {
    final bool result = await _channel.invokeMethod('isOpened');
    return result;
  }
}
