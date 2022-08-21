import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vm/vm.dart';

void main() {
  testWidgets('init view model builder', (tester) async {
    var model = TestViewModel();
    await tester.pumpWidget(MaterialApp(home: TestPage(model: model)));
    expect(find.text('test'), findsAtLeastNWidgets(2));
    expect(model.initialised, true);
    expect(model.initCount, 2);

    await tester.tap(find.text('change-text'));
    await tester.idle();
    await tester.pump();

    expect(find.text('test2'), findsAtLeastNWidgets(2));
  });
}

class TestViewModel extends BaseViewModel {
  String data = "test";
  int initCount = 0;
  int rebuildCount = 0;

  @override
  void init() {
    initCount++;
  }

  @override
  void onBuild() {
    rebuildCount++;
  }

  changeData(String data) {
    this.data = data;
    notifyListeners();
  }
}

class TestPage extends StatefulWidget {
  const TestPage({
    Key? key,
    required this.model,
    this.child,
  }) : super(key: key);

  final TestViewModel model;
  final Widget? child;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewModelBuilder<TestViewModel>(
          model: widget.model,
          builder: (context, model, _) {
            return Text(model.data);
          },
        ),
        ViewModelBuilder<TestViewModel>(
          model: widget.model,
          initOnce: false,
          disposable: false,
          builder: (context, model, _) {
            return Text(model.data);
          },
        ),
        TextButton(
          onPressed: () => widget.model.changeData("test2"),
          child: const Text('change-text'),
        ),
      ],
    );
  }
}
