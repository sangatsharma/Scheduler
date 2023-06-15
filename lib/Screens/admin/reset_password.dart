import 'package:flutter/material.dart';
import 'package:scheduler/Auth/auth_service.dart';
import 'package:scheduler/Widgets/appbar_func.dart';

class ResetPassword extends StatelessWidget{
  ResetPassword({super.key});

  // FormKey
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){

    // Holds the email entered
    String email = "";

    return Scaffold(
      // Simple default appBar
      appBar:buildAppBar(context, ""),

      body: Center(
        child: Form(
          key: _formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Text(
                "Forgot your password?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10,),

              const Text("Enter your email and we will send you a reset link"),
              
              const SizedBox(height: 20,),

              SizedBox(
                height: 85,
                child: TextFormField(
                  // When user types a new value, catch it
                  onChanged: (value){
                    email = value;
                  },

                  // Make sure that input field is not Empty neither null
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email';
                    }

                    // If everything is good, return null
                    return null;
                  },

                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontFamily: 'poppins'),
                    prefixIcon: Icon(Icons.email),
                    constraints:
                    BoxConstraints(maxHeight: 60, maxWidth: 300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 20,),

              OutlinedButton(
                onPressed: () async{

                  // Validate the form
                  if(_formKey.currentState!.validate()) {

                    // If good, send reset password link
                    bool result = await Authenticate.forgotPassword(
                        email: email, context: context);

                    // If success, return back to login page
                    if (result == true && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                  },
                child: const Text(
                    "Send reset link"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}