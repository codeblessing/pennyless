import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:pennyless/data/price_data.dart';
import 'package:pennyless/pages/account_page.dart';
import 'package:pennyless/pages/edit_prices_page.dart';
import 'package:pennyless/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'data/station.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hwebjzubjvvhmphtzpgo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh3ZWJqenVianZ2aG1waHR6cGdvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTY4NDc1MzMsImV4cCI6MTk3MjQyMzUzM30.5aAxuwjTkCpA5zm8cf5UzbVh2VcbtDNJxhD3ryyJCdQ',
  );

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
      home: Scaffold(
        appBar: AppBar(title: const Text('Edit prices')),
        body: Center(
          child: EditPricePage(
            current_prices: PriceData(
              Station(
                const Uuid(),
                "BP Poznańska",
                LatLng(52.4006553, 16.7615825),
              ),
              7.98,
              7.80,
              7.70,
              5.20,
            ),
          ),
        ),
      ),
      // initialRoute: "/login",
      // routes: <String, WidgetBuilder>{
      //   '/login': (_) => const LoginPage(),
      //   '/account': (_) => const AccountPage(),
      // },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final List<PriceData> _markers = [
//     PriceData(
//       Station(
//         const Uuid(),
//         "BP Poznańska",
//         LatLng(52.4006553, 16.7615825),
//       ),
//       7.98,
//       7.80,
//       7.70,
//       5.20,
//     ),
//     PriceData(
//       Station(
//         const Uuid(),
//         "Orlen Krakowska",
//         LatLng(52.5006570, 16.7615824),
//       ),
//       6.15,
//       5.00,
//       4.70,
//       5.10,
//     ),
//   ];
//   PriceData currentPrices = PriceData.empty();

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         StationMap(
//           markers: _markers,
//           onPinTap: (prices) => setState(() => currentPrices = prices),
//         ),
//         BottomDrawer(
//           header: Container(),
//           body: PriceScreen(
//             prices: currentPrices,
//           ),
//           headerHeight: 10.0,
//           drawerHeight: 400.0,
//         ),
//       ],
//     );
//   }
// }
