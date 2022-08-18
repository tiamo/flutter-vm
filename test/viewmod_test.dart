import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viewmod/viewmod.dart';

class TestViewModel extends BaseViewModel {
  String body = "test";

  setBody(String body) {
    this.body = body;
    notifyListeners();
  }
}

void main() {
  testWidgets('init view model', (tester) async {
    var model = TestViewModel();
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            ViewModelBuilder<TestViewModel>(
              model: model,
              builder: (context, model, _) {
                return Text(model.body);
              },
            ),
            TextButton(
              onPressed: () => model.setBody("test2"),
              child: const Text('change'),
            )
          ],
        ),
      ),
    );
    expect(find.text('test', skipOffstage: false), findsOneWidget);
    await tester.tap(find.text('change'));
    await tester.pump(const Duration(microseconds: 100));
    expect(find.text('test2', skipOffstage: false), findsOneWidget);
  });
}
