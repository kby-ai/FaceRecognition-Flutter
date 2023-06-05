import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'main.dart';

class SettingsPage extends StatefulWidget {
  final MyHomePageState homePageState;

  const SettingsPage({super.key, required this.homePageState});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class LivenessDetectionLevel {
  String levelName;
  int levelValue;

  LivenessDetectionLevel(this.levelName, this.levelValue);
}

const double _kItemExtent = 40.0;
const List<String> _livenessLevelNames = <String>[
  'Best Accuracy',
  'Light Weight',
];

class SettingsPageState extends State<SettingsPage> {
  bool _cameraLens = false;
  String _livenessThreshold = "0.7";
  String _identifyThreshold = "0.8";
  List<LivenessDetectionLevel> livenessDetectionLevel = [
    LivenessDetectionLevel('Best Accuracy', 0),
    LivenessDetectionLevel('Light Weight', 1),
  ];
  int _selectedLivenessLevel = 0;

  final livenessController = TextEditingController();
  final identifyController = TextEditingController();

  static Future<void> initSettings() async {
    final prefs = await SharedPreferences.getInstance();
    var firstWrite = prefs.getInt("first_write");
    if (firstWrite == 0) {
      await prefs.setInt("first_write", 1);
      await prefs.setInt("camera_lens", 1);
      await prefs.setInt("liveness_level", 0);
      await prefs.setString("liveness_threshold", "0.7");
      await prefs.setString("identify_threshold", "0.8");
    }
  }

  @override
  void initState() {
    super.initState();

    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    var cameraLens = prefs.getInt("camera_lens");
    var livenessLevel = prefs.getInt("liveness_level");
    var livenessThreshold = prefs.getString("liveness_threshold");
    var identifyThreshold = prefs.getString("identify_threshold");

    setState(() {
      _cameraLens = cameraLens == 1 ? true : false;
      _livenessThreshold = livenessThreshold ?? "0.7";
      _identifyThreshold = identifyThreshold ?? "0.8";
      _selectedLivenessLevel = livenessLevel ?? 0;
      livenessController.text = _livenessThreshold;
      identifyController.text = _identifyThreshold;
    });
  }

  Future<void> restoreSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("first_write", 0);
    await initSettings();
    await loadSettings();

    Fluttertoast.showToast(
        msg: "Default settings restored!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> updateLivenessLevel(value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("liveness_level", value);
  }

  Future<void> updateCameraLens(value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("camera_lens", value ? 1 : 0);

    setState(() {
      _cameraLens = value;
    });
  }

  Future<void> updateLivenessThreshold(BuildContext context) async {
    try {
      var doubleValue = double.parse(livenessController.text);
      if (doubleValue >= 0 && doubleValue < 1.0) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("liveness_threshold", livenessController.text);

        setState(() {
          _livenessThreshold = livenessController.text;
        });
      }
    } catch (e) {}

    // ignore: use_build_context_synchronously
    Navigator.pop(context, 'OK');
    setState(() {
      livenessController.text = _livenessThreshold;
    });
  }

  Future<void> updateIdentifyThreshold(BuildContext context) async {
    try {
      var doubleValue = double.parse(identifyController.text);
      if (doubleValue >= 0 && doubleValue < 1.0) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("identify_threshold", identifyController.text);

        setState(() {
          _identifyThreshold = identifyController.text;
        });
      }
    } catch (e) {}

    // ignore: use_build_context_synchronously
    Navigator.pop(context, 'OK');
    setState(() {
      identifyController.text = _identifyThreshold;
    });
  }

// This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        toolbarHeight: 70,
        centerTitle: true,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Camera Lens'),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (value) {
                  updateCameraLens(value);
                },
                initialValue: _cameraLens,
                leading: const Icon(Icons.camera),
                title: const Text('Front'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Thresholds'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: const Text('Liveness Level'),
                value: Text(_livenessLevelNames[_selectedLivenessLevel]),
                leading: const Icon(Icons.person_pin_outlined),
                onPressed: (value) => _showDialog(
                  CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: _kItemExtent,
                    // This sets the initial item.
                    scrollController: FixedExtentScrollController(
                      initialItem: _selectedLivenessLevel,
                    ),
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) {
                      setState(() {
                        _selectedLivenessLevel = selectedItem;
                      });
                      updateLivenessLevel(selectedItem);
                    },
                    children: List<Widget>.generate(_livenessLevelNames.length,
                        (int index) {
                      return Center(child: Text(_livenessLevelNames[index]));
                    }),
                  ),
                ),
              ),
              SettingsTile.navigation(
                title: const Text('Liveness Threshold'),
                value: Text(_livenessThreshold),
                leading: const Icon(Icons.person_pin_outlined),
                onPressed: (value) => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Liveness Threshold'),
                    content: TextField(
                      controller: livenessController,
                      onChanged: (value) => {},
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => updateLivenessThreshold(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ),
              SettingsTile.navigation(
                title: const Text('Identify Threshold'),
                leading: const Icon(Icons.person_search),
                value: Text(_identifyThreshold),
                onPressed: (value) => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Identify Threshold'),
                    content: TextField(
                      controller: identifyController,
                      onChanged: (value) => {},
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => updateIdentifyThreshold(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Reset'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: const Text('Restore default settings'),
                leading: const Icon(Icons.restore),
                onPressed: (value) => restoreSettings(),
              ),
              SettingsTile.navigation(
                title: const Text('Clear all person'),
                leading: const Icon(Icons.clear_all),
                onPressed: (value) {
                  widget.homePageState.deleteAllPerson();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
