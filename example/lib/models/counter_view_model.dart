import 'package:flutter/widgets.dart';
import 'package:vm/model.dart';

class CounterViewModel extends ViewModel implements WidgetsBindingObserver {
  late int _counterVal;

  int get counterVal => _counterVal;

  set counterVal(int v) => updateWith(counterVal: v);

  @override
  void init() {
    _counterVal = 0;
    super.init();
  }

  void incrementCounter() {
    counterVal++;
  }

  void updateWith({
    int? counterVal,
  }) {
    _counterVal = counterVal ?? _counterVal;
    notifyListeners();
  }

  @override
  void didChangeAccessibilityFeatures() {
    // TODO: implement didChangeAccessibilityFeatures
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    // TODO: implement didChangeLocales
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
  }

  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didHaveMemoryPressure() {
    // TODO: implement didHaveMemoryPressure
  }

  @override
  Future<bool> didPopRoute() {
    // TODO: implement didPopRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRoute(String route) {
    // TODO: implement didPushRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    // TODO: implement didPushRouteInformation
    throw UnimplementedError();
  }
}
