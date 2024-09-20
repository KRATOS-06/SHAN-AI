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
      color: const Color(0xFF00B2B2),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
            ),
            backgroundColor: const Color(0xff00b2b2),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right:10),
                child: Image.asset(
                  'assets/gym_logo.png',
                  height: 50,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40, top:10),
                    child: const Align(
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
                      margin: const EdgeInsets.only(left: 180, top: 10),
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Image.asset('assets/fire.png'),
                              const Text(
                                "  Membership",
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ],
                          )))
                ]),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.png'),
                        radius: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          " Steeve Myles",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                        const Text(
                          "  Weight : 80Kg",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        const Text(
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
                            const Text(
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
                const Text(
                  "    Statistics",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const Text("         This week"),
                Container(
                  margin: const EdgeInsets.only(left: 10,right: 10),
                  height: 200,
                  width: 370,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(40.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        const Text.rich(
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
                        SizedBox(
                          height: 150,
                          width: 230,
                          child: BarChart(BarChartData(
                              borderData: FlBorderData(
                                  border: const Border(
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
                                          return const Text('Mon');
                                        case 2:
                                          return const Text('Tue');
                                        case 3:
                                          return const Text('Wed');
                                        case 4:
                                          return const Text('Thur');
                                        case 5:
                                          return const Text('Fri');
                                        case 6:
                                          return const Text('Sat');
                                        case 7:
                                          return const Text('Sun');
                                        default:
                                          return const Text('');
                                      }
                                    },
                                  ),
                                ),
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
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
                  margin: const EdgeInsets.only(top: 13),
                  child: const Text(
                    "      Activity",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
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
                              const Text(
                                "  Steps        ",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
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
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("2973"),
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
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "  Heart Rate ",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset('assets/heart.png'))
                            ]),
                            Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                width: 90,
                                height: 37,
                                child: Image.asset(
                                  'assets/heartrate.png',
                                  fit: BoxFit.cover,
                                )),
                            const Text(
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
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "  Distance   ",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                  width: 60,
                                  height: 33,
                                  child: Image.asset(
                                    'assets/telescope.png',
                                    fit: BoxFit.cover,
                                  ))
                            ]),
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0),
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
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
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
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0),
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
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
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
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0),
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
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "  BMI            ",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset('assets/weight.png'))
                            ]),
                            Container(
                                margin: const EdgeInsets.only(top: 10.0),
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
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
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
                                  margin: const EdgeInsets.only(top: 6.0),
                                  child: Image.asset(
                                    'assets/pressure.png',
                                    fit: BoxFit.cover,
                                  ))
                            ]),
                            const Row(
                              children: [
                                Text("  128     ",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                Text("  sys\nmmHg")
                              ],
                            ),
                            const Row(
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
                              const Text(
                                "  Active        ",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
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
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("18h 15 mins"),
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
                      const SizedBox(
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
