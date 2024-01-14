import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:path/path.dart';
// import 'package:tvs_app/Screens/AdminScreen/Accessories/AccessoriesScreen.dart';
// import 'package:tvs_app/Screens/AdminScreen/Accessories/UploadAccessories.dart';
// import 'package:tvs_app/Screens/AdminScreen/AllCustomer.dart';
// import 'package:tvs_app/Screens/AdminScreen/AllPDF/CashMemo.dart';
// import 'package:tvs_app/Screens/AdminScreen/AllPDF/DeliveryChallan.dart';
// import 'package:tvs_app/Screens/AdminScreen/AllPDF/DuePayMemo.dart';
// import 'package:tvs_app/Screens/AdminScreen/AllPDF/NameChangeFrom.dart';
// import 'package:tvs_app/Screens/AdminScreen/AllPDF/OfficeDeliveryChallan.dart';
// import 'package:tvs_app/Screens/AdminScreen/CreateNewCustomer.dart';
// import 'package:tvs_app/Screens/AdminScreen/CustomerPaymentAdd.dart';
// import 'package:tvs_app/Screens/AdminScreen/CustomerProfile.dart';
// import 'package:tvs_app/Screens/AdminScreen/Dashboard/DueCustomer.dart';
// import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayDuePaymentAddHistory.dart';
// import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayDuePaymentAddHistoryChart.dart';
// import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerMonthDuePaymentAddHistory.dart';
// import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerMonthSalesHistory.dart';

// import 'package:tvs_app/Screens/AdminScreen/Dashboard/SalesPage.dart';
// import 'package:tvs_app/Screens/AdminScreen/EditCustomerInfo.dart';
// import 'package:tvs_app/Screens/AdminScreen/HomeScreen.dart';
// import 'package:tvs_app/Screens/AdminScreen/MakeAdmin.dart';
// import 'package:tvs_app/Screens/AdminScreen/PaymentHistory.dart';
// import 'package:tvs_app/Screens/AdminScreen/PerDayDueCustomer.dart';
// import 'package:tvs_app/Screens/AdminScreen/SearchByNID.dart';
// import 'package:tvs_app/Screens/AdminScreen/SingleBikeInfo.dart';
// import 'package:tvs_app/Screens/AdminScreen/SingleCustomerFileView.dart';
// import 'package:tvs_app/Screens/AdminScreen/UploadBikeImage.dart';
// import 'package:tvs_app/Screens/AdminScreen/UploadCustomerInfo.dart';
// import 'package:tvs_app/Screens/AdminScreen/UploadProduct.dart';
import 'package:tvs_app/Screens/CommonScreen/LogInScreen.dart';
// import 'package:tvs_app/Screens/CommonScreen/ProductScreen.dart';
// import 'package:tvs_app/Screens/CommonScreen/RegistrationScreen.dart';
// import 'package:tvs_app/Screens/CommonScreen/SingleProductInfo.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


Future main() async{

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyAFXNfMHGXkJ-rg07bqKb8pRi5wKnMnQks", appId: "1:36910758021:android:0342e173d08c48c879d1ec", messagingSenderId: "36910758021", projectId: "aoneimpexhondaapp")
    ,);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {




  const MyApp({super.key});







  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    


// A-ONE IMPEX
    return MaterialApp(
      title: 'A-ONE IMPEX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.acme().fontFamily,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home:LogInScreen()
    );
  }


  
}






// NameChangePDFView(NameChangeData: [{
//                         "FileNo":"B-1334",
//                         "PreviousCustomerFatherName":"Anamul Haque",
//                         "PreviousCustomerNID":"34363",
//                         "PreviousCustomerName":"Orthee",
//                         "PreviousCustomerAddress":"Komorgram Sadar, C.O Colony, main Road Joypurhat, Rajshahi Bangladesh",
//                         "PreviousCustomerPhoneNumber":"01722237022",
//                         "NewCustomerName":"Mahadi Hasan",
//                         "NewCustomerPhoneNumber":"01822237022",
//                         "OldSaleID":"45345",
//                         "NewCustomerAddress":"Kalai Sadar, C.O Colony, main Road Joypurhat, Rajshahi Bangladesh",
//                         "NewCustomerFatherName":"Hasan",
//                         "FeeAmount": '390',
//                         "PaymentDateTime": DateTime.now().toIso8601String(),
//                         "PaymentDate":"${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
//                         "PaymentMonth":"${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
//                         "PaymentYear":"${DateTime.now().year.toString()}",
//       }],)




// DuePayPDFPreview(PaymentData: [{


//                         "FileNo":"B-1233",
//                         "CustomerNID":"43425252",
//                         "CustomerName":"Mahadi Hasan",
//                         "CustomerID":"25345345",
//                         "CustomerPhoneNumber":"023479252",
//                         "Amount": "130",
//                         "PaymentDateTime": DateTime.now().toIso8601String(),
//                         "PaymentDate":"${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
//                         "PaymentMonth":"${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
//                         "PaymentYear":"${DateTime.now().year.toString()}",
//                         "adminEmail":"mahh13424",
//                         "adminName":"Shaju",
//                         "BikePaymentDue":"2344",


//                               }]),





// CashMemoPDFView(SalesData: [{              "ClassOfVehicle":"MOTOR CYCLE",
//                   "BikeBuyingPrice":"3455",
//                   "YearOfManufacture":" ",
//                   "SeatingCapacity":"",
//                   "BikeValvePerCylinder":"",
//                   "MakersName":"Bajaj Auto LTD/INDIA",
//                   "BikeMaximumPower":"",
//                   "BikeWheelBase":"",
//                   "BikeTyreFront":"",
//                   "BikeTyreRear":"",
//                   "SaleID":"",
//                   "CustomerAddress":"Joypurhat Sadar, Joypurhat",
//                   "BikeID":"",
//                   "CustomerID":"",
//                   "CustomerNID": "",
//                   "BikeChassisNo":"dfsdfds342",
//                   "BikeEngineNo":"dffew4525",
//                   "BikeDeliveryNo":"B-125",
//                   "BikeName":"BAJAJ DISCOVER 125 DISC",
//                   "BikeColor":"Black",
//                   "BikeSalePrice":"66448",
//                   "DiscountWithBikeSalePrice":"234234",
//                   "BikeDeliveryDate":DateTime.now(),
//                   "BikeSaleDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
//                   "BikeSaleMonth":"${DateTime.now().month}/${DateTime.now().year}",
//                   "BikeSaleYear":"${DateTime.now().year}",
//                   "BikeBillPay":"24344",
//                   "BikePaymentDue":"344",
//                   "CustomerType":"",
//                   "CustomerName":"Mahadi Hasan",
//                   "CustomerPhoneNumber":"01721915550",
//                   "BikeConditionMonth":"0",
//                   "CustomerFatherName":"Mosta Hasan",
//                   "CustomerGuarantor1Address":"",
//                     }]),



// LogInScreen()


// SingleProductInfo(BikeID: "c9f5dfe2-1511-4e9a-80c0-1a058de853f3")

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }





  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
