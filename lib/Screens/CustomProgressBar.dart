import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomProgressBar extends StatefulWidget {
  final double width;
  final Color leftColor;
  final Color rightColor;
final String  leftPercent;
  final String rightPercent;
  final String   leftSum;
  final String rightSum;
  CustomProgressBar({this.width, this.leftColor, this.rightColor, this.leftPercent,
    this.leftSum,this.rightPercent,this.rightSum});

  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: LinearPercentIndicator(
                  //leaner progress bar
                  padding: EdgeInsets.zero,
                  width: widget.width,
                  //width for progress bar
                  animation: false,
                  //animation to show progress at first
                  animationDuration: 100,
                  lineHeight: 18.0,
                  //height of progress bar
                  percent: double.parse(widget.leftPercent)/100,
                  // 30/100 = 0.3
                  linearStrokeCap: LinearStrokeCap.butt,
                  //make round cap at start and end both
                  progressColor: widget.leftColor,
                  //percentage progress bar color
                  backgroundColor: Color.fromARGB(
                      255, 216, 216, 216), //background progressbar color
                ),
              ),
              Container(
                child: LinearPercentIndicator(
                  isRTL: true,
                  padding: EdgeInsets.zero,
                  //leaner progress bar
                  width: widget.width,
                  //width for progress bar
                  animation: false,
                  //animation to show progress at first
                  animationDuration: 100,
                  lineHeight: 18.0,
                  //height of progress bar
                  percent: double.parse(widget.rightPercent)/100,
                  // 30/100 = 0.3
                  linearStrokeCap: LinearStrokeCap.butt,
                  //make round cap at start and end both
                  progressColor: widget.rightColor,
                  //percentage progress bar color
                  backgroundColor: Color.fromARGB(
                      0, 216, 216, 216), //background progressbar color
                ),
              ),
              Container(
                width: widget.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(color: Colors.black,height: 25,width: 2,)
                  ],
                ),
              )
            ],
          ),
          Container(
              // margin: EdgeInsets.only(top: 5),
              width: widget.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(widget.leftSum,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 7.0.sp,
                                fontWeight: FontWeight.w400))),
                  ),
                  Column(
                    children: [
                      Text(widget.rightSum,
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 7.0.sp,
                                  fontWeight: FontWeight.w400))),
                    ],
                  )
                ],
              ))
        ]));
  }
}
