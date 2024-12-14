import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/approutes.dart';
import '../models/user_model.dart';
import '../providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 4),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/img.png',
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Login With Your Email & Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildTextField("Email", emailController),
            const SizedBox(height: 20),
            buildTextField("Password", passwordController, isPassword: true),
            const SizedBox(height: 20),
            buildForgotField(),
            const SizedBox(height: 40),
            buildLoginButton(context),
            const SizedBox(height: 10),
            buildRegisterField()
          ],
        ),
      ),
    );
  }

  Widget buildForgotField(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Forgot Password?",style: TextStyle(color: Colors.blueAccent.shade700),)
      ],
    );
  }

  Widget buildRegisterField(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account ?",style: TextStyle(color: Colors.grey),),
       Text("Register",style: TextStyle(color: Colors.blueAccent.shade700)
        )
      ],
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    bool isObscure = isPassword;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                isObscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
            )
                : null,
          ),
        );
      },
    );
  }


  Widget buildLoginButton(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, loginProvider, child) {
        return SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () async {
              final userModel = UserModel(email: emailController.text, password: passwordController.text);
              await loginProvider.loginUser(userModel);

              if (loginProvider.loginSuccess) {
                Navigator.pushNamed(context, AppRoutes.home);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown.shade800,
            ),
            child: Text(
              "Submit",
              style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
            ),
          ),

        );
      },
    );
  }
}

