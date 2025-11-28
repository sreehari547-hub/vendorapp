import 'package:flutter/material.dart';
import 'package:vendorapp/homepage.dart';
import 'package:vendorapp/registration_form.dart';
import 'package:vendorapp/services/vendor_service.dart';
import 'package:vendorapp/session/session_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _formKey=GlobalKey<FormState>();
final TextEditingController emailController=TextEditingController();
final TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color.fromARGB(255, 241, 245, 247),body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(key: _formKey,child: Column(children: [
          Center(child: Text('Login Page',style: TextStyle(fontSize: 20),),),
          SizedBox(height: 20,),
          TextFormField(validator: (value) {
            if(value==null || value.isEmpty){
              return 'Please enter email id';
            }
             return null;
          },controller: emailController,decoration: InputDecoration(labelText: 'Enter Email Id',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),),
          SizedBox(height: 15,),
          TextFormField(
            validator: (value) {
              if(value==null || value.isEmpty){
                return 'Please enter password';
              }
              return null;
            },
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Enter Password',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
            ),
          ),
          SizedBox(height: 15,),
          FilledButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  final vendor = VendorService.getVendorByEmail(
                    emailController.text.trim(),
                  );

                  if (vendor != null &&
                      vendor.password == passwordController.text.trim()) {
                    final saved = await SessionManager.saveLoginSession(
                      useremail: vendor.email,
                      userId: vendor.key.toString(),
                    );

                    if (!mounted) return;

                    if (!saved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Could not create session, try again'),
                        ),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login successful!')),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ),
                    );
                  } else {
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid email or password'),
                      ),
                    );
                  }
                } catch (e) {
                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error during login: $e')),
                  );
                }
              }
            },
            child: const Text('Login'),
          ),
        BottomAppBar(color: const Color.fromARGB(255, 241, 245, 247),child: TextButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationForm()));
        }, child: Text('Are you new? Register here')),)
        ],)),
      ),
    ),);
  }
}