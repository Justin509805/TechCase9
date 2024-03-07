import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localization_yt/localization/locales.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  late Battery _battery;
  late int _batteryPercentage;
  late int _dischargingPercentage;
  late int _chargingPercentage;
  late Timer _batteryTimer;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    _battery = Battery();
    _batteryPercentage = 0;
    _dischargingPercentage = 0;
    _chargingPercentage = 0;

    // Fetch initial battery level
    _getBatteryLevel();

    // Timer to update battery level every 5 seconds
    _batteryTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _getBatteryLevel();
    });
  }

  @override
  void dispose() {
    // Dispose the timer to prevent memory leaks
    _batteryTimer.cancel();
    super.dispose();
  }

  Future<void> _getBatteryLevel() async {
    try {
      int batteryLevel = await _battery.batteryLevel;

      setState(() {
        _batteryPercentage = batteryLevel;
        _dischargingPercentage = 7 * _batteryPercentage;
        _chargingPercentage = (3 * 60 / _batteryPercentage).round();
      });
    } catch (e) {
      print("Error fetching battery level: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleData.title.getString(context),
          textAlign: _currentLocale == "ar" ? TextAlign.right : TextAlign.left,
        ),
        actions: [
          DropdownButton(
            value: _currentLocale,
            items: const [
              DropdownMenuItem(
                value: "en",
                child: Text("English"),
              ),
              DropdownMenuItem(
                value: "de",
                child: Text("German"),
              ),
              DropdownMenuItem(
                value: "nl",
                child: Text("Dutch"),
              ),
              DropdownMenuItem(
                value: "zh",
                child: Text("Chinese"),
              ),
              DropdownMenuItem(
                value: "ar",
                child: Text("Arabic"),
              ),
            ],
            onChanged: (value) {
              _setLocale(value);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 60,
        ),
        child: Column(
          crossAxisAlignment: _currentLocale == "ar" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Directionality(
              textDirection: _currentLocale == "ar" ? TextDirection.rtl : TextDirection.ltr,
              child: Text(
                context.formatString(LocaleData.body, ["$_batteryPercentage%"]),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: _currentLocale == "ar" ? TextDirection.rtl : TextDirection.ltr,
              child: Text(
                context.formatString(LocaleData.charging, ["$_chargingPercentage"]),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Directionality(
              textDirection: _currentLocale == "ar" ? TextDirection.rtl : TextDirection.ltr,
              child: Text(
                context.formatString(LocaleData.discharging, ["$_dischargingPercentage"]),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 30),
            LinearProgressIndicator(
              value: _batteryPercentage / 100.0,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getProgressBarColor(_batteryPercentage),
              ),
              minHeight: 18.0,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ],
        ),
      ),
    );
  }

Color _getProgressBarColor(int batteryPercentage) {
  if (batteryPercentage <= 20) {
    return Colors.red;
  } else if (batteryPercentage <= 65) {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}

  void _setLocale(String? value) {
    if (value == null) return;
    if (value == "en") {
      _flutterLocalization.translate("en");
    } else if (value == "de") {
      _flutterLocalization.translate("de");
    } else if (value == "nl") {
      _flutterLocalization.translate("nl");
    } else if (value == "zh") {
      _flutterLocalization.translate("zh");
    } else if (value == "ar") {
      _flutterLocalization.translate("ar");
    } else {
      return;
    }
    setState(() {
      _currentLocale = value;
    });
  }
}

