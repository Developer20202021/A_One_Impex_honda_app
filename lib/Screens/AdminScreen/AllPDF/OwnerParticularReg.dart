
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';








class OwnerParticularRegPDF extends StatefulWidget {


final List SalesData;

 const OwnerParticularRegPDF({super.key,  required this.SalesData});

  @override
  State<OwnerParticularRegPDF> createState() => _OwnerParticularRegPDFState();
}

class _OwnerParticularRegPDFState extends State<OwnerParticularRegPDF> {






@override
  void initState() {
    FlutterNativeSplash.remove();
    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      
      appBar: AppBar(
      
      
      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: Colors.blueAccent, // Status bar
          ),
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Owner's Particulars", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: PdfPreview(
        build: (context) => makePdf(widget.SalesData),
      ),
    );
  }
}



// makePdf(widget.StudentName,widget.StudentIDNo, widget.StudentPhoneNumber,widget.StudentCashIn,widget.StudentEmail,widget.CashInDate)








Future<Uint8List> makePdf(List SalesData) async {

final netImage = await networkImage('https://i.ibb.co/mqRKMyy/pngwing-com-4.png');

final backImage = await networkImage('https://i.ibb.co/0f26g8Z/pngwing-com-6.png');


// https://i.ibb.co/0f26g8Z/pngwing-com-6.png


// https://i.ibb.co/kmsjjWz/pngwing-com-1.png








final pdf = pw.Document();

final garland = await rootBundle.loadString('lib/images/border_image.svg');
final swirls3 = await rootBundle.loadString('lib/images/swirls3.svg');
final swirls = await rootBundle.loadString('lib/images/swirls.svg');
final swirls1 = await rootBundle.loadString('lib/images/swirls1.svg');
final swirls2 = await rootBundle.loadString('lib/images/swirls2.svg');

// final ByteData image = await rootBundle.load('lib/images/pngwing.png');

// Uint8List imageData = (image).buffer.asUint8List();


final font = await rootBundle.load("lib/fonts/Bungee-Regular.ttf");
final ttf = pw.Font.ttf(font);

final Banglafont = await rootBundle.load("lib/fonts/Siyam-Rupali-ANSI.ttf");
final Banglattf = pw.Font.ttf(Banglafont);


pdf.addPage(pw.Page(
  
  pageTheme: pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    theme: pw.ThemeData.withFont(base: pw.Font.ttf(await rootBundle.load("lib/fonts/Caladea-BoldItalic.ttf")),),
    buildBackground: (context)=>pw.FullPage(ignoreMargins: true,child: pw.Container(

       margin: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              // border: pw.Border.all(
              //     color: const PdfColor.fromInt(0xf44336), width: 1),
            ),

      child:  pw.Container(

         margin: const pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(
                
                // border: pw.Border.all(
                //     color: const PdfColor.fromInt(0xf44336), width: 5),
              ),
              width: double.infinity,
              height: double.infinity,
              child: pw.Stack(
                alignment: pw.Alignment.center,
                children: [

          //  pw.Positioned(
          //           bottom: 5,
          //           left: 5,
          //           child: pw.Transform(
          //             transform: Matrix4.diagonal3Values(1, -1, 1),
          //             adjustLayout: true,
          //             child: pw.SvgImage(
          //               svg: swirls3,
          //               height: 160,
          //             ),
          //           ),
          //         ),


          //           pw.Positioned(
          //           top: 5,
          //           left: 5,
          //           child: pw.SvgImage(
          //             svg: swirls3,
          //             height: 160,
          //           ),
          //         ),
          //         pw.Positioned(
          //           top: 5,
          //           right: 5,
          //           child: pw.Transform(
          //             transform: Matrix4.diagonal3Values(-1, 1, 1),
          //             adjustLayout: true,
          //             child: pw.SvgImage(
          //               svg: swirls3,
          //               height: 160,
          //             ),
          //           ),
          //         ),

          //         pw.Positioned(
          //           bottom: 5,
          //           right: 5,
          //           child: pw.Transform(
          //             transform: Matrix4.diagonal3Values(-1, -1, 1),
          //             adjustLayout: true,
          //             child: pw.SvgImage(
          //               svg: swirls3,
          //               height: 160,
          //             ),
          //           ),
          //         ),


                    //  pw.Image(backImage, height: 950, width: 550,),

                  
                  // pw.Container(
                  //       width: 1380.0,
                  //       height: 890.0,
                  //       child: pw.Image(pw.MemoryImage(imageData))
                  //   )


                ]
              )
      )
    ))
  ),
  
  // theme: pw.ThemeData.withFont(base: pw.Font.ttf(await rootBundle.load("lib/fonts/Bungee-Regular.ttf")),),
  //     pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(children: [

            pw.Row(
              
              mainAxisAlignment: pw.MainAxisAlignment.start,

              children: [

                // pw.Padding(
                //    padding: pw.EdgeInsets.only(left: 30,top: 30),
                //   child: pw.Center(child:  pw.Image(netImage, height: 70, width: 70, ),),),

                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 20,),
                  
                  child: pw.Column(children: [

                  pw.Text("OWNER'S PARTICULARS/SPECIMEN SIGNATURE", style:pw.TextStyle(fontSize: 17, fontWeight: pw.FontWeight.bold,  color: PdfColor.fromInt(0x000000))),


                  pw.Text("For Vehicle Registration or Ownership Transfer", style:pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold,  color: PdfColor.fromInt(0x000000))),
    

                ]))




            ]),



            pw.Row(

              mainAxisAlignment: pw.MainAxisAlignment.end,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.end,
                  
                  children: [



                    pw.Container(
                      width: 80,
                      height: 70,
                        decoration:  pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 1,), left:  pw.BorderSide(width: 1, ),top:  pw.BorderSide(width: 1, ),right:  pw.BorderSide(width: 1,),)),
                      
                      child: pw.Padding(padding:pw.EdgeInsets.only(
                        top: 15,right:10,
                        bottom:10, left: 10),child: pw.Center(child: pw.Text("Stamp Size Color Photograph", style:pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColor.fromInt(0x000000))))))
                ]),

            


            //  pw.SizedBox(height: 30,),


             
             pw.Table(
              
             columnWidths: {
            0: pw.FixedColumnWidth(200.0),
            1: pw.FlexColumnWidth(300),
           
          },
              
              children: [


                pw.TableRow(
                
                  children: [

               pw.Padding(
                
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("1. NAME (BLOCK LETTER)", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["CustomerName"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),


                



              pw.TableRow(
                  children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("2. FATHER'S NAME", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["CustomerFatherName"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),


                 



             pw.TableRow(
                  children: [

               
               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("3. MOTHER'S NAME", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["CustomerMotherName"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),


              
               



                  pw.TableRow(
                  children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("4. HUSBAND'S NAME", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["HusbandName"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),




                  



                  pw.TableRow(
                  children: [

              pw.Padding(
                 padding: pw.EdgeInsets.only(top: 6),
                child:  pw.Column(
                
                mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [

                pw.Text("5. PRESENT ADDRESS", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),
                pw.Text("(WITH SUPPORTING DOCUMENTS)", style:pw.TextStyle(fontSize: 8,  color: PdfColor.fromInt(0x000000))),

               ]),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["PresentAddress"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),


            

            



                  pw.TableRow(
                  children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("6. PERMANENT ADDRESS", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["PermanentAddress"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),


            

             



                  pw.TableRow(
                  children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("7. SEX", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["Sex"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),




                



                  pw.TableRow(
                  children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("8. CELL PHONE NO", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["CellPhoneNo"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),




               



                  pw.TableRow(
                  children: [

              pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child:  pw.Text("9. NATIONALITY", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),


               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["Nationality"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),




                 



                  pw.TableRow(
                  children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("10. DATE OF BIRTH", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

              pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["DateOfBirth"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),




                  



                  pw.TableRow(
                  children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("11. NID NO(WITH COPY)", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["NIDNo"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),



                



                  pw.TableRow(
                  children: [

               pw.Padding(
                
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("12. e-TIN NO(WITH COPY)", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

              pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["ETINNo"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),



                 



                  pw.TableRow(
                  children: [

              pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child:  pw.Column(
                
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [

                pw.Text("13. GUARDIAN'S NAME", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),
                pw.Text("(In case of Minor)", style:pw.TextStyle(fontSize: 8,  color: PdfColor.fromInt(0x000000))),

               ]),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["GuardianName"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),





                 



                  pw.TableRow(
                  children: [

               pw.Padding(
                
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Column(
                
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [

                pw.Text("14. VEHICLE REGISTRATION NO", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),
                pw.Text("(In case of Ownership transfer)", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),

               ]),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["VehicleRegistrationNo"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),




                



                  pw.TableRow(
                  children: [

              pw.Padding(
                 padding: pw.EdgeInsets.only(top: 6),
                child:  pw.Text("15. ENGINE NO", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["EngineNo"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),




                 



                  pw.TableRow(
                  children: [

                    pw.Padding(padding: pw.EdgeInsets.only(top: 6), child:  pw.Text("16. CHASSIS NO", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

              
               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["ChassisNo"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),


              
               



                  pw.TableRow(
                  children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("17. YEAR OF MFG of Vehicle", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["YearOfMFG"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),




                   



            pw.TableRow(
              children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [

                pw.Text("18. PREV. REGN. NO(If any)", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),
                pw.Text("(In case of Reconditioned vehicle/ Special Registration)", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),

               ]),),

              pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["PreviousReg"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),



                



                  pw.TableRow(
                  children: [

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text("19. BANK NAME of Fee/Tax deposit", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

               pw.Padding(
                padding: pw.EdgeInsets.only(top: 6),
                child: pw.Text(":${SalesData[0]["BankNameForFee"].toString().toUpperCase()}", style:pw.TextStyle(fontSize: 10,  color: PdfColor.fromInt(0x000000))),),

                ]),


             ]),



             pw.SizedBox(height: 10,),




             pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
              pw.Text("SPECIMEN SIGNATURE",style:pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, )),
             ]),



            pw.SizedBox(height: 20,),






            pw.Row(
              
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [

                pw.Row(

              mainAxisAlignment: pw.MainAxisAlignment.start,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
                  
                  children: [

                    pw.Text("1.  ", style:pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold,  color: PdfColor.fromInt(0x000000))),

                    // pw.SizedBox(width: 5),

                    pw.Container(
                      width: 150,
                      height: 30,
                        decoration:  pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 1,), left:  pw.BorderSide(width: 1, ),top:  pw.BorderSide(width: 1, ),right:  pw.BorderSide(width: 1,),)),
                      
                      child: pw.Padding(padding:pw.EdgeInsets.only(
                        top: 15,right:10,
                        bottom:10, left: 10),child: pw.Text("  ", style:pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColor.fromInt(0x000000)))))
                ]),




               pw.Row(

              mainAxisAlignment: pw.MainAxisAlignment.start,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
                  
                  children: [

                    pw.Text("2.  ", style:pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold,  color: PdfColor.fromInt(0x000000))),

                    // pw.SizedBox(width: 5),

                    pw.Container(
                      width: 150,
                      height: 30,
                        decoration:  pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 1,), left:  pw.BorderSide(width: 1, ),top:  pw.BorderSide(width: 1, ),right:  pw.BorderSide(width: 1,),)),
                      
                      child: pw.Padding(padding:pw.EdgeInsets.only(
                        top: 15,right:10,
                        bottom:10, left: 10),child: pw.Text("  ", style:pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColor.fromInt(0x000000)))))
                ]),


              ]),




 pw.SizedBox(height: 20,),






            pw.Row(
              
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [

                pw.Row(

              mainAxisAlignment: pw.MainAxisAlignment.start,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
                  
                  children: [

                    pw.Text("3.  ", style:pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold,  color: PdfColor.fromInt(0x000000))),

                    // pw.SizedBox(width: 5),

                    pw.Container(
                      width: 150,
                      height: 30,
                        decoration:  pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 1,), left:  pw.BorderSide(width: 1, ),top:  pw.BorderSide(width: 1, ),right:  pw.BorderSide(width: 1,),)),
                      
                      child: pw.Padding(padding:pw.EdgeInsets.only(
                        top: 15,right:10,
                        bottom:10, left: 10),child: pw.Text("  ", style:pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColor.fromInt(0x000000)))))
                ]),




               pw.Row(

              mainAxisAlignment: pw.MainAxisAlignment.start,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
              // crossAxisAlignment: pw.CrossAxisAlignment.start,
                  
                  children: [

                    pw.Text("4.  ", style:pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold,  color: PdfColor.fromInt(0x000000))),

                    // pw.SizedBox(width: 5),

                    pw.Container(
                      width: 150,
                      height: 30,
                        decoration:  pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 1,), left:  pw.BorderSide(width: 1, ),top:  pw.BorderSide(width: 1, ),right:  pw.BorderSide(width: 1,),)),
                      
                      child: pw.Padding(padding:pw.EdgeInsets.only(
                        top: 15,right:10,
                        bottom:10, left: 10),child: pw.Text("  ", style:pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: PdfColor.fromInt(0x000000)))))
                ]),


              ]),


          pw.SizedBox(height: 10),

          pw.Text("wet `«t miKvix/AvavmiKvix/ ¯^vqZ¡kvwmZ Ggb c«wZôvb hv‡`i GbAvBwW I wUb ‡bB, ‡mB c«wZôv‡bi ¶gZvc«vß e¨w³i GbAvBwW Gi Kwc `vwLj Ki‡Z n‡e Ges Zv‡K mswkøó Av‡e`bd‡g© I Dc‡ii N‡i ¯^v¶i Ki‡Z n‡e| ", style: pw.TextStyle(fontSize: 7, font: Banglattf))







        ])); // Center
      }));



return pdf.save();
}