import 'package:vm/model.dart';

class CounterViewModel extends BaseViewModel {
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
}
