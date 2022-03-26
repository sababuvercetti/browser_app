import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:windows_flutter/example_browser_tab.dart';
import 'package:windows_flutter/tab_index_cubit.dart';
import 'package:windows_flutter/tabs_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: ((context) => TabsCubit([
                  ExampleBrowser(
                    url: 'https://pub.dev',
                  )
                ]))),
        BlocProvider(create: ((context) => TabIndexCubit(0))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
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
          primarySwatch: Colors.purple,
        ),
        home: BrowserWindow(),
      ),
    );
  }
}

class BrowserWindow extends StatefulWidget {
  const BrowserWindow({Key? key}) : super(key: key);

  @override
  State<BrowserWindow> createState() => _BrowserWindowState();
}

class _BrowserWindowState extends State<BrowserWindow> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth > 400
          ? Scaffold(
              body: Column(
                children: [
                  Container(
                    height: 40,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: [
                      ...List.generate(
                          context.watch<TabsCubit>().state.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  context.read<TabIndexCubit>().emit(index);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 30,
                                  width: 60,
                                  child: Center(
                                    child: Text(
                                      "Tab ${index + 1}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  color: context.read<TabIndexCubit>().state ==
                                          index
                                      ? Colors.purple
                                      : Colors.yellow,
                                ),
                              )),
                      CupertinoButton(
                        color: Colors.blue,
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.read<TabsCubit>().state.add(ExampleBrowser());
                          setState(() {});
                        },
                      )
                    ]),
                  ),
                  Expanded(
                      child: context
                          .watch<TabsCubit>()
                          .state[context.read<TabIndexCubit>().state])
                ],
              ),
            )
          : Scaffold(
              body: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView(children: [
                      ...List.generate(
                          context.watch<TabsCubit>().state.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  context.read<TabIndexCubit>().emit(index);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 30,
                                  width: 60,
                                  child: Center(
                                    child: Text(
                                      "Tab ${index + 1}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  color: context.read<TabIndexCubit>().state ==
                                          index
                                      ? Colors.purple
                                      : Colors.yellow,
                                ),
                              )),
                      CupertinoButton(
                        color: Colors.blue,
                        padding: EdgeInsets.all(0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.read<TabsCubit>().state.add(ExampleBrowser());
                          setState(() {});
                        },
                      )
                    ]),
                  ),
                  Expanded(
                      flex: 7,
                      child: context
                          .watch<TabsCubit>()
                          .state[context.read<TabIndexCubit>().state])
                ],
              ),
            );
    });
  }
}
