import 'package:flutter/material.dart';
import 'package:vendorapp/Login/login_page.dart';
import 'package:vendorapp/models/vendor_models.dart';
import 'package:vendorapp/services/vendor_service.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

final _formKey=GlobalKey<FormState>();
final TextEditingController fnameController=TextEditingController();
final TextEditingController lnameController=TextEditingController();
final TextEditingController emailController=TextEditingController();
final TextEditingController mobileController=TextEditingController();
final TextEditingController passwordController=TextEditingController();
final TextEditingController confirmpasswordController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(key: _formKey,child: Column(children: [
          Center(child: Text('Vendor Registraton form',style: TextStyle(fontSize: 18),)),
          SizedBox(height: 20,),
          TextFormField(validator: (value) {
            if(value==null || value.isEmpty){
              return 'Please enter first name';
            }
            return null;
            
          },controller: fnameController, decoration: InputDecoration(labelText: 'Enter First Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),),
          SizedBox(height: 15,),
          TextFormField(validator: (value) {
            if(value==null || value.isEmpty){
              return 'Please enter last name';
            }
            return null;
          },controller: lnameController, decoration: InputDecoration(labelText: 'Enter Last Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),),
          SizedBox(height: 15,),
          TextFormField(validator: (value) {
            if(value==null || value.isEmpty){
              return 'Please enter email id';
            }
             else if (!value.endsWith('@gmail.com')) {
                return 'Enter a valid email address';
              }
            
              return null;
            
          },controller: emailController, decoration: InputDecoration(labelText: 'Enter Email Id',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),),
          SizedBox(height: 15,),
          TextFormField(validator: (value) {
            if(value==null || value.isEmpty){
              return 'Please enter mobile number';
            }
            else if(value.length!=10){
              return 'Mobile number shoulld be exact 10 digits';
            }
            
           
            
            return null;
            
          },controller: mobileController, decoration: InputDecoration(labelText: 'Enter Mobile Number',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),),
          SizedBox(height: 15,),
          TextFormField(validator: (value) {
            if(value==null || value.isEmpty){
              return 'Please enter password';
            }
            else if (value.length < 8) {
               return 'Password must be at least 8 characters';
          } else if (!RegExp(r'^(?=.*[!@#\$%^&*(),.?":{}|<>]).{8,}$').hasMatch(value)) {
               return 'Password must include at least one special character';
          }
          return null;
            
          },controller: passwordController, decoration: InputDecoration(labelText: 'Create a password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),),
          SizedBox(height: 15,),
          TextFormField(validator: (value) {
            if(value==null || value.isEmpty){
              return 'Please enter confirm password';
            }
            else if(value!=passwordController.text){
              return  'Password is not the same';
            }
            return null;
            
          },controller: confirmpasswordController, decoration: InputDecoration(labelText: 'Confirm Password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),),
          SizedBox(height: 20,),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [FilledButton(onPressed: (){
             fnameController.clear();
                lnameController.clear();
                emailController.clear();
                passwordController.clear();
                confirmpasswordController.clear();
                mobileController.clear();
          }, child: Text('Clear')),
          SizedBox(width: 20,),
          FilledButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      // Check if email already exists
      if (VendorService.emailExists(emailController.text.trim())) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email already registered')),
        );
        return;
      }

      // Save vendor to Hive
      final vendor = VendorModel(
        firstName: fnameController.text.trim(),
        lastName: lnameController.text.trim(),
        email: emailController.text.trim(),
        mobile: mobileController.text.trim(),
        password: passwordController.text.trim(),
      );

      await VendorService.addVendor(vendor);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Successfully Created')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  },
  child: const Text('Submit'),
),
],)
        ],)),
      ),
    )),);
  }
}