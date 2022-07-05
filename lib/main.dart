import 'package:flutter/material.dart';
import 'package:pennyless/pages/account_page.dart';
import 'package:pennyless/pages/edit_prices_page.dart';
import 'package:pennyless/pages/login_page.dart';
import 'package:pennyless/pages/map_page.dart';
import 'package:pennyless/pages/prices_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hwebjzubjvvhmphtzpgo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh3ZWJqenVianZ2aG1waHR6cGdvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTY4NDc1MzMsImV4cCI6MTk3MjQyMzUzM30.5aAxuwjTkCpA5zm8cf5UzbVh2VcbtDNJxhD3ryyJCdQ',
  );

  await Database().fetch();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        '/': (_) => MapPage(),
        '/prices': (_) => const PricesPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
        '/edit_prices': (_) => const EditPricePage(),
      },
    );
  }
}
