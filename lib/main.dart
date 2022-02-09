// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables,

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: "Timer - Cronometro",
    home: TimerCronometro(),
  ));
}

// ignore: slash_for_doc_comments
/**
 * Class TimerCronometro 
 * Stateful widget
 */

class TimerCronometro extends StatefulWidget {
  const TimerCronometro({Key? key}) : super(key: key);

  @override
  TimerCronometroState createState() => TimerCronometroState();
}

// ignore: slash_for_doc_comments
/**
 * Class TimerCronometroState
 * State TimerCronometro class
 * 
 * The app has 2 sections managed with the BottomNavigationBar widget: 
 *  -Timer
 *  -Chronometer
 * 
 * Timer is based on seconds, minutes and hours which can be incresed/decresed by the user
 * Time can be started, paused or stopped with the 3 dedicated buttons.
 */

class TimerCronometroState extends State<TimerCronometro> {
  int selectedIndex = 0;

  //timer variables
  int secondsTimer = 0;
  int minutesTimer = 0;
  int hoursTimer = 0;

  //timer strean variables
  bool streamIsGoing = false;
  bool streamIsPaused = false;
  bool streamIsStopped = false;
  bool buttonsClickables = true;

  // timer stream
  late Stream<int> streamTimer;

  //chrono variables
  int secondsChrono = 0;
  int minutesChrono = 0;
  int hoursChrono = 0;

  //chrono states
  bool chronoIsGoing = false;
  bool chronoIsPaused = false;
  bool chronoIsStopped = false;

  //chrono stream;
  late Stream<int> streamChrono;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Timer - Cronometro'),
        ),

        body: Center(
          child: content(),
        ),

        //widget bottom bar
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timelapse_rounded),
              label: 'Cronometro',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.red,
          onTap: onItemTapped,
        ),
      ),
    );
  }

  // ignore: slash_for_doc_comments
  /**
   * The main content function
   * Contains the timer and the chronometer
   * Will be displayed the content based on selectedIndex variable
   * To change the content use the bottom navigation bar
   */
  Column content() {
    Column content;

    TextStyle buttonsTextStyle = TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.grey[50]);

    TextStyle variablesStyle =
        TextStyle(fontSize: 50, fontWeight: FontWeight.bold);

    //timer content
    if (selectedIndex == 0) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        hoursTimer++;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      color: buttonsClickables ? Colors.red : Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 10, left: 20, top: 10),
                        child: Text(
                          '+',
                          style: buttonsTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        normalize(hoursTimer),
                        style: variablesStyle,
                      ),
                      Text('hours')
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (buttonsClickables) {
                        setState(() {
                          hoursTimer > 0 ? hoursTimer-- : hoursTimer;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      color: buttonsClickables ? Colors.red : Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 10, left: 20, top: 10),
                        child: Text(
                          '-',
                          style: buttonsTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (buttonsClickables) {
                        setState(() {
                          if (minutesTimer == 59) {
                            hoursTimer++;
                            minutesTimer = 0;
                          } else {
                            minutesTimer++;
                          }
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      color: buttonsClickables ? Colors.red : Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 10, left: 20, top: 10),
                        child: Text(
                          '+',
                          style: buttonsTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        normalize(minutesTimer),
                        style: variablesStyle,
                      ),
                      Text('minutes')
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (buttonsClickables) {
                        setState(() {
                          if (minutesTimer == 59) {
                            hoursTimer++;
                            minutesTimer = 0;
                          } else {
                            minutesTimer--;
                          }
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      color: buttonsClickables ? Colors.red : Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 10, left: 20, top: 10),
                        child: Text(
                          '-',
                          style: buttonsTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (buttonsClickables) {
                        setState(() {
                          if (secondsTimer == 59) {
                            secondsTimer = 0;
                            minutesTimer++;
                          } else {
                            secondsTimer++;
                          }
                          if (minutesTimer == 60) {
                            hoursTimer++;
                            minutesTimer = 0;
                          }
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      color: buttonsClickables ? Colors.red : Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 10, left: 20, top: 10),
                        child: Text(
                          '+',
                          style: buttonsTextStyle,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        normalize(secondsTimer),
                        style: variablesStyle,
                      ),
                      Text('seconds')
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (buttonsClickables) {
                        setState(() {
                          if (secondsTimer == 0 && minutesTimer > 0) {
                            minutesTimer--;
                            secondsTimer = 60;
                          }
                          if (secondsTimer != 0) secondsTimer--;
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      color: buttonsClickables ? Colors.red : Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 20, bottom: 10, left: 20, top: 10),
                        child: Text(
                          '-',
                          style: buttonsTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //play button
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    streamIsGoing ? Colors.green[600] : Colors.grey[50],
                child: IconButton(
                    color: streamIsGoing ? Colors.grey[50] : Colors.black,
                    iconSize: 40,
                    onPressed: () {
                      startCounter();
                    },
                    icon: Icon(Icons.play_arrow)),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    streamIsPaused ? Colors.yellow[600] : Colors.grey[50],
                child: IconButton(
                    color: streamIsPaused ? Colors.grey[50] : Colors.black,
                    iconSize: 40,
                    onPressed: () {
                      pauseCounter();
                    },
                    icon: Icon(
                      Icons.pause,
                    )),
              ),
              //stop icon
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    streamIsStopped ? Colors.redAccent : Colors.grey[50],
                child: IconButton(
                    color: streamIsStopped ? Colors.grey[50] : Colors.black,
                    iconSize: 40,
                    onPressed: () {
                      stopCounter();
                    },
                    icon: Icon(Icons.stop)),
              ),
            ],
          ),
        ],
      );
    } else {
      //Chronometer content
      content = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    normalize(hoursChrono),
                    style: variablesStyle,
                  ),
                  Text('hours'),
                ],
              ),
              Column(
                children: [
                  Text(
                    normalize(minutesChrono),
                    style: variablesStyle,
                  ),
                  Text('minutes'),
                ],
              ),
              Column(
                children: [
                  Text(
                    normalize(secondsChrono),
                    style: variablesStyle,
                  ),
                  Text('seconds'),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //play button chrono
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    chronoIsGoing ? Colors.green[600] : Colors.grey[50],
                child: IconButton(
                    color: chronoIsGoing ? Colors.grey[50] : Colors.black,
                    iconSize: 40,
                    onPressed: () {
                      setState(() {
                        chronoIsGoing = true;
                        chronoIsPaused = false;
                        chronoIsStopped = false;

                        streamChrono = chrono(Duration(seconds: 1));
                        streamChrono.listen((event) {
                          setState(() {
                            secondsChrono++;
                            if (secondsChrono == 60) {
                              minutesChrono++;
                              secondsChrono = 0;
                            }
                            if (minutesChrono == 60) {
                              hoursChrono++;
                              minutesChrono = 0;
                            }
                          });
                        });
                      });
                    },
                    icon: Icon(Icons.play_arrow)),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    chronoIsPaused ? Colors.yellow[600] : Colors.grey[50],
                child: IconButton(
                    color: chronoIsPaused ? Colors.grey[50] : Colors.black,
                    iconSize: 40,
                    onPressed: () {
                      setState(() {
                        chronoIsPaused = !chronoIsPaused;
                      });
                    },
                    icon: Icon(
                      Icons.pause,
                    )),
              ),
              //stop icon
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    chronoIsStopped ? Colors.redAccent : Colors.grey[50],
                child: IconButton(
                    color: chronoIsStopped ? Colors.grey[50] : Colors.black,
                    iconSize: 40,
                    onPressed: () {
                      chronoIsGoing = false;
                      chronoIsPaused = false;
                      chronoIsStopped = true;
                      secondsChrono = 0;
                      minutesChrono = 0;
                      hoursChrono = 0;
                    },
                    icon: Icon(Icons.stop)),
              ),
            ],
          ),
        ],
      );
    }

    return content;
  }

  //change "slide"
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  String normalize(int n) {
    String str = '';

    if (n < 0) {
      n = 0;
    }
    if (n < 10) {
      str = '0' + n.toString();
    } else {
      str = n.toString();
    }
    return str;
  }

  //stream function for the timer
  Stream<int> timer(Duration interval, int maxCount) async* {
    int i = 0;
    while (streamIsGoing && streamIsStopped == false) {
      await Future.delayed(interval);
      if (streamIsPaused == false) {
        yield i++;
      }
      if (i == (maxCount)) {
        setState(() {
          streamIsGoing = false;
        });
        break;
      }
    }
  }

  //stream function for the chronometer
  Stream<int> chrono(Duration interval) async* {
    int i = 0;
    while (chronoIsGoing && chronoIsStopped == false) {
      await Future.delayed(interval);
      if (chronoIsPaused == false) {
        yield i++;
      }
      if (chronoIsStopped) {
        setState(() {
          secondsChrono = 0;
        });
        break;
      }
    }
  }

  //function that start the counter
  //starts the stream
  //update variables
  void startCounter() {
    if (secondsTimer != 0 || minutesTimer != 0 || hoursTimer != 0) {
      setState(() {
        streamIsGoing = true;
        streamIsStopped = false;
        streamIsPaused = false;
        buttonsClickables = false;
        streamTimer = timer(Duration(seconds: 1),
            secondsTimer + (60 * minutesTimer) + (3600 * hoursTimer));
      });
      streamTimer.listen((event) {
        setState(() {
          if (secondsTimer == 0 && (minutesTimer > 0 || hoursTimer > 0)) {
            if (minutesTimer == 0 && hoursTimer > 0) {
              hoursTimer--;
              minutesTimer = 60;
            }
            minutesTimer--;
            secondsTimer = 60;
          }
          secondsTimer--;
        });
      });
    }
  }

  //function that pause the counter
  void pauseCounter() {
    setState(() {
      streamIsPaused = !streamIsPaused;
      if (streamIsPaused == false) streamIsGoing = true;
    });
  }

  //function that stop timer counter and reset all variables
  void stopCounter() {
    setState(() {
      buttonsClickables = true;
      streamIsGoing = false;
      streamIsStopped = true;
      streamIsPaused = false;
      secondsTimer = 0;
      minutesTimer = 0;
      hoursTimer = 0;
    });
  }
}
