import 'package:farmer_app/injection/injection.dart';
import 'package:farmer_app/model/repository/remote/chopper/setup/post_api_service.dart';
import 'package:farmer_app/view/screens/HomeScreen.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_bloc.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_event.dart';
import 'package:farmer_app/view_model/bloc/navigation/navigationdrawer_bloc.dart';
import 'package:farmer_app/view_model/counter/CounterChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  configureInjection(Env.dev);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with AfterLayoutMixin<MyApp>, WidgetsBindingObserver {

  @override
  void afterFirstLayout(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /*ChangeNotifierProvider(
          create: (context) {
            return getIt<CounterChangeNotifier>();
          },
        ),*/

        Provider(
          create: (maincontext) => PostApiService.create(),
          dispose: (maincontext, PostApiService service) =>
              service.client.dispose(),
        ),
        BlocProvider<NavigationdrawerBloc>(
          create: (maincontext) => NavigationdrawerBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        /*MyHomePage(
          title: 'Farm app',
        ),*/
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AfterLayoutMixin<MyHomePage> {
  int _counter = 0;
  CounterBloc counterBloc = CounterBloc();

  /*void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }*/
  @override
  void afterFirstLayout(BuildContext context) {
    /*counterBloc.stream.listen((event) {

    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times iii:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            BlocBuilder<CounterBloc, int>(
                bloc: counterBloc,
                builder: (context, state) {
                  return Text(
                    '$state',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
            Consumer<CounterChangeNotifier>(
              builder: (context, counter, child) {
                return Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            FloatingActionButton(
              onPressed: () {
                Provider.of<CounterChangeNotifier>(
                  context,
                  listen: false,
                ).increment();
              }, //_incrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.supervised_user_circle),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Provider.of<CounterChangeNotifier>(context).increment;
          counterBloc.add(Decrement());
        }, //_incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
