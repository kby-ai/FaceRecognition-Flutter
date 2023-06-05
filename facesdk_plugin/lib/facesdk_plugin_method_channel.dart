import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'facesdk_plugin_platform_interface.dart';

/// An implementation of [FacesdkPluginPlatform] that uses method channels.
class MethodChannelFacesdkPlugin extends FacesdkPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('facesdk_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> setActivation(String license) async {
    final ret = await methodChannel
        .invokeMethod<int>('setActivation', {"license": license});
    return ret;
  }

  @override
  Future<int?> init() async {
    final ret = await methodChannel.invokeMethod<int>('init');
    return ret;
  }

  @override
  Future<void> setParam(Map<String, Object> params) async {
    await methodChannel.invokeMethod<void>('setParam', params);
  }

  @override
  Future<dynamic> extractFaces(String imagePath) async {
    final ret = await methodChannel
        .invokeMethod<dynamic>('extractFaces', {"imagePath": imagePath});
    return ret;
  }

  @override
  Future<double?> similarityCalculation(
      Uint8List templates1, Uint8List templates2) async {
    final ret = await methodChannel.invokeMethod<dynamic>(
        'similarityCalculation',
        {"templates1": templates1, "templates2": templates2});
    return ret;
  }
}
