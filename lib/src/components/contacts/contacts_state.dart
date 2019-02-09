import 'package:equatable/equatable.dart';
import 'package:contacts_service/contacts_service.dart';

abstract class ContactsState extends Equatable {}

class ContactsInitialized extends ContactsState {
  @override
  String toString() => 'ContactsInitialized';
}

class ContactsError extends ContactsState {
  @override
  String toString() => 'ContactsError';
}

class IOSAccessContacts extends ContactsState {
  @override
  String toString() => 'IOSAccessContacts';
}

class ContactsLoaded extends ContactsState {
  final List<Contact> contacts;

  ContactsLoaded({this.contacts});

  ContactsLoaded copyWith({
    List<Contact> contacts,
    bool hasReachedMax,
  }) {
    return ContactsLoaded(
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  String toString() => 'ContactsLoaded { posts: ${contacts.length} }';
}
