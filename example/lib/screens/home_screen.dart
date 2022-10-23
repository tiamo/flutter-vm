import 'package:example/models/counter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            const Text('You have pushed the button this many times:'),
            ViewModelBuilder<CounterViewModel>(
              model: _model,
              builder: (context, model, child) {
                return Column(
                  children: [
                    Text(
                      '${model.counterVal}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                );
              },
            ),
            ViewModelBuilder<CounterViewModel>(
              model: _model,
              disposable: false,
              implicitView: true,
              builder: (context, model, child) => const _Progress(),
            ),
            ViewModelBuilder<CounterViewModel>(
              model: _model,
              disposable: false,
              shouldRebuild: (prev, next) => next.progress & 1 == 1,
              builder: (context, model, child) => Text(
                'Odd progress: ${model.progress - model.progress ~/ 2}',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _model.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = context.select((CounterViewModel m) => m.progress);
    return Text('Progress: $progress');
  }
}
