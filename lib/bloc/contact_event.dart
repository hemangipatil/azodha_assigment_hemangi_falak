abstract class ContactEvent {}

class SubmitContactEvent extends ContactEvent {
  final String name;
  final String email;
  final String phone;
  final String address;

  SubmitContactEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });
}
