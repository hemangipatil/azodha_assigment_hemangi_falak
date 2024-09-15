import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repository/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final FirebaseFirestore firestore;
  final ContactRepository contactRepository;

  ContactBloc({required this.firestore, required this.contactRepository}) : super(ContactInitialState()) {
    // Registering the event handler with the `on<SubmitContactEvent>` method
    on<SubmitContactEvent>((event, emit) async {
      emit(ContactLoadingState());

      try {
        await contactRepository.addContact(
          name: event.name,
          email: event.email,
          phone: event.phone,
          address: event.address,
        );
        emit(ContactSuccessState());
      } catch (e) {
        emit(ContactErrorState(e.toString()));
      }
    });
  }
}
