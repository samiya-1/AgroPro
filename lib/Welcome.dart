import 'package:flutter/material.dart';
import 'package:helloworld/Login.dart';
import 'package:helloworld/UserRegister.dart';
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Welcome!",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              const SizedBox(height: 25,),
              const Align(
                alignment: Alignment.center,
                child: Text("This application will Helps you to buy and sell products ",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 35,),
              Image.asset(
                "Images/welcome.jpg",
                width: 540.0,
                height: 350.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 35,),

              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
              },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),backgroundColor: Colors.green,fixedSize: Size(350, 57)),
                  child: const Text("Login",style: TextStyle(
                    fontSize: 18,color: Colors.white
                  ),),),
              const SizedBox(height: 35,),

              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
              },
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),backgroundColor: Colors.green,fixedSize: Size(350, 57)),
                child: const Text("Signup",style: TextStyle(
                    fontSize: 18,color: Colors.white
                )),),
            ]
    ),
        ),
    )
    );
  }
}

