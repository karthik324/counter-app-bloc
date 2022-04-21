import 'cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    debugPrint('build called');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          state.wasIncremented == true
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Incremented'),
                    duration: Duration(seconds: 1),
                  ),
                )
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Decremented'),
                    duration: Duration(seconds: 1),
                  ),
                );
        },
        builder: (context, state) {
          debugPrint('bloc called');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              //* either choose this
              // BlocProvider.of<CounterCubit>(context).decrement();
              //*or this
              context.read<CounterCubit>().decrement();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            tooltip: 'decrement',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
