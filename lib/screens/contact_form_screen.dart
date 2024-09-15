import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/contact_bloc.dart';
import '../bloc/contact_event.dart';
import '../bloc/contact_state.dart';

class ContactFormScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFc2cede),
          title: Center(child: Text('Add New Contact'))
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/registrationloginbg.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: BlocListener<ContactBloc, ContactState>(
            listener: (context, state) {
              if (state is ContactErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              } else if (state is ContactSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Contact added successfully!')),
                );
                _formKey.currentState?.reset();
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20),
                          border: InputBorder.none,
                          labelText: 'Name',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20),
                          labelText: 'Email',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'Enter an email';
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                          return 'Enter a valid email';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20),
                          labelText: 'Phone Number',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'Enter a phone number';
                        if (!RegExp(r'^\d{10}$').hasMatch(value))
                          return 'Enter a valid phone number';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20),
                          labelText: 'Address',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter an address' : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<ContactBloc, ContactState>(
                    builder: (context, state) {
                      if (state is ContactLoadingState) {
                        return CircularProgressIndicator();
                      }
                      if (state is ContactSuccessState) {
                        return Text('Contact submitted successfully!');
                      }
                      if (state is ContactErrorState) {
                        return Text('Error: ${state.message}');
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ContactBloc>(context).add(
                              SubmitContactEvent(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                              ),
                            );
                          }
                        },
                        child: Text('Submit'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
