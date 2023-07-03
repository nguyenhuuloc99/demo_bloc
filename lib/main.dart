import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(App());

abstract class CounterState extends Equatable {
  final int count;

  const CounterState(this.count);

  @override
  List<Object> get props => [count];
}

class InitialState extends CounterState {
  InitialState() : super(0);
}

class CountUpdatedState extends CounterState {
  CountUpdatedState(int count) : super(count);
}

abstract class CounterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IncrementEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(InitialState()) {
    on<IncrementEvent>((event, emit) => _increament(event, emit));
  }

  _increament(IncrementEvent event, Emitter<CounterState> emit) {
    emit(CountUpdatedState(state.count + 1));
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int initCount = 0;
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    print("CounterPage Build");
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocListener<CounterBloc, CounterState>(
        bloc: counterBloc,
        listener: (context, state) {
         /* if (state is CountUpdatedState) {
            setState(() {
              initCount = state.count;
            });
          }*/
        },
        child: Center(
          child: Column(
            children: [
              const Text("AAAAA"),
              const SizedBox(
                height: 15,
              ),
              TextCount(count: initCount.toString()),
                BlocBuilder<CounterBloc, CounterState>(
                bloc: counterBloc,
                  builder: (context, state) {
                    if (state is CountUpdatedState) {
                      return TextCount(count: state.count.toString());
                    }
                    return Container();
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.read<CounterBloc>().add(IncrementEvent()),
      ),
    );
  }
}

class TextCount extends StatelessWidget {
  final String count;

  const TextCount({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("TextCount Build");
    return Text(
      count,
      style: TextStyle(fontSize: 20),
    );
  }
}
