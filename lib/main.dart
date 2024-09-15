import 'package:azodha_assigment_hemangi_falak/screens/contact_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bloc/contact_bloc.dart';
import 'repository/contact_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactBloc>(
          create: (context) => ContactBloc(
            firestore: FirebaseFirestore.instance,
            contactRepository: ContactRepository(FirebaseFirestore.instance),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contact Form App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactFormScreen(),
      ),
    );
  }
}

