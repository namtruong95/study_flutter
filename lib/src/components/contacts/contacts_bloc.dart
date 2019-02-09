import 'dart:async';
import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:study_flutter/src/components/contacts/contacts.dart';
import 'package:study_flutter/src/repositories/contacts_repository.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactsRepository contactsRepo = new ContactsRepository();

  @override
  Stream<ContactsEvent> transform(Stream<ContactsEvent> events) {
    return (events as Observable<ContactsEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  ContactsState get initialState => ContactsInitialized();

  @override
  Stream<ContactsState> mapEventToState(
      ContactsState currentState, ContactsEvent event) async* {
    if (event is Fetch || event is Refetch) {
      try {
        if (currentState is ContactsInitialized) {
          final contacts = await contactsRepo.getListPost();

          yield ContactsLoaded(contacts: contacts);
        }
      } catch (e) {
        if (Platform.isIOS) {
          yield IOSAccessContacts();
          return;
        }
        yield ContactsError();
      }
      return;
    }

    if (event is FetchContactsFromBucket) {
      yield ContactsLoaded(contacts: event.contacts);
    }
  }
}
