import 'dart:async';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayCreditHistory.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayDebitHistory.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayNameChangeHistory.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayServiceHistory.dart';
import 'package:uuid/uuid.dart';
import 'package:bijoy_helper/bijoy_helper.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:popover/popover.dart';
import 'package:tvs_app/Screens/AdminScreen/Accessories/AccessoriesScreen.dart';
import 'package:tvs_app/Screens/AdminScreen/Accessories/PerMonthAccessoriesSalesHistory.dart';
import 'package:tvs_app/Screens/AdminScreen/Accessories/UploadAccessories.dart';
import 'package:tvs_app/Screens/AdminScreen/AllAdmin.dart';
import 'package:tvs_app/Screens/AdminScreen/AllCustomer.dart';
import 'package:tvs_app/Screens/AdminScreen/CustomerPaymentAdd.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/DueCustomer.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayDueGiven.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayDuePaymentAddHistory.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayFileClosed.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDayNagadBillPay.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerDaySalesHistory.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerMonthDuePaymentAddHistory.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerMonthNagadBillPay.dart';
import 'package:tvs_app/Screens/AdminScreen/Dashboard/PerMonthSalesHistory.dart';
import 'package:tvs_app/Screens/AdminScreen/MakeAdmin.dart';
import 'package:tvs_app/Screens/AdminScreen/PerDayDueCustomer.dart';
import 'package:tvs_app/Screens/AdminScreen/Settings/ChangePassword.dart';
import 'package:tvs_app/Screens/AdminScreen/Sms/smsinfo.dart';
import 'package:tvs_app/Screens/AdminScreen/UploadProduct.dart';
import 'package:tvs_app/Screens/CommonScreen/LogInScreen.dart';
import 'package:tvs_app/Screens/CommonScreen/ProductScreen.dart';
import 'package:tvs_app/Screens/DeveloperFolder/InternetChecker.dart';
import 'package:tvs_app/Screens/DeveloperInfo/DeveloperInfo.dart';
import 'package:flutter/foundation.dart' show kIsWeb;




class HomeScreen extends StatefulWidget {

  final userName;
  final userEmail;
  final indexNumber;
  



  const HomeScreen({super.key, required this.userName, required this.userEmail, required this.indexNumber});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 var uuid = Uuid();


bool loading = false;


TextEditingController DebitController = TextEditingController();

TextEditingController DebitAmountController = TextEditingController();




   // Firebase All Customer Data Load

List  AllDueCustomerData = [0];




Future<void> getDueCustomerData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

  CollectionReference _collectionDueCustomerRef =
    FirebaseFirestore.instance.collection('customer');
    Query DueCustomerquery = _collectionDueCustomerRef.where("CustomerType", isEqualTo: "Due");
    QuerySnapshot DueCustomerquerySnapshot = await DueCustomerquery.get();

    // Get data from docs and convert map to List
     AllDueCustomerData = DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllDueCustomerData = DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();
     });

    // print(AllData);
}





 // Firebase All Customer Data Load

List  AllPaidCustomerData = [0];




Future<void> getPaidCustomerData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

  CollectionReference _collectionPaidCustomerRef =
    FirebaseFirestore.instance.collection('customer');
    Query PaidCustomerquery = _collectionPaidCustomerRef.where("CustomerType", isEqualTo: "Paid");
    QuerySnapshot PaidCustomerquerySnapshot = await PaidCustomerquery.get();

    // Get data from docs and convert map to List
     AllPaidCustomerData = PaidCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllPaidCustomerData = PaidCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();
     });

    // print(AllData);
}



















  var PaymentDate = "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";


    
  // Firebase All Customer Data Load

List  AllData = [0];
    int moneyAdd = 0;

  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('DuePaymentAddInfo');

Future<void> getData(String paymentDate) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("PaymentDate", isEqualTo: paymentDate);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();


     moneyAdd = 0;

     for (var i = 0; i < AllData.length; i++) {

       var money = AllData[i]["Amount"];
      int moneyInt = int.parse(money);

      

      setState(() {
        moneyAdd = moneyAdd + moneyInt;
      });
       
     }

     print(moneyAdd);

     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
     });

    print(AllData);
}









List  TodayNagadCashData = [];
    int CashAdd = 0;
    int todayDue = 0;
    int todaySale =0;
    int todayProfit = 0;


Future<void> getTodayNagadCashData(String paymentDate) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('BikeSaleInfo');


    Query query = _collectionRef.where("BikeSaleDate", isEqualTo: paymentDate);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     TodayNagadCashData = querySnapshot.docs.map((doc) => doc.data()).toList();


    //  moneyAdd = 0;




     if (TodayNagadCashData.length == 0) {
       setState(() {
      
        // DataLoad = "0";
        // loading = false;

        CashAdd = 0;
      });
       
     } else {

      setState(() {
        // DataLoad = "";
              TodayNagadCashData = querySnapshot.docs.map((doc) => doc.data()).toList();
      });

      for (var i = 0; i < TodayNagadCashData.length; i++) {

      var money = TodayNagadCashData[i]["BikeBillPay"];
      int moneyInt = int.parse(money);
      
      var todayDueMoney =  TodayNagadCashData[i]["BikePaymentDue"];

      int todayDueMoneyInt = int.parse(todayDueMoney.toString());

      var todaySaleMoney = TodayNagadCashData[i]["BikeSalePrice"];
      int todaySaleMoneyInt = int.parse(todaySaleMoney.toString());

      var todaySalePrice = TodayNagadCashData[i]["BikeSalePrice"];
      var BuyingPrice = TodayNagadCashData[i]["BikeBuyingPrice"];

      int todaySalePriceInt = int.parse(todaySalePrice.toString());

      int BuyingPriceInt = int.parse(BuyingPrice.toString()); 

      int todayPrfitInt = todaySalePriceInt - BuyingPriceInt;

 

      

      setState(() {
    
       CashAdd = CashAdd + moneyInt;
       todayDue = todayDue + todayDueMoneyInt;
       todaySale = todaySale + todaySaleMoneyInt;
       todayProfit = todayProfit + todayPrfitInt;
  
      
        // loading = false;
      });
       
     }

     print(moneyAdd);
       
     }

}










List  OwnerShipChangeData = [];
    int OwnerShipChangeAdd = 0;



Future<void> getOwnerShipChangeData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('OwnerShipChange');

    Query query = _collectionRef.where("PaymentDate", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}");
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     OwnerShipChangeData = querySnapshot.docs.map((doc) => doc.data()).toList();


     OwnerShipChangeAdd = 0;




     if (OwnerShipChangeData.length == 0) {
       setState(() {
      
        loading = false;
      });
       
     } else {

   

      for (var i = 0; i < OwnerShipChangeData.length; i++) {

       var money = OwnerShipChangeData[i]["FeeAmount"];
      int moneyInt = int.parse(money);

      

      setState(() {
        OwnerShipChangeAdd = OwnerShipChangeAdd + moneyInt;
        OwnerShipChangeData = querySnapshot.docs.map((doc) => doc.data()).toList();
        loading = false;
      });
       
     }

     print(moneyAdd);
       
     }

    print(OwnerShipChangeData);
}











// internet Connection Checker

bool online = true;
Future getInternetValue() async{

bool onlineData =await getInternetConnectionChecker().getInternetConnection() ;

setState(() {
  online = onlineData;
  
});


}








@override
  void initState() {


    var period = const Duration(seconds:1);
    Timer.periodic(period,(arg) {
                 getInternetValue();
    });





    // TODO: implement initState
    getPaidCustomerData();
    getDueCustomerData();
    getData(PaymentDate);
    getTodayNagadCashData(PaymentDate);
    getOwnerShipChangeData();
    super.initState();

  FlutterNativeSplash.remove();
  
  
  }











  
  Future refresh() async{


    setState(() {
      
    getPaidCustomerData();
    getDueCustomerData();
    getData(PaymentDate);

    });




  }




















  @override
  Widget build(BuildContext context) {


      var DebitID = uuid.v4();




    return Scaffold(


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
      
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [


           widget.indexNumber == "1"?
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 55,
                  fill: 1.0,
                ),
              ): IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2",)));


                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)));



                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),



              IconButton(
                enableFeedback: false,
                onPressed: () {

                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "4")));




                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),),
      ),







      backgroundColor: Colors.white,
      
      
      appBar: AppBar(



                  leading: 
                      PopupMenuButton(
                        onSelected: (value) {
                          // your logic
                        },
                        itemBuilder: (BuildContext bc) {
                          return  [
                            PopupMenuItem(
                                child: Text("আয় যুক্ত করুন", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                                            value: '/about',
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedStudentStatus =
                                                      "";
                                                  String Title ="নিচে আয়ের খাত লিখবেন";

                                                  String LabelText ="আয়ের খাত লিখবেন";

                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title:  Column(
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                  "${Title}", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                                                            ),

                                                            
                                                    

                                    Center(child: Text("*অবশ্যই বাংলায় আয়ের উৎসের নাম লিখবেন", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold, fontSize: 12, color: Colors.red),)),
                                                          ],
                                                        ),
                                                        content: SingleChildScrollView(
                                                          
                                                          child:  Column(
                                                            children: [
              
              Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '${LabelText}',

                      hintText: '${LabelText}',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: DebitController,
                  ),
                ),


                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                      SizedBox(
                              height: 20,
                            ),

                    

                    Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'আয়ের পরিমান(৳)',

                      hintText: 'আয়ের পরিমান(৳)',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: DebitAmountController,
                  ),
                ),






                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text("Cancel"),
                                                          ),


                                                  ElevatedButton(
                                                          onPressed:
                                                            () async {

            setState((){

              loading = true;

            });


            var updateData =
                      {
                        "DebitID": DebitID,
                        "DebitName":DebitController.text.trim().toLowerCase().toBijoy,
                        "DebitAmount":DebitAmountController.text.trim().toLowerCase(),
                        "year":"${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "DateTime":DateTime.now().toIso8601String(),
                        "CollectorName":"",
                        "CollectorEmail":""
                        };

                  final StudentInfo = FirebaseFirestore.instance.collection('DebitInfo').doc(DebitID);
                  
                  StudentInfo.set(updateData).then((value) =>setState(() {
                                        

                                        Navigator.pop(context);

                                final snackBar = SnackBar(
                                        
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                        titleFontSize: 12,
                                        title: 'successfull',
                                        message: 'Hey Thank You. Good Job',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.success,
                                                ),
                                            );

                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                       setState(() {
                        loading = false;
                             });
                            }))
                      .onError((error,stackTrace) =>setState(() {
                        final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                        title: 'Something Wrong!!!!',
                        message: 'Try again later...',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                            ),
                        );

                ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                      setState(() {
                            loading = false;
                               });
                      }));




                                                                  },
                                                                  child: const Text(
                                                                      "Save"),
                                                                ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),




                           PopupMenuItem(
                                child: Text("ব্যয় যুক্ত করুন", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                                            value: '/about',
                                            onTap: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  String SelectedStudentStatus =
                                                      "";
                                                  String Title ="নিচে ব্যয়ের খাত লিখবেন";

                                                  String LabelText ="আয়ের খাত লিখবেন";

                                                  return StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                      return AlertDialog(
                                                        title:  Column(
                                                          children: [
                                                            
                                                            Center(
                                                              child: Text(
                                                                  "${Title}", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                                                            ),




                                                            Center(child: Text("*অবশ্যই বাংলায় ব্যয়ের  উৎসের নাম লিখবেন", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold, fontSize: 12, color: Colors.red),)),
                                                          ],
                                                        ),
                                                        content: SingleChildScrollView(
                                                          
                                                          child:  Column(
                                                            children: [
              
              Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ব্যয়ের খাত লিখবেন',

                      hintText: 'ব্যয়ের খাত লিখবেন',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: DebitController,
                  ),
                ),


                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                      SizedBox(
                              height: 20,
                            ),

                    

                    Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ব্যয়ের পরিমান(৳)',

                      hintText: 'ব্যয়ের পরিমান(৳)',

                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                    controller: DebitAmountController,
                  ),
                ),






                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child:
                                                                Text("Cancel"),
                                                          ),


                                                  ElevatedButton(
                                                          onPressed:
                                                            () async {

            setState((){

              loading = true;

            });


            var updateData =
                      {
                        "CreditID": DebitID,
                        "CreditName":DebitController.text.trim().toLowerCase().toBijoy,
                        "CreditAmount":DebitAmountController.text.trim().toLowerCase(),
                        "year":"${DateTime.now().year}",
                        "month":"${DateTime.now().month}/${DateTime.now().year}",
                        "Date":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        "DateTime":DateTime.now().toIso8601String(),
                        "CollectorName":"",
                        "CollectorEmail":""
                        };

                  final StudentInfo = FirebaseFirestore.instance.collection('CreditInfo').doc(DebitID);
                  
                  StudentInfo.set(updateData).then((value) =>setState(() {
                                        

                                        Navigator.pop(context);

                                final snackBar = SnackBar(
                                        
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                        titleFontSize: 12,
                                        title: 'successfull',
                                        message: 'Hey Thank You. Good Job',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.success,
                                                ),
                                            );

                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                       setState(() {
                        loading = false;
                             });
                            }))
                      .onError((error,stackTrace) =>setState(() {
                        final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                        title: 'Something Wrong!!!!',
                        message: 'Try again later...',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.failure,
                            ),
                        );

                ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                      setState(() {
                            loading = false;
                               });
                      }));




                                                                  },
                                                                  child: const Text(
                                                                      "Save"),
                                                                ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                          
                          ];
                        },
                      ),


  systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      //  automaticallyImplyLeading: false,
        title:  Text("Dashboard   V: 34.13.4 (Live)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        actions: [



          PopupMenuButton(
          onSelected: (value) {
            // your logic
          },
          itemBuilder: (BuildContext context) {
            return  [


               PopupMenuItem(
                onTap: (){


                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen()));




                },
                child: Center(
                  child: Column(
                    children: [
                    Center(
                        child:  ClipOval(
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoocHKiIUok-RD7VaxEivcDEwGLdbsMO5JL66hM1Z12x9t6kEvwqKoUNvDeRBc6H9dh4g&usqp=CAU",
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),


                    Text("Name:${widget.userName}", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Email:${widget.userEmail}", style: TextStyle(fontWeight: FontWeight.bold),),




                    ],
                  ),
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2",)));




                },
                child: Row(
                  children: [
                    Icon(Icons.electric_bike),
                    SizedBox(width: 5,),
                    Text("All Bikes"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "4")));




                },
                child: Row(
                  children: [
                    Icon(Icons.person_4),
                    SizedBox(width: 5,),
                    Text("All Customers"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DueCustomer()));




                },
                child: Row(
                  children: [
                    Icon(Icons.person_3_rounded),
                    SizedBox(width: 5,),
                    Text("Due Customers"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),








              
               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDuePaymentAddHistory()));


                },
                child: Row(
                  children: [
                    Icon(Icons.payment),
                    SizedBox(width: 5,),
                    Text("আজকের বাকি কালেকশন", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),






              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerMonthDuePaymentAddHistory()));




                },
                child: Row(
                  children: [
                    Icon(Icons.payments_rounded),
                    SizedBox(width: 5,),
                   Text("মাসিক বাকি কালেকশন", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),











              
               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDueCustomer()));




                },
                child: Row(
                  children: [
                    Icon(Icons.person_4),
                    SizedBox(width: 5,),
                    Text("Today Due Customers"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),






               



              
                 PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDaySalesHistory()));




                },
                child: Row(
                  children: [
                    Icon(Icons.sell),
                    SizedBox(width: 5,),
                    Text("আজকের মোট বিক্রয়", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),



               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerMonthSalesHistory()));




                },
                child: Row(
                  children: [
                    Icon(Icons.sell_sharp),
                    SizedBox(width: 5,),
                   Text("মাসিক মোট বিক্রয়", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),




              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayNagadBillPay()));




                },
                child: Row(
                  children: [
                    Icon(Icons.account_balance_rounded),
                    SizedBox(width: 5,),
                    Text("আজকের নগদ ক্যাশ", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),



              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>PerMonthNagadBillPay()));




                },
                child: Row(
                  children: [
                    Icon(Icons.account_balance_rounded),
                    SizedBox(width: 5,),
                    Text("মাসিক নগদ ক্যাশ", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDueGiven()));




                },
                child: Row(
                  children: [
                    Icon(Icons.account_balance_rounded),
                    SizedBox(width: 5,),
                    Text("আজকের বাকি দেওয়া হয়েছে", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),




              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayFileClosed()));




                },
                child: Row(
                  children: [
                    Icon(Icons.file_download_done),
                    SizedBox(width: 5,),
                    Text("আজকের ফাইল ক্লোজড তথ্য", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),



              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDebitHistory()));


                },
                child: Row(
                  children: [
                    Icon(Icons.payment),
                    SizedBox(width: 5,),
                    Text("আজকের অতিরিক্ত আয়ের পরিমান", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),




              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayCreditHistory()));


                },
                child: Row(
                  children: [
                    Icon(Icons.payment),
                    SizedBox(width: 5,),
                    Text("আজকের ব্যয়ের পরিমান", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),






              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayServiceFeeHistory()));


                },
                child: Row(
                  children: [
                    Icon(Icons.payment),
                    SizedBox(width: 5,),
                    Text("আজকের সার্ভিস ফি পরিমান", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),






              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayNameChangeHistory()));


                },
                child: Row(
                  children: [
                    Icon(Icons.payment),
                    SizedBox(width: 5,),
                    Text("আজকের নাম পরিবর্তন ফি", style: TextStyle(fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),











               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AccessoriesScreen()));




                },
                child: Row(
                  children: [
                    Icon(Icons.preview_outlined),
                    SizedBox(width: 5,),
                    Text("Parts"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),














                  PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadProduct()));




                },
                child: Row(
                  children: [
                    Icon(Icons.upload),
                    SizedBox(width: 5,),
                    Text("Upload Bike"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),




               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UploadAccessories()));




                },
                child: Row(
                  children: [
                    Icon(Icons.upload_file),
                    SizedBox(width: 5,),
                    Text("Upload Parts"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              




              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerMonthAccessoriesSalesHistory()));




                },
                child: Row(
                  children: [
                    Icon(Icons.history),
                    SizedBox(width: 5,),
                    Text("Parts Sales"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



              

              


              

              


              



                PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)));




                },
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings),
                    SizedBox(width: 5,),
                    Text("All Admin"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



          PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MakeAdmin()));




                },
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings),
                    SizedBox(width: 5,),
                    Text("Make Admin"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword()));




                },
                child: Row(
                  children: [
                    Icon(Icons.password),
                    SizedBox(width: 5,),
                    Text("Change Password"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





                PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SMSInfo()));




                },
                child: Row(
                  children: [
                    Icon(Icons.sms_rounded),
                    SizedBox(width: 5,),
                    Text("SMS info"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              
              



PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeveloperInfo()));




                },
                child: Row(
                  children: [
                    Icon(Icons.developer_board),
                    SizedBox(width: 5,),
                    Text("Developer"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              





           PopupMenuItem(
                onTap: () async{

                          FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) async{
                              if (user == null) {
                                
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LogInScreen()),
                      );
                                print('User is currently signed out!');
                              } else {
                                print('User is signed in!');
                                await FirebaseAuth.instance.signOut();
                                          
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LogInScreen()),
                      );
                              }
                            });
                  




                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 5,),
                    Text("LogOut"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),

            ];
          },
        )
                ],
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: online==false?Center(child: Text("No Internet Connection", style: TextStyle(fontSize: 24, color: Colors.red),)):SingleChildScrollView(
      
                child: Padding(
                  padding: EdgeInsets.only(left:kIsWeb?205:5, right: kIsWeb?205:5,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [



                               Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 400,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  
                        Image.asset("lib/images/bycicle.png", fit:  BoxFit.cover, width: 50,
                        height: 50,),
                  
                        SizedBox(height: 5,),
                  
                  
                  
                        Text("আজকের বাকি কালেকশন: ${moneyAdd.toString()}৳", style: TextStyle(
                        
                                fontSize: 18,
                                color: Colors.black,
                                overflow: TextOverflow.clip,
                                 fontFamily: "Josefin Sans"
                              ),),
                  
                  
                        
                        SizedBox(height: 3,),
                  
                  
                  
                        Text("আজকের নগদ ক্যাশ গ্রহণ: ${CashAdd.toString()}৳", style: TextStyle(
                        
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                                 fontFamily: "Josefin Sans"
                              ),),
                  
                           SizedBox(height: 3,),
                  
                        
                        //  Text("আজকের Discount সহ বিক্রয় : ${todayWithDiscountSale.toString()}৳", style: TextStyle(
                        
                        //         fontSize: 18,
                        //         color: Colors.black,
                        //         overflow: TextOverflow.clip,
                        //          fontFamily: "Josefin Sans"
                        //       ),),
                  
                          
                           SizedBox(height: 3,),
                  
                  
                        Text("আজকে মোট বাকি দেওয়া হয়েছে: ${todayDue.toString()}৳", style: TextStyle(
                        
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                                 fontFamily: "Josefin Sans"
                              ),),
                  
                           SizedBox(height: 3,),
                        
                  
                        Text("আজকে মোট বিক্রয় হয়েছে: ${todaySale.toString()}৳ ", style: TextStyle(
                        
                                fontSize: 18,
                                color: Colors.black,
                                overflow: TextOverflow.clip,
                                 fontFamily: "Josefin Sans"
                              ),),
                  
                  
                           SizedBox(height: 3,),
                  
                          
                          
                        
                        Text("আজকে লাভ হয়েছে: ${todayProfit.toString()}৳ ", style: TextStyle(
                        
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                                 fontFamily: "Josefin Sans"
                              ),),



                        
                  
                        
                           SizedBox(height: 3,),
                  
                        
                        Text("আজকে মোট গাড়ি বিক্রয় হয়েছে: ${TodayNagadCashData.length.toString()}টি", style: TextStyle(
                        
                                fontSize: 18,
                                color: Colors.black,
                                overflow: TextOverflow.clip,
                                 fontFamily: "Josefin Sans"
                              ),),
                  
                         SizedBox(height: 3,),




                         Text("আজকের মোট নাম পরিবর্তন ফি: ${OwnerShipChangeAdd.toString()}৳", style: TextStyle(
                        
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                                 fontFamily: "Josefin Sans"
                              ),),
                  
                           SizedBox(height: 3,),
                  
                  
                  
                  
                  
                  
                      ],
                    ),
                  ),
                       
                 decoration: BoxDecoration(
                  color: Colors.white,
                
                  border: Border.all(
                            width: 2,
                            color: Colors.white
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
                
                
                 SizedBox(
                  height: 10,
                 ),




        






  // নগদ গ্রহণ 


                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 300,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Image.asset("lib/images/bycicle.png", fit:  BoxFit.cover, width: 100,
                        height: 100,),

                        SizedBox(height: 4,),

                      
                          Text("আজকের নগদ ক্যাশ গ্রহন:${CashAdd.toString()}৳", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 23,
                            color:Colors.white,
                            overflow: TextOverflow.clip,
                            fontFamily: "Josefin Sans"
                           
                          ),),
                    
                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 100, child:TextButton(onPressed: (){
    
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayNagadBillPay()));

                
                                            }, child: Text("View", style: TextStyle(color: Color.fromARGB(255, 242,133,0)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),      
                                ],),
                            )
                  
                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242,133,0),
                
                  border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 242,133,0)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),



                 SizedBox(height: 10,),




      




      // মোট বাকি বিক্রয়


                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 300,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Image.asset("lib/images/bycicle.png", fit:  BoxFit.cover, width: 100,
                        height: 100,),

                        SizedBox(height: 4,),

                      
                          Text("আজকের মোট বাকি বিক্রয়:${todayDue.toString()}৳", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 23,
                            color:Colors.white,
                            overflow: TextOverflow.clip,
                            fontFamily: "Josefin Sans"
                           
                          ),),
                    
                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 100, child:TextButton(onPressed: (){
    
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDueGiven()));

                
                                            }, child: Text("View", style: TextStyle(color: Color.fromARGB(255, 242,133,0)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),      
                                ],),
                            )
                  
                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242,133,0),
                
                  border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 242,133,0)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),



                 SizedBox(height: 10,),


        


         // মোট বাকি বিক্রয়


                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 300,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Image.asset("lib/images/bycicle.png", fit:  BoxFit.cover, width: 100,
                        height: 100,),

                        SizedBox(height: 4,),

                      
                          Text("আজকের মোট বিক্রয়:${todaySale.toString()}৳", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 23,
                            color:Colors.white,
                            overflow: TextOverflow.clip,
                            fontFamily: "Josefin Sans"
                           
                          ),),
                    
                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 100, child:TextButton(onPressed: (){
    
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDaySalesHistory()));

                
                                            }, child: Text("View", style: TextStyle(color: Color.fromARGB(255, 242,133,0)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),      
                                ],),
                            )
                  
                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242,133,0),
                
                  border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 242,133,0)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),



                 SizedBox(height: 10,),




          // বাকি কালেকশন
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 300,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Image.asset("lib/images/bycicle.png", fit:  BoxFit.cover, width: 100,
                        height: 100,),

                        SizedBox(height: 4,),

                      
                          Text("আজকের বাকি কালেকশন:${moneyAdd.toString()}৳", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 23,
                            color:Colors.white,
                            overflow: TextOverflow.clip,
                            fontFamily: "Josefin Sans"
                           
                          ),),
                    
                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 100, child:TextButton(onPressed: (){
    
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDuePaymentAddHistory()));

                
                                            }, child: Text("View", style: TextStyle(color: Color.fromARGB(255, 242,133,0)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),      
                                ],),
                            )
                  
                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Color.fromARGB(255, 242,133,0),
                
                  border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 242,133,0)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),



                 SizedBox(height: 10,),







                
                
                     Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 200,
                  child: Center(
                    child: Text("Total Paid Customers: ${AllPaidCustomerData.length.toString()}", style: TextStyle(
                    
                            fontSize: 20,
                            color: Colors.white,
                            overflow: TextOverflow.clip
                          ),),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Color(0xF0B75CFF),
                
                  border: Border.all(
                            width: 2,
                            color: Color(0xF0B75CFF)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
                
                
                 SizedBox(
                  height: 10,
                 ),
                
                
                
                
                
                
                 
                     Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Total Due Customers: ${AllDueCustomerData.length.toString()}", style: TextStyle(
                    
                            fontSize: 20,
                            color: Colors.white,
                            overflow: TextOverflow.clip
                          ),),
                    
                    
                
                
                    SizedBox(
                  height: 17,
                 ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                                            
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              
                              
                              children: [
                                            
                                            
                                          Container(width: 100, child:TextButton(onPressed: (){
                
                
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDueCustomer()));
                
                
                
                
                
                                          }, child: Text("View", style: TextStyle(color: Theme.of(context).primaryColor),), style: ButtonStyle(
                               
                                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                        ),),),
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                              ],),
                          )
                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                
                  border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),
                
                
                 SizedBox(
                  height: 10,
                 ),
                
                
                
                
                
                 
                    
                
                
                 SizedBox(
                  height: 10,
                 ),
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                    ]))),
      ));
  }
}














