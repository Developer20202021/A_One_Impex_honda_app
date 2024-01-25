import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:tvs_app/Screens/AdminScreen/AfterSaleBike.dart';
import 'package:tvs_app/Screens/AdminScreen/AllAdmin.dart';
import 'package:tvs_app/Screens/AdminScreen/AllCustomer.dart';
import 'package:tvs_app/Screens/AdminScreen/CustomerInvoice.dart';
import 'package:tvs_app/Screens/AdminScreen/CustomerProfile.dart';
import 'package:http/http.dart' as http;
import 'package:tvs_app/Screens/AdminScreen/HomeScreen.dart';
import 'package:tvs_app/Screens/CommonScreen/ProductScreen.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart' show kIsWeb;



class SingleBikeInfo extends StatefulWidget {

  final String BikeName;
  final String BikeColor;
  final String BikeSalePrice;
  final String CustomerNID;
  final String CustomerPhoneNumber;
  final String CustomerID;
  final String BikeID;



  const SingleBikeInfo({super.key, required this.BikeName, required this.BikeColor, required this.BikeSalePrice, required this.CustomerNID, required this.CustomerPhoneNumber, required this.CustomerID, required this.BikeID});

  @override
  State<SingleBikeInfo> createState() => _SingleBikeInfoState();
}

class _SingleBikeInfoState extends State<SingleBikeInfo> {

  TextEditingController BikeNameController = TextEditingController();
  TextEditingController BikeChassisNoController = TextEditingController();
  TextEditingController BikeEngineNoController = TextEditingController();
  TextEditingController BikeColorController = TextEditingController();
  TextEditingController BikeSalePriceController = TextEditingController();
  TextEditingController BikeDeliveryNoController = TextEditingController();
  TextEditingController BikeConditionMonthController = TextEditingController();
  TextEditingController BikeBillPayController = TextEditingController();
  TextEditingController DiscountAmountController = TextEditingController();
  TextEditingController QtyController = TextEditingController();

  bool DiscountAvailable = false;
  bool ConditionAvailable = false;

  bool loading = false;

  var adminEmail ="";
  var adminName ="";





var uuid = Uuid();






List  AllData = [];




Future<void> getData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();
  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('customer');

    Query query = _collectionRef.where("CustomerID", isEqualTo: widget.CustomerID);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

      //  loading = false;
       
     });

    print(AllData);
}



  
  //  void snackShow(context,bool snackVisible, String CustomerPhoneNumber, String Amount, String CustomerNID, String BikeChassisNo, String BikeEngineNo, String BikeConditionMonth, String BikeName, String BikeBillPay) async{


  //       if (snackVisible == true) {

  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         await SendSMSToCustomer(CustomerPhoneNumber, CustomerNID, BikeSalePriceController.text, BikeName, BikeEngineNo, BikeChassisNo, BikeConditionMonth, BikeBillPay);

  //         await SendSMSToAdmin("01721915550", CustomerNID, Amount, BikeName, BikeBillPay);

          

  //     Navigator.push(context,
  //                       MaterialPageRoute(builder: (context) => CustomerProfile(CustomerNID: widget.CustomerNID) ));

                  

  //                 setState(() {
  //                           loading = false;
  //                         });
          
  //       }

  //       if (snackVisible == false) {

  //         setState(() {
  //           loading = false;
  //         });

  //         ScaffoldMessenger.of(context).showSnackBar(wrongSnackBar);
          
  //       }

        

  //     }


  bool EngineNoTextFieldEmpty = true;

  void CheckEngineNoTextField(){

    if (BikeEngineNoController.text.isEmpty) {

      setState(() {
        EngineNoTextFieldEmpty = true;
      });
      
    } else {

       setState(() {
        EngineNoTextFieldEmpty = false;
      });
      
    }

  }





  bool ChessisNoTextFieldEmpty = true;

  void ChessisNoTextField(){

    if (BikeChassisNoController.text.isEmpty) {

      setState(() {
        ChessisNoTextFieldEmpty = true;
      });
      
    } else {

       setState(() {
        ChessisNoTextFieldEmpty = false;
      });
      
    }

  }












  @override
  void initState() {

    print("${NumberToWordsEnglish.convert(100140020)}");

      //  FlutterNativeSplash.remove();
    // TODO: implement initState
        FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) {
                    if (user != null) {
                      setState(() {
                        adminEmail = user.email!;
                        adminName = user.displayName!;
                      });
                    }
                  });
    super.initState();
  }
  


  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();

    var SaleID = uuid.v4();

    BikeNameController.text = widget.BikeName;
    BikeSalePriceController.text = widget.BikeSalePrice;
    BikeColorController.text = widget.BikeColor;

    // DiscountAmountController.text = "0";


    
 

    return Scaffold(
      backgroundColor: Colors.white,


      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left:kIsWeb?205:5, right: kIsWeb?205:5,bottom: 5),
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
              IconButton(
                enableFeedback: false,
                onPressed: () async{


                  FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) {
                    if (user == null) {
                      print('User is currently signed out!');
                    } else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                    }
                  });

                  
                   



                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),



              IconButton(
                enableFeedback: false,
                onPressed: () {

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2")));



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


                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3")));



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





      
      appBar: AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Bike Information",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Center(
        child:CircularProgressIndicator(),
      ):SingleChildScrollView(

        child:  Padding(
          padding: EdgeInsets.only(left:kIsWeb?205:5, right: kIsWeb?205:5,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              
         
            
            
            
              TextField(
                onChanged: (value) {

                  CheckEngineNoTextField();
                  ChessisNoTextField();
                  
                },
          
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bike Name',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Enter Your Bike Name',
            
                    //  enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //     ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                    
                    
                    ),
                controller: BikeNameController,
              ),
            
            
            
            
              SizedBox(
                height: 20,
              ),
            
            
            
            
            
              TextField(
                      onChanged: (value) {

                  CheckEngineNoTextField();
                  ChessisNoTextField();
                  
                },
                decoration: InputDecoration(
                   helperStyle: TextStyle(color: Colors.red),
                      helperText: ChessisNoTextFieldEmpty?'*Required Enter Bike Chassis No':"",
                    border: OutlineInputBorder(),
                    labelText: 'Enter Chassis No',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Enter Chassis No',
                    //  enabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //   ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    
                    
                    ),
                controller: BikeChassisNoController,
              ),
            
              SizedBox(
                height: 10,
              ),



              TextField(
                onChanged: (value) {

                  CheckEngineNoTextField();
                  ChessisNoTextField();
                  
                },
                
                decoration: InputDecoration(
                   helperStyle: TextStyle(color: Colors.red),
                      helperText: EngineNoTextFieldEmpty?'*Required Enter Bike Engine No':"",
                    border: OutlineInputBorder(),
                    labelText: 'Enter Engine No',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Enter Engine No',
                    //  enabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //   ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    
                    
                    ),
                controller: BikeEngineNoController,
              ),
            
              SizedBox(
                height: 10,
              ),


              TextField(
                   onChanged: (value) {

                  CheckEngineNoTextField();
                  ChessisNoTextField();
                  
                },
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Bike Color',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Enter Bike Color',
                    //  enabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //   ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    
                    
                    ),
                controller: BikeColorController,
              ),
            
              SizedBox(
                height: 10,
              ),

              TextField(
                   onChanged: (value) {

                  CheckEngineNoTextField();
                  ChessisNoTextField();
                  
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Delivery No or File No',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Enter Delivery No or File No',
                    //  enabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                    //   ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    
                    
                    ),
                controller: BikeDeliveryNoController,
              ),
            
              SizedBox(
                height: 10,
              ),

               TextField(
              keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Per Bike Sale price',
                 labelStyle: TextStyle(
          color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
        ),
                hintText: 'Per Bike Sale price',
                //  enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                //   ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                  ),
                
                
                ),
            controller: BikeSalePriceController,
          ),

           SizedBox(
                height: 10,
              ),

               TextField(
                onChanged: (value) {

                  CheckEngineNoTextField();
                  ChessisNoTextField();
                  
                },
              keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'জমা টাকা',
                 labelStyle: TextStyle(
          color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
        ),
                hintText: 'জমা টাকা',
                //  enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                //   ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                  ),
                
                
                ),
            controller: BikeBillPayController,
          ),
        
        
          SizedBox(
            height: 10,
          ),



        
        
       


                           CheckboxListTile(
                                      title: Text(
                                          "Condition Available?"
                                              ,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Josefin Sans")),
                                      value: ConditionAvailable,
                                      onChanged: (newValue) {
                                        setState(() {
                                          ConditionAvailable = newValue!;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                    
                                    
                              const SizedBox(
                                      height: 20,
                                    ),


          ConditionAvailable? TextField(
              keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Condition Month',
                 labelStyle: TextStyle(
          color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
        ),
                hintText: 'Condition Month',
                //  enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                //   ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                  ),
                
                
                ),
            controller: BikeConditionMonthController,
          ):Text(""),
        
          SizedBox(
            height: 10,
          ),



                         CheckboxListTile(
                                      title: Text(
                                          "Discount Available?"
                                              ,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Josefin Sans")),
                                      value: DiscountAvailable,
                                      onChanged: (newValue) {
                                        setState(() {
                                          DiscountAvailable = newValue!;
                                        });
                                      },
                                      controlAffinity: ListTileControlAffinity
                                          .leading, //  <-- leading Checkbox
                                    ),
                                    
                                    
                              const SizedBox(
                                      height: 20,
                                    ),


                


             DiscountAvailable?   TextField(
              keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Discount Amount',
                 labelStyle: TextStyle(
          color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
        ),
                hintText: 'Discount Amount',
                //  enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                //   ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                  ),
                
                
                ),
            controller: DiscountAmountController,
          ):Text(""),
        
          SizedBox(
            height: 10,
          ),


  
            ChessisNoTextFieldEmpty||EngineNoTextFieldEmpty?Text(""):Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 150, child:ElevatedButton(onPressed: () async{


                    setState(() {
                          loading = true;
                        });




          
          //Update Firebase Collection Customer Data 

        Future EditCustomerInformation(String CustomerNID, String BikeChassisNo, String BikeEngineNo, String BikeConditionMonth, String BikeDeliveryNo, String BikeSalePrice, String BikeBillPay) async{



           

              int BikeSalePriceInt = int.parse(BikeSalePrice);
              int BikeBillPayInt = int.parse(BikeBillPay);
              int BikePaymentDueInt =  BikeSalePriceInt - BikeBillPayInt;
              int DiscountPrice = DiscountAvailable?int.parse(DiscountAmountController.text.trim().toString()):0;

              int withDiscountDue = BikePaymentDueInt-DiscountPrice;

              var CustomerType = "Due";

              if (withDiscountDue <= 0) {

                setState(() {
                  CustomerType = "Paid";
                });

                
              } else {

                CustomerType = "Due";
                
              }



              var BikePaymentDueString = BikePaymentDueInt.toString();

              int DuePaymentGivingDayInt = int.parse(DateTime.now().day.toString());

              if (DuePaymentGivingDayInt>30) {

                DuePaymentGivingDayInt = 30;
                
              }


            final docUser = FirebaseFirestore.instance.collection("customer").doc(widget.CustomerID);

            

            final UpadateData ={
              "BikeName":BikeNameController.text.trim(),
              "BikeColor":BikeColorController.text.trim(),
              "BikeChassisNo":BikeChassisNoController.text.trim(),
              "BikeEngineNo":BikeEngineNoController.text.trim(),
              "BikeConditionMonth":ConditionAvailable?BikeConditionMonthController.text.trim().toString():"0",
              "BikeDeliveryNo":BikeDeliveryNoController.text.trim(),
              "BikeSalePrice":BikeSalePriceController.text.trim(),
              "BikeDeliveryDate":DateTime.now().toIso8601String(),
              "BikeBillPay":BikeBillPayController.text.trim().toString(),
              "BikePaymentDue": AllData.isNotEmpty?(double.parse(AllData[0]["BikePaymentDue"])+double.parse(BikePaymentDueString)).toString():BikePaymentDueString,
              "CustomerType":CustomerType,
              "DuePaymentGivingDay":DuePaymentGivingDayInt.toString()        
          };


          // user Data Update and show snackbar

            docUser.update(UpadateData).then((value) => setState(() async{

              await SendSMSToCustomer(widget.CustomerPhoneNumber, CustomerNID, BikeSalePriceController.text, widget.BikeName, BikeEngineNo, BikeChassisNo, BikeConditionMonth, BikeBillPay);

              await SendSMSToAdmin("", widget.CustomerPhoneNumber, widget.BikeName, BikeBillPay);


            })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
                        content: const Text('Something Wrong!!! Try again'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      )));


        

        }

                    EditCustomerInformation(widget.CustomerNID, BikeChassisNoController.text, BikeEngineNoController.text, BikeConditionMonthController.text, BikeDeliveryNoController.text, BikeSalePriceController.text, BikeBillPayController.text);

                  

            Future CustomerBikeSaleInfo(String BikeName, String BikeColor, String BikeChassisNo, String BikeEngineNo,String BikeDeliveryNo,  String BikeSalePrice, String CustomerNID, String BikeBillPay) async{


                int BikeSalePriceInt = int.parse(BikeSalePrice);
                int BikeBillPayInt = int.parse(BikeBillPay);
                int BikePaymentDueInt =  BikeSalePriceInt - BikeBillPayInt;
                var CustomerType = "Due";

              if (BikePaymentDueInt == 0) {

                setState(() {
                  CustomerType = "Paid";
                });

                
              } else {

                CustomerType = "Due";
                
              }
                var BikePaymentDueString = BikePaymentDueInt.toString();

          
      List GetBikeData =[];

      CollectionReference _GetBikecollectionDataRef =
    FirebaseFirestore.instance.collection('product');

    
    Query GetBikequeryData = _GetBikecollectionDataRef.where("BikeID", isEqualTo: widget.BikeID);
    QuerySnapshot GetBikequerySnapshot = await GetBikequeryData.get();

    // Get data from docs and convert map to List
     GetBikeData = GetBikequerySnapshot.docs.map((doc) => doc.data()).toList();




                List CustomerData = [0];


      CollectionReference _collectionDataRef =
    FirebaseFirestore.instance.collection('customer');

    
    Query queryData = _collectionDataRef.where("CustomerID", isEqualTo: widget.CustomerID);
    QuerySnapshot querySnapshot = await queryData.get();

    // Get data from docs and convert map to List
     CustomerData = querySnapshot.docs.map((doc) => doc.data()).toList();





                final docUser = FirebaseFirestore.instance.collection("BikeSaleInfo");

                final jsonData ={
                  "ClassOfVehicle":"MOTOR CYCLE",
                  "BikeBuyingPrice":GetBikeData[0]["BikeBuyingPrice"],
                  "YearOfManufacture":GetBikeData[0]["YearOfManufacture"],
                  "SeatingCapacity":GetBikeData[0]["SeatingCapacity"],
                  "BikeValvePerCylinder":GetBikeData[0]["BikeValvePerCylinder"],
                  "MakersName":"Honda Motor Company Ltd.",
                  "BikeMaximumPower":GetBikeData[0]["BikeMaximumPower"],
                  "BikeWheelBase":GetBikeData[0]["BikeWheelBase"],
                  "BikeTyreFront":GetBikeData[0]["BikeTyreFront"],
                  "BikeTyreRear":GetBikeData[0]["BikeTyreRear"],
                  "SaleID":SaleID,
                  "CustomerAddress":CustomerData[0]["CustomerAddress"],
                  "BikeID":widget.BikeID,
                  "CustomerID":widget.CustomerID,
                  "CustomerNID": widget.CustomerNID,
                  "BikeChassisNo":BikeChassisNoController.text,
                  "BikeEngineNo":BikeEngineNoController.text,
                  "BikeDeliveryNo":BikeDeliveryNoController.text,
                  "BikeName":BikeNameController.text,
                  "BikeColor":widget.BikeColor,
                  "BikeSalePrice":widget.BikeSalePrice,
                  // "DiscountWithBikeSalePrice":DiscountAvailable?(int.parse(widget.BikeSalePrice.toString())-int.parse(DiscountAmountController.text.trim().toString())):int.parse(widget.BikeSalePrice.toString()),
               
                  "BikeDeliveryDate":DateTime.now(),
                  "BikeSaleDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  "BikeSaleMonth":"${DateTime.now().month}/${DateTime.now().year}",
                  "BikeSaleYear":"${DateTime.now().year}",
                  "BikeBillPay":BikeBillPayController.text.trim().toString(),
                  "Discount":DiscountAvailable?DiscountAmountController.text.trim().toString():"0",
                  "BikePaymentDue":DiscountAvailable?((int.parse(widget.BikeSalePrice.toString())-int.parse(BikeBillPayController.text.trim().toString()))-int.parse(DiscountAmountController.text.trim().toString())).toString():(int.parse(widget.BikeSalePrice.toString())-int.parse(BikeBillPayController.text.trim().toString())).toString(),
                  "CustomerType":CustomerType,
                  "CustomerName":CustomerData[0]["CustomerName"],
                  "CustomerPhoneNumber":CustomerData[0]["CustomerPhoneNumber"],
                  "BikeConditionMonth":ConditionAvailable?BikeConditionMonthController.text.trim().toString():"0",
                  "CustomerFatherName":CustomerData[0]["CustomerFatherName"],
                  "CustomerGuarantor1Address":CustomerData[0]["CustomerGuarantor1Address"],
                  "CustomerGuarantor1NID":CustomerData[0]["CustomerGuarantor1NID"],
                  "CustomerGuarantor1Name":CustomerData[0]["CustomerGuarantor1Name"],
                  "CustomerGuarantor1PhoneNumber":CustomerData[0]["CustomerGuarantor1PhoneNumber"],
                  "CustomerGuarantor2Address":CustomerData[0]["CustomerGuarantor2Address"],
                  "CustomerGuarantor2NID":CustomerData[0]["CustomerGuarantor2NID"],
                  "CustomerGuarantor2Name":CustomerData[0]["CustomerGuarantor2Name"],
                  "CustomerGuarantor2PhoneNumber":CustomerData[0]["CustomerGuarantor2PhoneNumber"],
                  "DuePaymentGivingDay":CustomerData[0]["DuePaymentGivingDay"],
                  "CustomerMotherName":CustomerData[0]["CustomerMotherName"],
                  "adminEmail":adminEmail,
                  "adminName":adminName,
                  "TotalCashIn":BikeBillPayController.text.trim(),
                  "AllOwners":[],
                  "RPM":GetBikeData[0]["RPM"],
                  "HorsePower":GetBikeData[0]["HorsePower"],
                  "BikeLadenWeight":GetBikeData[0]["BikeKerbWeight"],
                  // "WithDiscountBikeBillPay":DiscountAvailable?(int.parse(BikeBillPayController.text.trim().toString())-int.parse(DiscountAmountController.text.trim().toString())).toString():BikeBillPayController.text.trim().toString(),
                
                  
                };


              await docUser.doc(SaleID).set(jsonData).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
                        content: const Text('Successfull'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      ))).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
                        content: const Text('Something Wrong!'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      )));


                  //     final salePrice = FirebaseFirestore.instance.collection("BikeSalePrice");

                  //     final saleData ={
                  // "ClassOfVehicle":"MOTOR CYCLE",
                  // "BikeBuyingPrice":GetBikeData[0]["BikeBuyingPrice"],
                  // "YearOfManufacture":GetBikeData[0]["YearOfManufacture"],
                  // "SeatingCapacity":GetBikeData[0]["SeatingCapacity"],
                  // "BikeValvePerCylinder":GetBikeData[0]["BikeValvePerCylinder"],
                  // "MakersName":"Honda Motor Company Ltd.",
                  // "BikeMaximumPower":GetBikeData[0]["BikeMaximumPower"],
                  // "BikeWheelBase":GetBikeData[0]["BikeWheelBase"],
                  // "BikeTyreFront":GetBikeData[0]["BikeTyreFront"],
                  // "BikeTyreRear":GetBikeData[0]["BikeTyreRear"],
                  // "SaleID":SaleID,
                  // "BikeID":widget.BikeID,
                  // "CustomerID":widget.CustomerID,
                  // "CustomerNID": widget.CustomerNID,
                  // "BikeChassisNo":BikeChassisNoController.text,
                  // "BikeEngineNo":BikeEngineNoController.text,
                  // "BikeDeliveryNo":BikeDeliveryNoController.text,
                  // "BikeName":BikeNameController.text,
                  // "BikeConditionMonth":ConditionAvailable?BikeConditionMonthController.text.trim().toString():"0",
                  // "BikeColor":widget.BikeColor,
                  // "BikeSalePrice":widget.BikeSalePrice,
                  // "DiscountWithBikeSalePrice":DiscountAvailable?(int.parse(widget.BikeSalePrice.toString())-int.parse(DiscountAmountController.text.trim().toString())):widget.BikeSalePrice.toString(),
                  // "Discount":DiscountAvailable?DiscountAmountController.text.trim().toString():"0",
                  // "BikeDeliveryDate":DateTime.now(),
                  // "BikeSaleDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  // "BikeSaleMonth":"${DateTime.now().month}/${DateTime.now().year}",
                  // "BikeSaleYear":"${DateTime.now().year}",
               
                  // "BikeBillPayToWord":NumberToWordsEnglish.convert(int.parse(BikeBillPayController.text.trim().toString())),
                  // // "BikePaymentDue":BikePaymentDueString,
                  // "BikePaymentDue":DiscountAvailable?((int.parse(widget.BikeSalePrice.toString())-int.parse(BikeBillPayController.text.trim().toString()))-int.parse(DiscountAmountController.text.trim().toString())).toString():(int.parse(widget.BikeSalePrice.toString())-int.parse(BikeBillPayController.text.trim().toString())).toString(),
                  // "CustomerType":CustomerType,
                  // "CustomerName":CustomerData[0]["CustomerName"],
                  // "CustomerPhoneNumber":CustomerData[0]["CustomerPhoneNumber"],
                  // "CustomerAddress":CustomerData[0]["CustomerAddress"],
                  // "CustomerFatherName":CustomerData[0]["CustomerFatherName"],
                  // "CustomerGuarantor1Address":CustomerData[0]["CustomerGuarantor1Address"],
                  // "CustomerGuarantor1NID":CustomerData[0]["CustomerGuarantor1NID"],
                  // "CustomerGuarantor1Name":CustomerData[0]["CustomerGuarantor1Name"],
                  // "CustomerGuarantor1PhoneNumber":CustomerData[0]["CustomerGuarantor1PhoneNumber"],
                  // "CustomerGuarantor2Address":CustomerData[0]["CustomerGuarantor2Address"],
                  // "CustomerGuarantor2NID":CustomerData[0]["CustomerGuarantor2NID"],
                  // "CustomerGuarantor2Name":CustomerData[0]["CustomerGuarantor2Name"],
                  // "CustomerGuarantor2PhoneNumber":CustomerData[0]["CustomerGuarantor2PhoneNumber"],
                  // "DuePaymentGivingDay":CustomerData[0]["DuePaymentGivingDay"],
                  // "CustomerMotherName":CustomerData[0]["CustomerMotherName"],
                  // "adminEmail":adminEmail,
                  // "adminName":adminName,
                  // "SalePrice":BikeSalePrice,
                  // "DuePrice":BikePaymentDueInt.toString(),
                  // "TotalCashIn":BikeBillPayController.text.trim(),
                  // "RPM":GetBikeData[0]["RPM"],
                  // "HorsePower":GetBikeData[0]["HorsePower"],
                  // "BikeLadenWeight":GetBikeData[0]["BikeKerbWeight"],
                  // // "WithDiscountBikeBillPay":DiscountAvailable?(int.parse(BikeBillPayController.text.trim().toString())-int.parse(DiscountAmountController.text.trim().toString())).toString():BikeBillPayController.text.trim().toString(),
                  // "BikeBillPay":BikeBillPayController.text.trim().toString(),

                  //     };

                  //   await salePrice.add(saleData).then((value) => print(""));

                    List BikeData = [0];


      CollectionReference _BikecollectionDataRef =
    FirebaseFirestore.instance.collection('product');

    
    Query BikequeryData = _BikecollectionDataRef.where("BikeID", isEqualTo: widget.BikeID);
    QuerySnapshot BikequerySnapshot = await BikequeryData.get();

    // Get data from docs and convert map to List
     BikeData = BikequerySnapshot.docs.map((doc) => doc.data()).toList();

     var bikeAvailableNumber = BikeData[0]["BikeShowroomAvailableNumber"];

     int bikeAvailableNumberInt = int.parse(bikeAvailableNumber.toString());

     int BikeUpdateAvailableNumber = bikeAvailableNumberInt - 1;

     
    BikequerySnapshot.docs[0].reference.update({"BikeShowroomAvailableNumber":BikeUpdateAvailableNumber.toString()}).then((value) => setState(() {

                setState(() {
                        loading = false;
                      });




                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  AfterSaleBike(SalesData: [jsonData])));





                        // PdfPreviewPage(CustomerName: CustomerData[0]["CustomerName"], CustomerNID: widget.CustomerNID, CustomerPhoneNumber: CustomerData[0]["CustomerPhoneNumber"], CustomerFileNo: BikeDeliveryNoController.text, CustomerAddress: CustomerData[0]["CustomerAddress"], BikeName: widget.BikeName, BikeEngineNo: BikeEngineNoController.text, BikeChassisNo: BikeChassisNoController.text, BikeSalePrice: BikeSalePrice, BikeCashInAmount: BikeBillPay, BikePaymentDue: BikePaymentDueString, BikeColor: widget.BikeColor, BikeCondition: BikeConditionMonthController.text)
      



    },));


                        
              }



            CustomerBikeSaleInfo(widget.BikeName, widget.BikeColor, widget.BikeColor, BikeEngineNoController.text, BikeDeliveryNoController.text, BikeSalePriceController.text, widget.CustomerNID, BikeBillPayController.text);



                  }, child: Text("Save", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
          backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
        ),),),



                ],
              ),



              
         SizedBox(
            height: 30,
          ),
            
            
            
            ],
          ),
        ),
        ),
      
      
    );
  }



  
 final snackBar = SnackBar(
            content: const Text('Customer Information Setup Seccessful!'),
            backgroundColor: (Colors.green),
            action: SnackBarAction(
              label: 'dismiss',
              onPressed: () {

                
                
              },
            ),
          );



          final wrongSnackBar = SnackBar(
            content: const Text('Something Wrong!! Try again'),
            backgroundColor: (Colors.red),
            action: SnackBarAction(
              label: 'dismiss',
              onPressed: () {
              },
            ),
          );
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}











          
Future SendSMSToCustomer(String CustomerPhoneNumber, String CustomerNID, String amount,String BikeName, String BikeEngineNo,String BikeChassisNo, String BikeConditionMonth, String BikeBillPay) async {


try {



    var customerMsg = "Dear Customer,A-ONE IMPEX থেকে ${BikeBillPay} টাকা পরিশোধ করে ${BikeName} Bike ক্রয় করেছেন। Thank You";



  final response = await http
      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${CustomerPhoneNumber}&message=${customerMsg}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
   

    
    
   
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }






  
} catch (e) {
  
}


}






Future SendSMSToAdmin(String AdminPhoneNumber, String CustomerPhoneNumber, String BikeName, String BikeBillPay) async {



  try {



    var AdminMsg = "Dear Admin, A-ONE IMPEX থেকে ${BikeBillPay} টাকা পরিশোধ করে ${BikeName} Bike ক্রয় করেছেন। Phone no:$CustomerPhoneNumber}";



  final response = await http
      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=01721915550&message=${AdminMsg}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(jsonDecode(response.body));
    
   
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }







    
  } catch (e) {
    
  }


  
  
}