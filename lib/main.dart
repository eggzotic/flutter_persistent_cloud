import 'package:flutter/material.dart';
import 'package:flutter_persistent_cloud/my_platform.dart';
import 'package:provider/provider.dart';
//
import 'counter_state.dart';

//
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Storage Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // here's where we insert our Provider into the Widget tree. This
      //  MyHomePage widget, and any widget created below that, can access this
      //  instance of CounterState by simply calling
      //  "Provider.of<CounterState>(context)" in it's build method.
      home: ChangeNotifierProvider(
        create: (context) => CounterState(MyPlatform()),
        child: MyHomePage(title: 'Cloud Storage Demo'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is (now) stateless,
  //  meaning that it may define "final" vars only. It may still be used for
  //  a dynamic (changing) UI if it is passed dynamic data from outside and
  //  the build method is re-run (which is precisely what happens in this App)
  //
  // Any data that can change over time can be defined in an outer scope (i.e.
  //  higher up the tree)

  final String title;

  @override
  Widget build(BuildContext context) {
    //
    // This method is rerun every time notifyListeners is called from the Provider.
    //
    final counterState = Provider.of<CounterState>(context);
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              counterState.hasError ? '' : counterState.isWaiting ? 'Please wait...' : 'The counter value is:',
            ),
            counterState.hasError
                ? Text("Oops, something's wrong!")
                : counterState.isWaiting
                    ? CircularProgressIndicator()
                    : Text(
                        '${counterState.value}',
                        style: Theme.of(context).textTheme.headline4
                      ),
            (counterState.hasError || counterState.isWaiting)
                ? Text('')
                : Column(
                    children: [
                      Text('last changed by: ${counterState.lastUpdatedByDevice}'),
                      SizedBox(height: 16.0),
                      Text('(This device: ${counterState.myPlatform})'),
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.undo),
            // colours indicate when the button is inactive (i.e when counterState is waiting)
            backgroundColor: counterState.isWaiting
                ? Theme.of(context).buttonColor
                : Theme.of(context).floatingActionButtonTheme.backgroundColor,
            // the button action is disabled when counterState is waiting
            onPressed: counterState.isWaiting ? null : counterState.reset,
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            // colours indicate when the button is inactive (i.e when counterState is waiting)
            backgroundColor: (counterState.isWaiting || counterState.hasError)
                ? Theme.of(context).buttonColor
                : Theme.of(context).floatingActionButtonTheme.backgroundColor,
            // the button action is disabled when counterState is waiting
            onPressed: (counterState.isWaiting || counterState.hasError) ? null : counterState.increment,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
