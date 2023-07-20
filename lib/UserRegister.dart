import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passwordVisible1=false;
  bool passwordVisible2=false;
  TextEditingController nameController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phnController=TextEditingController();
  TextEditingController addController=TextEditingController();
  TextEditingController pwdController=TextEditingController();
  TextEditingController unameController=TextEditingController();


  bool _isLoading=false;
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "name": nameController.text.trim(),
      "username": unameController.text.trim(),
      "password": pwdController.text.trim(),
      "age": ageController.text.trim(),
      "address": addController.text,
      "gender": gender,
      "email": emailController.text.trim(),
      "phone_number": phnController.text.trim(),
    };

    print("User data${data}");
    var res = await Api().authData(data,'/api/user_register');
    var body = json.decode(res.body);
    print('res${body}');
    if(body['success']==true)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }
  String? gender;
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.green,
          // ),
      body:
      SingleChildScrollView(
        child: Column(
            children: [
              const Text("Register",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Image.asset(
                "Images/Register.jpg",
                width: 300.0,
                height: 400.0,
                fit: BoxFit.cover,
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        fillColor: Colors.green,
                        prefixIconColor: Colors.green,
                        prefixIcon: Icon(Icons.person),
                        label: Text("name "),
                        // hintText: "Enter your Username",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green,),
                          borderRadius: BorderRadius.circular(20),
                        ))

                ),
              ),

              Padding(
        padding:  EdgeInsets.all(8.0),
        child: TextField(
          controller: unameController,
            decoration: InputDecoration(
               fillColor: Colors.green,
                prefixIconColor: Colors.green,
               prefixIcon: Icon(Icons.person),
                label: Text("Username "),
               // hintText: "Enter your Username",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green,),
                    borderRadius: BorderRadius.circular(20),
                ))

        ),
    ),


                 Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: TextField(
                    controller: pwdController,
                      obscureText: true,
                      //keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIconColor: Colors.green,
                        prefixIcon: Icon(Icons.lock),
                          label: Text("Password"),
                         // hintText: "Enter your Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green,),
                              borderRadius: BorderRadius.circular(20),
                          ))

                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIconColor: Colors.green,
                      prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
                        ),
                        label: Text("Age"),
                        //hintText: "Enter your Age",
                        )

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: addController,
                   // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIconColor: Colors.green,
                      prefixIcon: Icon(Icons.place),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
                      ),
                      label: Text("Place"),
                    )

                ),
              ),
              Row(
                children: [
                  Text("Gender:")
                ],
              ),

              RadioListTile(
                activeColor: Colors.green,
                title: Text("Male"),
                value: "male",
                groupValue: gender,
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),

              RadioListTile(
                activeColor: Colors.green,
                title: Text("Female"),
                value: "female",
                groupValue: gender,
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),
              //
              RadioListTile(
                activeColor: Colors.green,
                title: Text("Prefer not to Say"),
                value: "Prefer not to Say",
                groupValue: gender,
                onChanged: (value){
                  setState(() {
                    gender = value.toString();
                  });
                },
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                        prefixIconColor: Colors.green,
                        prefixIcon: const Icon(Icons.email),
                        label: const Text("Email"),
                        //hintText: "Enter your Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
                        ))

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: phnController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIconColor: Colors.green,
                        prefixIcon: const Icon(Icons.phone),
                        label: const Text("Phone Number"),
                        //hintText: "Enter your Phone Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
                        ))

                ),
              ),
               SizedBox(height: 20,),
              ElevatedButton(onPressed: ()
              {
                registerUser();

                },
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.green,fixedSize: Size(350, 57)),
                child: const Text("Signup",style: TextStyle(
                    fontSize: 18,color: Colors.white
                )),),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?",style: TextStyle(fontSize: 20),),TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                  }, child: const Text("Login",style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),))
                ],
              ),
            ],
        ),
      ),
      ),
      );
  }
}
