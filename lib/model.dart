import 'package:flutter/widgets.dart';

abstract class ViewModel extends ChangeNotifier {
  /// The context of the view.
  late BuildContext context;

  /// Determine if [ViewModel] has been initialised.
  bool initialised = false;

  /// Determine if [ViewModel] has been disposed.
  bool _disposed = false;
  bool get disposed => _disposed;

  /// A callback after [ViewModel] is constructed.
  /// The event is called by default every time the
  /// [ViewModel] view dependencies are updated.
  /// Set `initOnce` of the `ViewModelBuilder` builder to `true` to ignore
  /// dependencies updates.
  void init() {}

  /// A callback when the `build` method is called.
  void onBuild() {}

  /// A callback when the `addPostFrameCallback` method is called.
  void onAfterBuild() {}

  /// A callback when the view disposed.
  void onDispose() {}

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
