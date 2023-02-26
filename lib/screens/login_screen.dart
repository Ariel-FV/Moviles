import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../widgets/loading_modal_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

bool isLoading=false;

final txtEmail = TextFormField(
  decoration: InputDecoration(
    label: Text('Email User'),
    border: OutlineInputBorder()
  ),
);
final txtPass = TextFormField(
  decoration: InputDecoration(
    label: Text('Password'),
    border: OutlineInputBorder()
  ),
);
final spaceHorizontal = SizedBox(height: 10,);



final btnGoggle = SocialLoginButton(buttonType: SocialLoginButtonType.google, onPressed:(){}, );
final btnFacebook = SocialLoginButton(buttonType: SocialLoginButtonType.facebook, onPressed: (){},);
final btnGitHub = SocialLoginButton(buttonType: SocialLoginButtonType.github, onPressed: (){});



final imglogo = Image.asset('assets/logo.png', height: 200,);

  @override
  Widget build(BuildContext context) {

    final txtRegister = Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
       child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
          },
          child: const Text('Crear cuenta :)', style: TextStyle(fontSize: 18, decoration: TextDecoration.underline))));

    final btnEmail = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin, 
      onPressed:() {
        isLoading=true;
        setState(() {});
        Future.delayed(Duration(milliseconds: 6000)).then((value){
          isLoading=false;
          setState(() {});
          Navigator.pushNamed(context, '/dash');
        });
      },
    );

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
                    
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        
                        txtEmail,
                        spaceHorizontal,
                        txtPass,
                        spaceHorizontal,
                        btnEmail,
                        spaceHorizontal,
                        btnFacebook,
                        spaceHorizontal,
                        btnGoggle,
                        spaceHorizontal,
                        btnGitHub,
                        spaceHorizontal,
                        txtRegister
                    ],
                  ),
                  Positioned(top:100, child: imglogo)
                ],
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
       ],
      ),
    );
  }
}