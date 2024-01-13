import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tvs_app/Screens/AdminScreen/PaymentAddInvoice.dart';

class CustomerPaymentAdd extends StatefulWidget {


  final CustomerNID;
  final CustomerID;
  final CustomerPhoneNumber;
  final BikePaymentDue;
  final CustomerName;




  const CustomerPaymentAdd({super.key, required this.CustomerNID, required this.CustomerPhoneNumber, required this.BikePaymentDue, required this.CustomerName, required this.CustomerID});

  @override
  State<CustomerPaymentAdd> createState() => _CustomerPaymentAddState();
}

class _CustomerPaymentAddState extends State<CustomerPaymentAdd> {
  
  TextEditingController CustomerNIDController = TextEditingController();
  TextEditingController CustomerPhoneNumberController = TextEditingController();
  TextEditingController PaidAmountController = TextEditingController();


    bool loading = false;

  



  //  void snackShow(bool snackVisible, String CustomerPhoneNumber, String Amount, String CustomerNID) async{


  //   setState(() {
  //     loading = true;
  //   });


  //       if (snackVisible == true) {

  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);



  //                   FirebaseAuth.instance
  //                       .authStateChanges()
  //                       .listen((User? user) async{
  //                         if (user == null) {
  //                           print('User is currently signed out!');
  //                         } else {





  //                var AdminMsg = "Dear Admin, TVS কালাই শোরুমে NID:${widget.CustomerNID} ${PaidAmountController.text}৳ কিস্তি পরিশোধ করেছেন।${user.email} Admin টাকা জমা নিয়েছেন।";



  //                 final response = await http
  //                     .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=01721915550&message=${AdminMsg}'));

  //                 if (response.statusCode == 200) {
  //                   // If the server did return a 200 OK response,
  //                   // then parse the JSON.
  //                   print(jsonDecode(response.body));


  //                   setState(() {

  //                     loading = false;
                      
  //                   });
                    
                  
  //                 } else {
  //                   // If the server did not return a 200 OK response,
  //                   // then throw an exception.
  //                   throw Exception('Failed to load album');
  //                 }
                




                            







  //                         }
  //                       });




  //         await SendSMSToCustomer(CustomerPhoneNumber, CustomerNID, Amount);

  //         // CustomerNIDController.clear();
  //         // CustomerPhoneNumberController.clear();
  //         // PaidAmountController.clear();
          

         
          
  //       }


        

  //       // if (snackVisible == false) {

  //       //   ScaffoldMessenger.of(context).showSnackBar(wrongSnackBar);
          
  //       // }


        

        

  //     }
  

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();

    dynamic paymentDateTime = DateTime.now();

    var PaymentDate = "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";

    var PaymentMonth = "${DateTime.now().month.toString()}/${DateTime.now().year.toString()}";

    var PaymentYear = "${DateTime.now().year.toString()}";




    CustomerNIDController.text = widget.CustomerNID;
    CustomerPhoneNumberController.text = widget.CustomerPhoneNumber;

    // date pick 

    // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    //   // TODO: implement your code here

    //   dynamic value = args.value;
      
    //   print(value);
    //   setState(() {
    //     paymentDate = value;
    //   });
    // }






     





    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: Icon(Icons.chevron_left)),
        title: const Text(
          "Customer Payment Add",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: loading?Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: const Color(0xFF1A1A3F),
          secondRingColor: Theme.of(context).primaryColor,
          thirdRingColor: Colors.white,
          size: 100,
        ),
      ):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lottie.network(
              //   'https://assets8.lottiefiles.com/packages/lf20_7Ht9wn.json',
              //   width: 700,
              //   height: 200,
              // ),
             
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Customer NID',
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Theme.of(context).primaryColor : Colors.black),
                  hintText: 'Customer NID',
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
                maxLines: 20,
                minLines: 1,
                controller: CustomerNIDController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Theme.of(context).primaryColor : Colors.black),
                  hintText: 'Amount',
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
                maxLines: 20,
                minLines: 1,
                controller: PaidAmountController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Customer Phone Number',
                  labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Theme.of(context).primaryColor : Colors.black),
                  hintText: 'Customer Phone Number',
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
                maxLines: 20,
                minLines: 1,
                controller: CustomerPhoneNumberController,
              ),
              SizedBox(
                height: 10,
              ),


              // Container(
              //   child: Text("Pick Payment Date"),
              // ),

               SizedBox(
                height: 10,
              ),








              // Container(
              //   child: SfDateRangePicker(
              //     onSelectionChanged: _onSelectionChanged,
              //     selectionMode: DateRangePickerSelectionMode.range,
              //     todayHighlightColor: Colors.purple,
              //   ),
              // ),



              SizedBox(
                height: 10,
              ),
              Container(
                width: 150,
                child: TextButton(
                  onPressed: () async{



                    setState(() {
                      loading = true;
                    });


                    var adminEmail ="";
                    var adminName = "";

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


                    int LastBikeDuePayment = 0;

                    int BikePaymentDueInt = int.parse(widget.BikePaymentDue.toString());
                    int AmountInt = int.parse(PaidAmountController.text.toString());

                    LastBikeDuePayment = BikePaymentDueInt - AmountInt;


                    print(AmountInt.toString());
                    print(BikePaymentDueInt.toString());
                    print(LastBikeDuePayment.toString());



                     Future DuePaymentAdd(String CustomerNID, String CustomerPhoneNumber, String Amount) async{

                      final docUser = FirebaseFirestore.instance.collection("DuePaymentAddInfo");

                      final jsonData ={

                        
                        "CustomerNID":CustomerNID.trim(),
                        "CustomerID":widget.CustomerID,
                        "CustomerPhoneNumber":CustomerPhoneNumber.trim(),
                        "Amount": Amount.trim(),
                        "PaymentDateTime":paymentDateTime,
                        "PaymentDate":PaymentDate,
                        "PaymentMonth":PaymentMonth,
                        "PaymentYear":PaymentYear,
                        "adminEmail":adminEmail,
                        "adminName":adminName

                        
                      };


                    await docUser.add(jsonData).then((value) =>  setState(() async{









                        var customerMsg = "Dear Customer আপনি TVS কালাই শোরুমে ${CustomerNID} Account No এ ${Amount}৳ কিস্তি পরিশোধ করেছেন। ধন্যবাদ";



                        final CustomerSmsResponse = await http
                            .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${CustomerPhoneNumber}&message=${customerMsg}'));

                        if (CustomerSmsResponse.statusCode == 200) {
                          // If the server did return a 200 OK response,
                          // then parse the JSON.
                          
                          print(jsonDecode(CustomerSmsResponse.body));
                        
                        } else {
                          // If the server did not return a 200 OK response,
                          // then throw an exception.
                          throw Exception('Failed to load album');
                        }




                      
                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) async{
                          if (user == null) {
                            print('User is currently signed out!');
                          } else {





                 var AdminMsg = "Dear Admin, আপনার শোরুমে NID:${widget.CustomerNID} ${PaidAmountController.text}৳ কিস্তি পরিশোধ করেছেন।${user.email} Admin টাকা জমা নিয়েছেন।";



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
                




                            







                          }
                        });




       
    





  })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content: const Text('Customer Payment Add Successful!!!'),
            backgroundColor: (Colors.green),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));



                    }




                DuePaymentAdd(CustomerNIDController.text, CustomerPhoneNumberController.text, PaidAmountController.text);






                  if (LastBikeDuePayment==0) {




                    
                final docUser = FirebaseFirestore.instance.collection("customer").doc(widget.CustomerID);

            

            final UpadateData ={


              "BikePaymentDue":LastBikeDuePayment.toString(),
              "CustomerType":"Paid"
          
              
            

          
          
          };





          // user Data Update and show snackbar

            docUser.update(UpadateData).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
                        content: const Text('Customer Information Setup Seccessful! and Message Sent'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      ))).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                  else{




                      final docUser = FirebaseFirestore.instance.collection("customer").doc(CustomerNIDController.text);

            

            final UpadateData ={


              "BikePaymentDue":LastBikeDuePayment.toString(),
              
          
              
            

          
          
          };





          // user Data Update and show snackbar

            docUser.update(UpadateData).then((value) =>  setState((){


              
              setState(() {
                loading = false;
              });





              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentAddPreviewPdf(CustomerNID: widget.CustomerNID, CustomerPhoneNumber: widget.CustomerPhoneNumber, BikeCashInAmount: PaidAmountController.text, BikePaymentDue: LastBikeDuePayment.toString(), CustomerName: widget.CustomerName,)));









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










                  
             



















                  



                 





                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




   final snackBar = SnackBar(
            content: const Text('Customer Payment Add Successful!!!'),
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




          
Future SendSMSToCustomer(String CustomerPhoneNumber, String CustomerNID, String Amount) async {

  var customerMsg = "Dear Customer আপনি TVS কালাই শোরুমে ${CustomerNID} Account No এ ${Amount}৳ কিস্তি পরিশোধ করেছেন। ধন্যবাদ";



  final response = await http
      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${CustomerPhoneNumber}&message=${customerMsg}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    
    print(jsonDecode(response.body));
   
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}