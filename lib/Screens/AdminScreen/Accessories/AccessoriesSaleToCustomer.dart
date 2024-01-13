import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tvs_app/Screens/AdminScreen/Accessories/AccessoriesScreen.dart';
import 'package:tvs_app/Screens/AdminScreen/Accessories/PerMonthAccessoriesSalesHistory.dart';
import 'package:tvs_app/Screens/AdminScreen/AllAdmin.dart';
import 'package:tvs_app/Screens/AdminScreen/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';




class AccessoriesSaleToCustomer extends StatefulWidget {

 final AccessoriesName;
 final AccessoriesID;
 final AccessoriesSalePrice;
 final AccessoriesAvailableNumber;




  const AccessoriesSaleToCustomer({super.key, required this.AccessoriesID, required this.AccessoriesName, required this.AccessoriesSalePrice, required this.AccessoriesAvailableNumber});

  @override
  State<AccessoriesSaleToCustomer> createState() => _AccessoriesSaleToCustomerState();
}

class _AccessoriesSaleToCustomerState extends State<AccessoriesSaleToCustomer> {

 var uuid = Uuid();
 
  TextEditingController CustomerNameController = TextEditingController();
  TextEditingController CustomerPhoneNumberController = TextEditingController();





  bool loading = false;

  var adminEmail = "";
  var adminName = "";








  @override
  void initState() {
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
   
    var CustomerID = uuid.v4();

    FocusNode myFocusNode = new FocusNode();
 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
           systemOverlayStyle: SystemUiOverlayStyle(
      // Navigation bar
      statusBarColor: Theme.of(context).primaryColor, // Status bar
    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Customer Info",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor: Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ): SingleChildScrollView(

        child:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              
         
            
            
            
              TextField(
               
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Customer Name',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Customer Name',
            
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
                controller: CustomerNameController,
              ),


              SizedBox(height: 8,),

              TextField(
               
               keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Customer Phone Number',
                     labelStyle: TextStyle(
        color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
            ),
                    hintText: 'Customer Phone Number',
            
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
                controller: CustomerPhoneNumberController,
              ),



              
            
            
            
              SizedBox(
                height: 10,
              ),
            
            
            
            
            
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 150, child:TextButton(onPressed: () async{

                    setState(() {
                      loading = true;
                    });








                    final docUser =  FirebaseFirestore.instance.collection("AccessoriesCustomerInfo");


                var AccessoriesData ={

                  "AccessoriesName":widget.AccessoriesName,
                  "AccessoriesSalePrice":widget.AccessoriesSalePrice,
               
                  "AccessoriesID":widget.AccessoriesID,
                  "CustomerName":CustomerNameController.text.trim().toLowerCase(),
                  "CustomerPhoneNumber":CustomerPhoneNumberController.text.trim(),
                  "SaleDate":"${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  "SaleMonth":"${DateTime.now().month}/${DateTime.now().year}",
                  "SaleYear":"${DateTime.now().year}",
                  "CustomerID":CustomerID.toString(),
                  "adminEmail":adminEmail,
                  "adminName":adminName


               
                };

   int AccessoriesAvailableNumberInt = int.parse(widget.AccessoriesAvailableNumber.toString());

     int AccessoriesUpdateAvailableNumber = AccessoriesAvailableNumberInt - 1;







                 












                    docUser.doc(CustomerID).set(AccessoriesData).then((value) =>setState(() async{



                            final docUser =  FirebaseFirestore.instance.collection("accessoriesinfo").doc(widget.AccessoriesID);

                  final UpadateData ={
                              "AccessoriesAvailableNumber":AccessoriesUpdateAvailableNumber.toString(),
                          
                            
                            };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) =>    
                  setState(() {



                     SendSMSToCustomer(CustomerPhoneNumberController.text.toString().trim(), widget.AccessoriesSalePrice);




           




                     loading = false;

                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerMonthAccessoriesSalesHistory()),
                );






            
             
                  })).onError((error, stackTrace) => print(error));



                      




              





                    })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
                        content: const Text('Something Wrong'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      )));






                



                  }, child: Text("Sale", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
          backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
        ),),),



              




                ],
              )
            
            
            
            ],
          ),
        ),
        ),
      
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xf08f00ff);
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





Future SendSMSToCustomer(String CustomerPhoneNumber, String AccessoriesSalePrice)async{



try {

   var CustomerMsg = "Dear Customer,A-ONE IMPEX থেকে ${AccessoriesSalePrice}৳ Product ক্রয় করেছেন। ধন্যবাদ";



                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${CustomerPhoneNumber}&message=${CustomerMsg}'));

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


  print(e);
  
}



  


}
