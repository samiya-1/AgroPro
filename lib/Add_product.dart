import 'dart:io';
import 'package:flutter/material.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/products.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
   AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> {
  File? imageFile;
  late  final _filename;
  late  final bytes;
  late SharedPreferences prefs;
  TextEditingController pnameController=TextEditingController();
  TextEditingController qualityController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController quantityController=TextEditingController();
  TextEditingController freshnessController=TextEditingController();

  Future<void> submitForm(
      String Product_name,
      String Quality,
      String Price,
      String Quantity,
      String Freshness,
      String image )
  async {
     prefs = await SharedPreferences.getInstance();
    var user = (prefs.getInt('user') ?? 0);

    var uri = Uri.parse(Api().url+'/api/AddProduct'); // Replace with your API endpoint

    var request = http.MultipartRequest('POST', uri);

    request.fields['user'] = user.toString();
    request.fields['product_name'] = Product_name;
    request.fields['quality'] = Quality;
    request.fields['price'] = Price;
    request.fields['quantity'] = Quantity;
    request.fields['freshness'] = Freshness;
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

    if (response.statusCode == 201) {
      print('Form submitted successfully');
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Products()));
    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
    }
  }


  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text("Choose From"),
                SizedBox(height: 20,),
                InkWell(
                    onTap: () {
                      _getFromGallery();

                      Navigator.pop(context);
                    },
                    child: Text("Gallery")),
                SizedBox(height: 20,),
                InkWell(
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                    },
                    child: Text("camera")),
              ],
            ),
          );
        });
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

  print("imageFile:${imageFile}");
  print(_filename);
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              const Text("Add Product",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

              Image.asset(
                "Images/AddProducts.jpg",
                width: 540.0,
                height: 350.0,
                fit: BoxFit.fill,
              ),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: TextField(
                  controller: pnameController,
                    decoration: InputDecoration(
                        fillColor: Colors.green,
                        prefixIconColor: Colors.green,
                        prefixIcon: Icon(Icons.person),
                        label: Text("Product name "),
                        // hintText: "Enter your Username",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green,),
                          borderRadius: BorderRadius.circular(20),
                        ))

                ),
              ),



              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: qualityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIconColor: Colors.green,
                      prefixIcon: Icon(Icons.production_quantity_limits),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
                      ),
                      label: Text("Quantity"),
                      //hintText: "Enter your Age",
                    )

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIconColor: Colors.green,
                      prefixIcon: Icon(Icons.production_quantity_limits),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
                      ),
                      label: Text("Price"),

                    )

                ),
              ),

                     Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(

                    keyboardType: TextInputType.number,
                     controller: quantityController,
                    decoration: InputDecoration(
                        prefixIconColor: Colors.green,
                        prefixIcon: const Icon(Icons.high_quality),
                        label: const Text("quality"),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
                        ))

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                     controller: freshnessController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIconColor: Colors.green,
                        prefixIcon: const Icon(Icons.high_quality),
                        label: const Text("Freshness"),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.green)
                        ))

                ),
              ),
                Container(

                child: imageFile == null? Container(child: Column(children: <Widget>[
  ElevatedButton(onPressed: () {
                  _getFromGallery();
                  _showChoiceDialog(context);
  },
  child: Text("Upload Image"),
  ),
  Container(height: 40.0,
  ),

  ],
  ),
  ): Row(
  children: [
  Container(
  alignment: Alignment.centerLeft,
  child: Image.file(
  imageFile!,
  width: 100,
  height: 100,
  //  fit: BoxFit.cover,
  ),
  ), ElevatedButton(
  onPressed: () {
  //    _getFromGallery();
  _showChoiceDialog(context);
  },
  child: Text("Upload Image"),
  ),
  ],
  ),
  ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: ()
              {
              submitForm(pnameController.text,qualityController.text,priceController.text,quantityController.text,freshnessController.text,_filename);
              },
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.green,fixedSize: Size(350, 57)),
                child: const Text("Add Product",style: TextStyle(
                    fontSize: 18,color: Colors.white
                )),),

            ],
          ),
        ),
      ),
    );
  }
}
