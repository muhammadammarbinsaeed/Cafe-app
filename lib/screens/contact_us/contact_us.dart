import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cafe_app/utils/color.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? _name;
  String? _email;
  String? _message;

  void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    
    // Form is valid, submit the data to Firebase
    firestore.collection('contact_forms').add({
      'name': _name,
      'email': _email,
      'message': _message,
    });

    // Reset the form fields
    _formKey.currentState!.reset();

   
    try {
   
      // Show success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Submitted'),
            content: const Text('Form Submitted successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to send the email. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isSmallScreen = height < 600;

    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Contact Form",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
     
        centerTitle: true,
      ),
      // backgroundColor: kPrimaryLightColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16.0 : width * 0.2,
          vertical: 10.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Name',
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Neumorphic(
                margin: EdgeInsets.only(top: 8.0),
                style: NeumorphicStyle(
                  depth: -3,
                  intensity: 0.8,
                  color: Colors.grey[300]!,
                  shape: NeumorphicShape.convex,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12.0),
                  ),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _name = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    border: InputBorder.none,
                    hintText: 'Enter your name',
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Email',
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Neumorphic(
                margin: EdgeInsets.only(top: 8.0),
                style: NeumorphicStyle(
                  depth: -3,
                  intensity: 0.8,
                  color: Colors.grey[300]!,
                  shape: NeumorphicShape.convex,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12.0),
                  ),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    border: InputBorder.none,
                    hintText: 'Enter your email',
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Message',
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Neumorphic(
                margin: EdgeInsets.only(top: 8.0),
                style: NeumorphicStyle(
                  depth: -3,
                  intensity: 0.8,
                  color: Colors.grey[300]!,
                  shape: NeumorphicShape.convex,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12.0),
                  ),
                ),
                child: TextFormField(
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _message = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your message',
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Center(
                child: SizedBox(
                  width: isSmallScreen ? double.infinity : width * 0.3,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
