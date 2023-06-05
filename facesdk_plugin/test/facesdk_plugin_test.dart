// import 'package:flutter_test/flutter_test.dart';
// import 'package:facesdk_plugin/facesdk_plugin.dart';
// import 'package:facesdk_plugin/facesdk_plugin_platform_interface.dart';
// import 'package:facesdk_plugin/facesdk_plugin_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockFacesdkPluginPlatform
//     with MockPlatformInterfaceMixin
//     implements FacesdkPluginPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final FacesdkPluginPlatform initialPlatform = FacesdkPluginPlatform.instance;

//   test('$MethodChannelFacesdkPlugin is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelFacesdkPlugin>());
//   });

//   test('getPlatformVersion', () async {
//     FacesdkPlugin facesdkPlugin = FacesdkPlugin();
//     MockFacesdkPluginPlatform fakePlatform = MockFacesdkPluginPlatform();
//     FacesdkPluginPlatform.instance = fakePlatform;

//     expect(await facesdkPlugin.getPlatformVersion(), '42');
//   });
// }
