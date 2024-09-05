import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF00B2B2),
      /*decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xffffF7FBFB), Color(0xffffbee2eb), Color(0xffffaedeeb)
          // Colors.black54, Colors.red
        ],
      )),*/
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    //padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(top: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/gym_logo.png',
                        height: 70.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40, top: 50),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'DMSerifText',
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 180, top: 80),
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Image.asset('assets/fire.png'),
                              Text(
                                "  Membership",
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ],
                          )))
                ]),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.png'),
                        radius: 70,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " Steeve Myles",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                        Text(
                          "  Weight : 80Kg",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Text(
                          "  Height : 120cm",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/smile.png',
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              "Intermediate    360hrs",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Text(
                  "    Statistics",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text("         This week"),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 200,
                  width: 390,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(40.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "  Calories \n",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: "170,5 Kcal \n"),
                              TextSpan(
                                text: "    Time \n",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: " 02:06:30 "),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          width: 250,
                          child: BarChart(BarChartData(
                              borderData: FlBorderData(
                                  border: Border(
                                      top: BorderSide.none,
                                      right: BorderSide.none,
                                      left: BorderSide.none,
                                      bottom: BorderSide.none)),
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      switch (value.toInt()) {
                                        case 1:
                                          return Text('Mon');
                                        case 2:
                                          return Text('Tue');
                                        case 3:
                                          return Text('Wed');
                                        case 4:
                                          return Text('Thur');
                                        case 5:
                                          return Text('Fri');
                                        case 6:
                                          return Text('Sat');
                                        case 7:
                                          return Text('Sun');
                                        default:
                                          return Text('');
                                      }
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              barGroups: [
                                BarChartGroupData(x: 1, barRods: [
                                  BarChartRodData(
                                      fromY: 0,
                                      toY: 10,
                                      width: 10,
                                      color: Colors.blue)
                                ]),
                                BarChartGroupData(x: 2, barRods: [
                                  BarChartRodData(
                                      fromY: 0,
                                      toY: 6,
                                      width: 10,
                                      color: Colors.blue)
                                ]),
                                BarChartGroupData(x: 3, barRods: [
                                  BarChartRodData(
                                      fromY: 0,
                                      toY: 8,
                                      width: 10,
                                      color: Colors.blue)
                                ]),
                                BarChartGroupData(x: 4, barRods: [
                                  BarChartRodData(
                                      fromY: 0,
                                      toY: 9,
                                      width: 10,
                                      color: Colors.blue)
                                ]),
                                BarChartGroupData(x: 5, barRods: [
                                  BarChartRodData(
                                      fromY: 0,
                                      toY: 3,
                                      width: 10,
                                      color: Colors.blue)
                                ]),
                                BarChartGroupData(x: 6, barRods: [
                                  BarChartRodData(
                                      fromY: 0,
                                      toY: 10,
                                      width: 10,
                                      color: Colors.blue)
                                ]),
                                BarChartGroupData(x: 7, barRods: [
                                  BarChartRodData(
                                      fromY: 0,
                                      toY: 10,
                                      width: 10,
                                      color: Colors.blue)
                                ])
                              ])),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 13),
                  child: Text(
                    "      Activity",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.0)),
                        width: 185,
                        height: 140,
                        child: Column(children: [
                          Row(
                            children: [
                              Text(
                                "  Steps        ",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('assets/steps.png')),
                            ],
                          ),
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red,
                                  Colors.redAccent.withOpacity(0.4)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 65.0,
                                height: 65.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("2973"),
                                    Image.asset(
                                      'assets/foot.png',
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                      Container(
                        width: 185,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "  Heart Rate ",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset('assets/heart.png'))
                            ]),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                width: 90,
                                height: 37,
                                child: Image.asset(
                                  'assets/heartrate.png',
                                  fit: BoxFit.cover,
                                )),
                            Text(
                              "120/80 mmHg",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 185,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "  Distance   ",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: 60,
                                  height: 33,
                                  child: Image.asset(
                                    'assets/telescope.png',
                                    fit: BoxFit.cover,
                                  ))
                            ]),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                "6.9 Km/H",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 185,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "  Sleep          ",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  // width: 60,
                                  //height: 20,
                                  child: Image.asset(
                                'assets/sleep.png',
                                fit: BoxFit.cover,
                              ))
                            ]),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                "5h 45 mins",
                                style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 185,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  " Water Intake",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  // width: 60,
                                  //height: 20,
                                  child: Image.asset(
                                'assets/water.png',
                                fit: BoxFit.cover,
                              ))
                            ]),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                "40.03 oz",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 185,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "  BMI            ",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset('assets/weight.png'))
                            ]),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                width: 90,
                                height: 65,
                                child: Image.asset(
                                  'assets/weight2.png',
                                  fit: BoxFit.cover,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        width: 185,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.0)),
                        child: Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  " Blood Pressure ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  // width: 60,
                                  //height: 20,
                                  margin: EdgeInsets.only(top: 6.0),
                                  child: Image.asset(
                                    'assets/pressure.png',
                                    fit: BoxFit.cover,
                                  ))
                            ]),
                            Row(
                              children: [
                                Text("  128     ",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                Text("  sys\nmmHg")
                              ],
                            ),
                            Row(
                              children: [
                                Text("   65      ",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                Text("  Dia\nmmHg")
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.0)),
                        width: 185,
                        height: 140,
                        child: Column(children: [
                          Row(
                            children: [
                              Text(
                                "  Active        ",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  height: 40,
                                  width: 50,
                                  child: Image.asset('assets/active1.png')),
                            ],
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple,
                                  Colors.purpleAccent.withOpacity(0.4)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("18h 15 mins"),
                                    Image.asset(
                                      'assets/active2.png',
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                        width: 40,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
