import 'package:example/models/counter_view_model.dart';
import 'package:example/observers/app_state_oserver.dart';
import 'package:flutter/material.dart';
import 'package:vm/builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final CounterViewModel _model;

  @override
  void initState() {
    _model = CounterViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter VM example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ViewModelBuilder<CounterViewModel>(
                model: _model,
                observer: AppStateObserver(),
                initOnce: true,
                builder: (context, model, child) {
                  return Text(
                    '${model.counterVal}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: ViewModelBuilder<CounterViewModel>(
          model: _model,
          initOnce: true,
          implicitView: true,
          builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: model.incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            );
          }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
