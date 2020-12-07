import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/CustomProgressBar.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TVRoomScreen extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  final Map data;

  TVRoomScreen({Key key, this.data}) : super(key: key);

  @override
  TVRoomState createState() => TVRoomState();
}

class TVRoomState extends State<TVRoomScreen> {
  Map results = Map();

  Column _buildBottomRowColumn(
      int initval, String topLabel, String bottomLabel) {
    List results = widget.data["data"];
    String sum1 = "0";
    String sum2 = "0";
    String perc1 = "0.0";
    String perc2 = "0.0";
    if (results.length != 0) {
      sum1 = results[initval]["sum"];
      sum2 = results[initval + 1]["sum"];
      if (initval + 1 < results.length) {
        perc1 = results[initval]["percent"];
        perc2 = results[initval + 1]["percent"];
      }
    }
    TextStyle style = TextStyle(
        fontSize: 15,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.w700,
        color: Colors.black);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Text(topLabel + " - $sum1($perc1%)", style: style),
        ),
        // if (bottomLabel.isNotEmpty)
        Text(bottomLabel + " - $sum2($perc2%)", style: style)
      ],
    );
  }

  Column _buildMidRowColumn(DateTime now) {
    String formattedDate = DateFormat('EEEE d MMM yyyy').format(now);
    String formattedTime = DateFormat.jm().format(now);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40.0.w,
          child: Image.asset(
            'assets/images/e_results.png',
            fit: BoxFit.contain,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 7.0.h, bottom: 7.0.h),
          width: 40.0.w,
          child: Image.asset(
            'assets/images/ghdecideslogo.png',
            fit: BoxFit.contain,
          ),
        ),
        Container(
          height: 8.5.h,
          width: 36.0.w,
          padding: EdgeInsets.only(top: 5, left: 8, right: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(
                Radius.circular(24.0) //         <--- border radius here
                ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Text('LAST UPDATE',
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 8.0.sp,
                            fontWeight: FontWeight.w400))),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(formattedDate,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 8.0.sp,
                              fontWeight: FontWeight.w400))),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(formattedTime,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 234, 2, 1),
                            fontSize: 10.0.sp,
                            fontWeight: FontWeight.w400))),
              )
            ],
          ),
        )
      ],
    );
  }

  Column _buildLeftSideRowColumn() {
    List results = widget.data["data"];
    String perc = "0.0";
    if (results.length != 0) {
      perc = results[0]["percent"];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Image.asset(
            'assets/images/nana_top.png',
            fit: BoxFit.contain,
          ),
        ),
        Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(left: 95, top: 7),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Nana Addo',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 9.0.sp,
                              fontWeight: FontWeight.w200))),
                  Text('Dankwa Akufo-Addo',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 9.0.sp,
                              fontWeight: FontWeight.w500))),
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    child: Text('Flag-bearer for the',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 8.0.sp,
                                fontWeight: FontWeight.w200))),
                  ),
                  Text('NEW PATRIOTIC PARTY',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 5.5.sp,
                              fontWeight: FontWeight.w400))),
                  Container(
                    margin: EdgeInsets.only(top: 6, bottom: 2),
                    child: Image.asset(
                      'assets/images/rectangle.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    child: Text('$perc%',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 26.0.sp,
                                fontWeight: FontWeight.w700))),
                  )
                ],
              ),
            )),
      ],
    );
  }

  Column _buildRightSideRowColumn() {
    List results = widget.data["data"];
    String perc = "0.0";
    if (results.length != 0) {
      perc = results[1]["percent"];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Image.asset(
            'assets/images/mahama_top.png',
            fit: BoxFit.contain,
          ),
        ),
        Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(right: 110, top: 7),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('John Dramani',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 9.0.sp,
                              fontWeight: FontWeight.w200))),
                  Text('Mahama',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 9.0.sp,
                              fontWeight: FontWeight.w500))),
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    child: Text('Flag-bearer for the',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 8.0.sp,
                                fontWeight: FontWeight.w200))),
                  ),
                  Text('NATIONAL DEMOCRATIC CONGRESS',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 5.5.sp,
                              fontWeight: FontWeight.w400))),
                  Container(
                    margin: EdgeInsets.only(top: 6, bottom: 2),
                    child: Image.asset(
                      'assets/images/rectangle_r.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0),
                    child: Text('$perc%',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 26.0.sp,
                                fontWeight: FontWeight.w700))),
                  )
                ],
              ),
            )),
      ],
    );
  }

  // DateTime now = DateTime.now().toUtc();
  //
  // void updateTime(){
  //   setState(() {
  //     now = DateTime.now().toUtc();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //MediaQueryData queryData;
    //queryData = MediaQuery.of(context);
    //Size size = queryData.size;
    DateTime now = DateTime.now().toUtc();
    // updateTime();
    List results = widget.data["data"];
    String perc1 = "0.0";
    String perc2 = "0.0";
    String sum1 = "0";
    String sum2 = "0";
    if (results.length != 0) {
      perc1 = results[0]["percent"];
      perc2 = results[1]["percent"];
      sum1 = results[0]["sum"];
      sum2 = results[1]["sum"];
    }
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                    child: Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(child: _buildLeftSideRowColumn()),
                  Expanded(child: _buildMidRowColumn(now)),
                  Expanded(child: _buildRightSideRowColumn()),
                ],
              ),
              Positioned(
                  top: 19.0.h,
                  left: 53.0.w,
                  child: Container(
                    height: 6.0.h,
                    child: Image.asset(
                      'assets/images/npp_logo.png',
                      fit: BoxFit.contain,
                    ),
                  )),
              Positioned(
                  top: 19.0.h,
                  right: 53.0.w,
                  child: Container(
                    height: 6.0.h,
                    child: Image.asset(
                      'assets/images/ndc_logo.png',
                      fit: BoxFit.contain,
                    ),
                  )),
              Positioned(
                  top: 41.0.h,
                  left: 30.0.w,
                  child: CustomProgressBar(
                      width: 620.0,
                      leftColor: Color.fromARGB(255, 10, 76, 211),
                      rightColor: Color.fromARGB(255, 32, 175, 52),
                      leftPercent: perc1,
                      rightPercent: perc2,
                      leftSum: sum1,
                      rightSum: sum2))
            ]))),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black, width: 1.0))),
              height: 9.0.h,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildBottomRowColumn(2, 'GUM', 'CPP'),
                    _buildBottomRowColumn(4, 'GFP', 'GCPP'),
                    _buildBottomRowColumn(6, 'APC', 'LPG'),
                    _buildBottomRowColumn(8, 'PNC', 'PPP'),
                    _buildBottomRowColumn(10, 'NDP', 'INDPT')
                  ]),
            )
          ],
        ));
  }
}
