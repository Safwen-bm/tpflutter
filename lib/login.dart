import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp2/home.dart';
import 'package:tp2/sign_up.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login(BuildContext context, String email, String password) async {
    
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password,
    );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful! Welcome back.')),
      );

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(),
            _inputField(_emailController, _passwordController, context),
            _forgetPassword(),
            _signUp(context),
          ],
        ),
      ),
    );
  }
}

_header(){
  return Column(
    children: [
      Text(
        "Welcome Back!!",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
      Text(
        "Enter your credential to login!!",
      ),
    ],
  );
}

_inputField(TextEditingController emailController, TextEditingController passwordController, BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextField(
        controller: emailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
          hintText: "Email",
          fillColor: Colors.purple.withOpacity(0.1),
          filled: true,
          prefixIcon: Icon(Icons.mail)),
      ),
      SizedBox(
        height: 10,
      ),
      TextField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.password),
          fillColor: Colors.purple.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none)),
        ),
        SizedBox(
        height: 10,
      ),
      ElevatedButton(
        onPressed: () {
          final email = emailController.text.trim();
          final password = passwordController.text.trim();
          LoginPage().login(context, email, password);
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: StadiumBorder()),
        child: Text(
          "Login",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ) 
      ),
    ],
  );
}

_forgetPassword(){
  return TextButton(
    onPressed: () => {},  
    child: Text(
      "Forget password",
      style: TextStyle(color: Colors.purple),
    ),
  );
}

_signUp(context){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Don't have an account ?"),
      TextButton(
        onPressed: () => {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => SignUpPage()))
        }, 
        child: Text(
          "Sign Up",
          style: TextStyle(color: Colors.purple),
        ))
    ],
  );
}