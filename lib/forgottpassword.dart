import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:helloworld/Login.dart';

class Fpassword extends StatefulWidget {
  const Fpassword({Key? key}) : super(key: key);

  @override
  State<Fpassword> createState() => _FpasswordState();
}

class _FpasswordState extends State<Fpassword> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> sendVerificationCode() async {
    final String email = _emailController.text;
    final String apiUrl = 'api/forgot-password';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final message = responseData['message'];

        // Verification code sent successfully
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        // Handle the error case
        print('Failed to send verification code. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('Exception: $e');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Forgot Password",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
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
              child: Text(
                "we will send  a verification code to your email",
                style: TextStyle(fontSize: 20, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: sendVerificationCode,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),
                backgroundColor: Colors.green,
                fixedSize: Size(350, 57),
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}









// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:helloworld/Login.dart';
//
// class Fpassword extends StatefulWidget {
//   const Fpassword({Key? key}) : super(key: key);
//
//   @override
//   State<Fpassword> createState() => _FpasswordState();
// }
//
// class _FpasswordState extends State<Fpassword> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//       ),
//         body:SingleChildScrollView(
//     child:
//         /*decoration: const BoxDecoration(
//         image: DecorationImage(image: AssetImage("Images/img_1.png"),
//     fit: BoxFit.fill)
//     ),*/ Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text("Forgot Password",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
//               const SizedBox(height: 35,),
//               Image.asset(
//                 "Images/f_pass.jpg",
//                 width: 540.0,
//                 height: 350.0,
//                 fit: BoxFit.cover,
//               ),
//         SizedBox(height: 25,),
//         const Align(
//             alignment: Alignment.center,
//             child: Text("we will send  a verification code to your email",style: TextStyle(fontSize: 20,color: Colors.green),textAlign: TextAlign.center,),
//         ),
//               SizedBox(height: 15,),
//
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.email),
//                         label: Text("Email"),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
//                         )
//                     )
//
//                 ),
//               ),
//               const SizedBox(height: 15,),
//
//               ElevatedButton(onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
//               },
//                   style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),backgroundColor: Colors.green,fixedSize: Size(350, 57)),
//                   child: const Text("Submit")),
//         ],
//     ),
//         )
//
//     );
//   }
// }
//
//
