import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/Home.dart';
import 'package:helloworld/My_orders.dart';
import 'package:helloworld/Welcome.dart';
import 'package:helloworld/notification.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool isObscurePassword=true;
  late int user;
  String name='';
  String age='';
  String email='';
  String phone_number='';
  String address='';
  String gender='';
  String username='';
  String password='';
  String image='';
  late SharedPreferences prefs;
  TextEditingController nameController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phnController=TextEditingController();
  TextEditingController addController=TextEditingController();
  TextEditingController unameController=TextEditingController();
  TextEditingController pwdController=TextEditingController();

  final List<Widget> screen =[
    HomePage(),
    ClassNotify(),
    My_Orders(),
    Profile(),
  ];
  int currentTab = 3;




  @override
  void initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    user = (prefs.getInt('user') ?? 0);
    print('update profile $user');
    var res = await Api().getData('/api/singleuser/'+user.toString());
    var body = json.decode(res.body);
    print(body);

    setState(() {
      name = body['data']['name']; // Assuming the API response has 'name' field
      age = body['data']['age'];
      email = body['data']['email'];
      phone_number = body['data']['phone_number'];
      address = body['data']['address'];
      image = body['data']['image'];

      nameController.text = name;
      ageController.text = age;
      emailController.text = email;
      phnController.text = phone_number;
      addController.text = address;
      gender = gender;
    });
  }


  File? imageFile;
  late  final _filename;
  late  final bytes;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {

                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(height:10),
                  const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                      //   _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // Future<void> _update(
  //     int user,
  //     String name,
  //     String age,
  //     String email,
  //     String phone_number,
  //     String address,
  //     String gender,
  //     String image) async {
  //   prefs = await SharedPreferences.getInstance();
  //   user = (prefs.getInt('user') ?? 0);
  //   String id = user.toString();
  //
  //   var data = {
  //     'name': name,
  //     'age': age,
  //     'email': email,
  //     'phone_number': phone_number,
  //     'address': address,
  //     'gender': gender,
  //     'image': image,
  //   };
  //
  //   var res = await Api().putData('/api/$id/updateuser', data);
  //   if (res.statusCode == 200) {
  //     print('Profile updated successfully');
  //     Navigator.push(
  //         this.context, MaterialPageRoute(builder: (context) => HomePage()));
  //   } else {
  //     print('Error updating profile. Status code: ${res.statusCode}');
  //   }
  // }

  Future<void> _update(int user,String name,String email,String address,String contact,String image) async {

    prefs = await SharedPreferences.getInstance();
    user = (prefs.getInt('user') ?? 0 );
    String id=user.toString();

    var uri = Uri.parse(Api().url+'/api/updateuser/${id}'); // Replace with your API endpoint

    var request = http.MultipartRequest('PUT', uri);

    request.fields['user'] = user.toString();
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['address']=address;
    request.fields['phone_number'] = contact;
    request.fields['image'] = image;

    print(request.fields);

    final imageStream = http.ByteStream(imageFile!.openRead());
    final imageLength = await imageFile!.length();

    final multipartFile = await http.MultipartFile(
      'image',imageStream,imageLength,
      filename: _filename ,
      // contentType: MediaType('image', 'jpeg'), // Replace with your desired image type
    );
    request.files.add(multipartFile);

    final response = await request.send();
    print(response);

    if (response.statusCode == 200) {
      print('Profile Updated successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print('Error Updating profile. Status code: ${response.statusCode}');
    }
  }


  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(()  {

        imageFile = File(pickedFile.path);
        _filename = basename(imageFile!.path);
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
        print("imageFile:${imageFile}");
        print(_filename);
        print(_nameWithoutExtension);
        print(_extenion);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        //  _filename = basename(imageFile!.path).toString();
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);
      });
    }
  }


  Widget currentScreen = Profile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            GestureDetector(
              onTap: () {
                setState(() {
                  currentScreen = const HomePage();
                  currentTab = 0;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
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
            //
            //   },
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       // new Image.asset('icon/notification.png',
            //       //   height: 40,
            //       // ),
            //       //   width: 60,
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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Profile"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcome()));
            },
            icon: Icon(
              Icons.logout,
              size: 28,
            ),
          )
        ],
      ),

      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    SizedBox(height: 10,),
                    imageFile == null?Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          color: Colors.green,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1)
                            )
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                Api().url+ image,
                              )
                          )
                      ),

                    ):Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            shape: BoxShape.circle,
                            image : DecorationImage(
                                image : FileImage(imageFile!),
                                fit: BoxFit.fill
                            ))

                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1,
                                  color: Colors.white
                              ),
                              color: Colors.green
                          ),
                          child: IconButton(
                              onPressed: (){
                                _showChoiceDialog(context);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              )
                          )
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: 60,),

              buildTextField("name",nameController),
              buildTextField("email", emailController),
              buildTextField("address",addController),
              buildTextField("phone_number",phnController),
             // buildTextField("username",unameController),


              SizedBox(height: 70,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    },
                    child: Text("CANCEL",style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black
                    )),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),

                  ElevatedButton(
                    onPressed: (){
                      _update(user,nameController.text,emailController.text,addController.text,phnController.text,_filename);
                    },
                    child: Text("EDIT",style: TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }

  Widget buildTextField(String labelText,TextEditingController controller){
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        //obscureText: isPasswordTextField ? isObscurePassword: false,
        decoration: InputDecoration(

          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 18,color: Colors.green),
          floatingLabelBehavior: FloatingLabelBehavior.always,


        ),
      ),
    );
  }
}
