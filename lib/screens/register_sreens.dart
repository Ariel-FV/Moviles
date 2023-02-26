import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

   String selectedImagePath = '';

  final _corr = TextEditingController();
  final _nom = TextEditingController();
  final _pass = TextEditingController();
  bool _valCor = false;
  bool _valNom = false;
  bool _valP = false;
  bool _valFor = false;

  @override
  void dispose() {
    _nom.dispose();
    _corr.dispose();
    _pass.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {

    final txtNombre = TextFormField(
      controller: _nom,
    decoration: InputDecoration(
      errorText: _valNom ? 'Campo requerido' : null,
      label: Text('Nombre de usuario'),
      border: OutlineInputBorder()
    ),
  );

  final txtEmail = TextFormField(
    controller: _corr,
    decoration: InputDecoration(
      errorText: _valCor ?'Campo requerido': _valFor?'Formto invalido':null,
      label: Text('Email'),
      border: OutlineInputBorder()
    ),
  );

  final txtPass = TextFormField(
    obscureText: true,
    controller: _pass,
    decoration: InputDecoration(
      label: Text('Password'),
      border: OutlineInputBorder(),
      errorText: _valP?'Campo requerido': null,
    ),
  );

  final spaceHorizontal = SizedBox(height: 10,);

    final btnRegistrar = FilledButton( 
      onPressed:() {
        setState(() {
          _nom.text.isEmpty ? _valNom = true : _valNom = false;
          _corr.text.isEmpty ? _valCor = true : _valCor = false; 
          _pass.text.isEmpty ? _valP = true : _valP = false;
          !_corr.text.contains('@') ? _valFor = true : _valFor = false;
        
      });
      },
      child: const Text("Registrar"),
      
    );

    final btnFoto = ElevatedButton(
                onPressed: () async {
                  selectImage();
                  setState(() {});
                },
                child: const Text('Seleccionar Imagen'));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: .6, 
                fit: BoxFit.cover, 
                image: AssetImage('assets/fondo.jpg')
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        selectedImagePath == ''
                          ? Image.asset('assets/user.png', height: 200, width: 200, fit: BoxFit.fill,)
                          : Image.file(File(selectedImagePath), height: 200, width: 200, fit: BoxFit.fill,),
          
            const SizedBox(height: 10),
                        btnFoto,
                        spaceHorizontal,
                        txtNombre,
                        spaceHorizontal,
                        txtEmail,
                        spaceHorizontal,
                        txtPass,
                        spaceHorizontal,
                        btnRegistrar,
                        spaceHorizontal,
                    ],
                  ),
                ],
              ),
            ),
          ),
       ],
      ),
    );
  }
  
  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/galeria.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/camara.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Camara'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}

