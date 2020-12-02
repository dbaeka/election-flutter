import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/SingleResultDetails.dart';
import 'package:flutter_auth/controllers/my-functions.dart';

class EngineScreen extends StatefulWidget {
  // receive data from the FirstScreen as a parameter
  EngineScreen() : super();

  @override
  EngineScreenState createState() => EngineScreenState();
}

class EngineScreenState extends State<EngineScreen> {
  String id;
  String iniData;
  //bool isLoading = true;
  Map allStations;
  Map allApproved;
  Map allPendings;
  Map allResults;
  Map allNew;

  @override
  void initState() {
    super.initState();
    _loadAllNew();
  }

  void _loadAllNew() async {
    String feedback = await MyFunctions.getAllNew();

    setState(() {
      allNew = jsonDecode(feedback);
       print(allNew["data"].length);
    });
  }

  void _loadAllApproved() async {
    //String results = await MyFunctions.getAllResults();
    String feedback = await MyFunctions.getAllApproved();

    //print(feedback);

    setState(() {
      allApproved = jsonDecode(feedback);
    });
  }

  void _loadPendings() async {
    String data = await MyFunctions.getPendings();

    setState(() {
      allPendings = jsonDecode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person_outlined), text: 'NEW'),
                  Tab(icon: Icon(Icons.pending_actions), text: 'APPROVED'),
                  Tab(icon: Icon(Icons.pending_actions), text: 'PENDING'),
                ],
                onTap: (index) async {
                  try {
                    if (index == 0) {
                      setState(() {
                        allNew = null;
                      });

                      _loadAllNew();
                    }

                    if (index == 1) {
                      setState(() {
                        allApproved = null;
                      });

                      _loadAllApproved();
                    }

                    if (index == 2) {
                      setState(() {
                        //allPendings = null;
                      });
                      _loadPendings();
                    }
                    //toast(index.toString());
                  } catch (e) {}
                }),
            title: Text('Engine Room'),
          ),
          body: TabBarView(
            children: [
              (allNew == null)
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      child: (allNew["data"].length < 1)
                          ? Container(
                              child: Center(
                                  child: Text("No new result available")))
                          : ListView(
                              children: [
                               
                                for (var i = 0; i < allNew["data"].length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      String id = allNew["data"][i]
                                              ["attributes"]["recent_result"]
                                          .toString();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return AdminViewDetails(
                                                id: id //allStations["data"][i]["attributes"]["name"]
                                                );
                                          },
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                       leading: Text(allNew["data"][i]
                                      ["attributes"]["code"]),
                                      title: Text(allNew["data"][i]
                                          ["attributes"]["name"]),
                                      subtitle: Text(
                                          "NPP:" +
                                              allNew["data"][i]["attributes"]
                                                      ["records"]["1"]
                                                  .toString() +
                                              ",NDC: " +
                                              allNew["data"][i]["attributes"]
                                                      ["records"]["2"]
                                                  .toString() +
                                              ", Others: " +
                                              allNew["data"][i]["attributes"]
                                                      ["records"]["3"]
                                                  .toString(),
                                          style: TextStyle(fontSize: 12)),
                                      trailing: Text("view",
                                          style: TextStyle(
                                              color: Colors.grey[500])),
                                    ),
                                  ),
                              ],
                            )),
              Container(
                  child: (allApproved == null)
                      ? Container(
                          margin: EdgeInsets.all(30),
                          child: Center(child: CircularProgressIndicator()))
                      : Container(
                        child: (allApproved["data"].length < 1)
                        ? Container() 
                        : ListView(
                            children: [
                              for (var i = 0; i < allApproved["data"].length; i++)
                                GestureDetector(
                                  onTap: () {
                                    //print("Hello");

                                    String id = allApproved["data"][i]
                                            ["attributes"]["recent_result"]
                                        .toString();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return AdminViewDetails(
                                              id: id //allStations["data"][i]["attributes"]["name"]
                                              );
                                        },
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Text(allApproved["data"][i]
                                        ["attributes"]["code"]),
                                    title: Text(allApproved["data"][i]
                                        ["attributes"]["name"]),
                                    subtitle: Text(
                                        "NPP:" +
                                            allApproved["data"][i]["attributes"]
                                                    ["records"]["1"]
                                                .toString() +
                                            ",NDC: " +
                                            allApproved["data"][i]["attributes"]
                                                    ["records"]["2"]
                                                .toString() +
                                            ", Others: " +
                                            allApproved["data"][i]["attributes"]
                                                    ["records"]["3"]
                                                .toString(),
                                        style: TextStyle(fontSize: 12)),
                                    trailing: Text("view",
                                        style:
                                            TextStyle(color: Colors.grey[500])),
                                  ),
                                ),
                            ],
                          ),
                      )),
              Container(
                  child: (allPendings == null)
                      ? Container(
                          margin: EdgeInsets.all(30),
                          child: Center(child: CircularProgressIndicator()))
                      : ListView(
                          children: [
                            for (var i = 0; i < allPendings["data"].length; i++)
                              ListTile(
                                leading: Text(allPendings["data"][i]["attributes"]
                                    ["code"]),
                                title: Text(allPendings["data"][i]["attributes"]
                                    ["name"]),
                              )
                          ],
                        )
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
