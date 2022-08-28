# Flutter VM (ViewModel)

A very simple flutter plugin that implements the `MVVM` pattern.

Model–View–ViewModel (MVVM) is a software architectural pattern that facilitates the separation 
of the development of the graphical user interface (the view) – be it via a markup language or 
GUI code – from the development of the business logic or back-end logic (the model) 
so that the view is not dependent on any specific model platform.

[![Build Status](https://github.com/tiamo/flutter-vm/actions/workflows/ci.yml/badge.svg)](https://github.com/tiamo/flutter-vm)
[![Pub package](https://img.shields.io/pub/v/vm.svg)](https://pub.dartlang.org/packages/vm)
[![Star on GitHub](https://img.shields.io/github/stars/tiamo/flutter-vm.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/tiamo/flutter-vm)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

![MVVM](https://upload.wikimedia.org/wikipedia/commons/8/87/MVVMPattern.png)

## Getting Started

* Add this to your pubspec.yaml
  ```
  dependencies:
  vm: ^1.0.3
  ```
* Get the package from Pub:
  ```
  flutter packages get
  ```
* Import it in your file
  ```
  import 'package:vm/vm.dart';
  ```

## Features

...

## Usage

First create a `ViewModel`
```dart
class CounterViewModel extends ViewModel {
  int value = 0;
  int progress = 0;

  void increment() {
    value++;
    if (value % 5 == 0) {
      progress += 1;
    }
    notifyListeners();
  }
}
```

Using `CounterViewModel` with `ViewModelBuilder`
```dart
ViewModelBuilder<CounterViewModel>(
  model: CounterViewModel(),
  builder: (context, model, child) {
    return Text('Counter: ${model.value}');
  },
)
```

Rebuild only if `progress` changed
```dart
ViewModelBuilder<CounterViewModel>(
  model: counterModel,
  shouldRebuild: (prev, next) => prev.progress != next.progress
  builder: (context, model, child) => Text('Progress: ${model.progress}'),
)
```
Or using `context.select`
```dart
ViewModelBuilder<CounterViewModel>(
  model: counterModel,
  builder: (context, model, child) => const _Progress(),
)
```
```dart
class _Progress extends StatelessWidget {
  const _Progress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = context.select((CounterViewModel m) => m.progress);
    return Text('Progress: $progress');
  }
}
```

Rebuild only if `progress` is an odd number
```dart
ViewModelBuilder<CounterViewModel>(
  model: counterModel,
  shouldRebuild: (prev, next) => next.progress & 1 == 1,
  builder: (context, model, child) => Text('Progress: ${model.progress}'),
)
```

Check out the complete [Example](https://github.com/tiamo/flutter-vm/tree/master/example)

## Changelog

Please have a look in [CHANGELOG](CHANGELOG.md)

## Maintainers

* [Vlad Korniienko](https://github.com/tiamo)
* [Alex Awaik](https://github.com/awaik)

## License

[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
