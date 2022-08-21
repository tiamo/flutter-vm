import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class ViewModelBuilder<T extends BaseViewModel> extends StatefulWidget {
  const ViewModelBuilder({
    Key? key,
    required this.builder,
    required this.model,
    this.disposable = true,
    this.initOnce = true,
    this.implicitView = false,
    this.observer,
    this.child,
  }) : super(key: key);

  /// A builder function for the View widget, it also has access
  /// to the [model].
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  /// The view model of the view.
  final T model;

  /// To dispose the [model] when the provider is removed from the
  /// widget tree.
  final bool disposable;

  /// Whether the [model] should be initialized once or every time the
  /// the dependencies change.
  final bool initOnce;

  /// When the [implicitView] is `false`, then the view widget is wrapped with
  /// a [Consumer] widget to make it reactive to the view model changes.
  /// if it is `true` it will be implicit and notifyListener will not
  /// reload widgets under `builder`
  final bool implicitView;

  /// Registers the [observer] as a binding observer. Binding
  /// observers are notified when various application events occur,
  /// for example when the system locale changes.
  final WidgetsBindingObserver? observer;

  /// The [child] contained by the view.
  final Widget? child;

  @override
  State<ViewModelBuilder> createState() => _ViewModelBuilderState<T>();
}

class _ViewModelBuilderState<T extends BaseViewModel>
    extends State<ViewModelBuilder<T>> {
  late T _vm;

  @override
  void initState() {
    super.initState();
    _vm = widget.model;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.onAfterBuild();
    });
    if (widget.observer != null) {
      WidgetsBinding.instance.addObserver(widget.observer!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _vm.context = context;
    if (!widget.initOnce || !_vm.initialised) {
      _vm.init();
      _vm.initialised = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _vm.onBuild();

    late final Widget child;
    if (widget.implicitView) {
      child = widget.builder(context, widget.model, widget.child);
    } else {
      child = Consumer<T>(builder: widget.builder, child: widget.child);
    }

    if (widget.disposable) {
      return ChangeNotifierProvider<T>(create: (_) => _vm, child: child);
    }
    return ChangeNotifierProvider<T>.value(value: _vm, child: child);
  }

  @override
  void dispose() {
    _vm.onDispose();
    super.dispose();
  }
}
