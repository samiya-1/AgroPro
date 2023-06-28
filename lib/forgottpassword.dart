import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/Login.dart';

class Fpassword extends StatefulWidget {
  const Fpassword({Key? key}) : super(key: key);

  @override
  State<Fpassword> createState() => _FpasswordState();
}

class _FpasswordState extends State<Fpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
        body:SingleChildScrollView(
    child:
        /*decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("Images/img_1.png"),
    fit: BoxFit.fill)
    ),*/ Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Forgot Password",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              const SizedBox(height: 35,),
              Image.asset(
                "Images/f_pass.jpg",
                width: 540.0,
                height: 350.0,
                fit: BoxFit.cover,
              ),
        SizedBox(height: 25,),
        const Align(
            alignment: Alignment.center,
            child: Text("we will send  a verification code to your email",style: TextStyle(fontSize: 20,color: Colors.green),textAlign: TextAlign.center,),
        ),
              SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        label: Text("Email"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
                        )
                    )

                ),
              ),
              const SizedBox(height: 15,),

              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
              },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),backgroundColor: Colors.green,fixedSize: Size(350, 57)),
                  child: const Text("Submit")),
        ],
    ),
        )

    );
  }
}


