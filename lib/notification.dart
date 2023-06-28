import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/Adminnoti.dart';
import 'package:helloworld/Home.dart';
import 'package:helloworld/My_orders.dart';
import 'MyProfile.dart';

class ClassNotify extends StatefulWidget {
  const ClassNotify({Key? key}) : super(key: key);

  @override
  State<ClassNotify> createState() => _ClassNotifyState();
}

class _ClassNotifyState extends State<ClassNotify> {
  int _selectedIndex = 0;
  int currentIndex = 0;
  int currentTab = 1;
  final List<Widget> screen =[
    HomePage(),
    ClassNotify(),
    Profile(),

  ];

  Widget currentScreen = ClassNotify();
  List _loaddata=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var res = await Api()
        .getData('/api/krishibhavanNotifications');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;

      });
    } else {
      setState(() {
        _loaddata = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Notification'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Container(
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0; // Set selected index to 0 for "Admin"
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminNotify()));
                    },
                    child: Text(
                      'Admin',
                      style: TextStyle(
                        color: _selectedIndex == 0 ? Colors.green : Colors.white,
                        fontWeight: _selectedIndex == 0 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1; // Set selected index to 1 for "Krishibhavan"
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ClassNotify()));
                    },
                    child: Text(
                      'Krishibhavan',
                      style: TextStyle(
                        color: _selectedIndex == 1 ? Colors.green : Colors.white,
                        fontWeight: _selectedIndex == 1 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  // currentIndex: _selectedIndex,
                  // selectedItemColor: Colors.amber[800],
                  // onTap: _onItemTapped,
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                onTap: () {
                  setState(() {
                    currentScreen = HomePage();
                    currentTab = 0;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Icon(Icons.home_outlined,size: 30,color: currentTab==0 ? Colors.green : Colors.black,),
                    /*  new Image.asset('icon/home.png',
                    height: 35,
                    width: 55,
                  ),
                 */
                    Text('Home',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==0 ? Colors.green : Colors.black),)
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    currentScreen=ClassNotify();
                    currentTab = 1;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ClassNotify()));

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // new Image.asset('icon/notification.png',
                    //   height: 40,
                    //   width: 60,
                    // ),
                    Icon(Icons.notifications_outlined,size: 30,color: currentTab==1 ? Colors.green : Colors.black),
                    Text('Notification',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==1 ? Colors.green : Colors.black),)
                  ],
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       currentScreen=My_Orders();
              //       currentTab = 2;
              //     });
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>My_Orders()));
              //   },
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       // new Image.asset('icon/user.png',
              //       //   height: 35,
              //       //   width: 55,
              //       // ),
              //       Icon(Icons.shopping_cart_outlined,size: 30,color: currentTab==2 ? Colors.green : Colors.black),
              //       Text('My Orders',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==2 ? Colors.green : Colors.black),)
              //     ],
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentScreen=Profile();
                    currentTab = 3;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // new Image.asset('icon/user.png',
                    //   height: 35,
                    //   width: 55,
                    // ),
                    Icon(Icons.person_outline_outlined,size: 30,color: currentTab==3 ? Colors.green : Colors.black),
                    Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,color: currentTab==3 ? Colors.green : Colors.black),)
                  ],
                ),
              ),
            ],
          ),
        ),
        // appBar: AppBar(
        //   backgroundColor: Colors.green,
        //   title: Text('Notifications',),
        //
        // ),

        body: ListView.builder(
          shrinkWrap: true,
          itemCount: _loaddata.length,
          itemBuilder: (context,index){

            return Padding(
              padding: const EdgeInsets.only(top: 16,right: 12,left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.notifications_outlined,color: Colors.green,size: 36,),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(_loaddata[index]['notification'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                          ],
                        ),
                      ),
                      SizedBox(width: 14,),

                      Text(_loaddata[index]['date'],style: TextStyle(fontSize: 15))
                    ],
                  ),
                  SizedBox(height: 12,),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  )
                ],
              ),
            );
          },


        )


    );
  }
}
