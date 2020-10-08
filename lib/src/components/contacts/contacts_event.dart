import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

abstract class ContactsEvent extends Equatable {}

class Fetch extends ContactsEvent {
  @override
  String toString() => 'Fetch';
}

class Refetch extends ContactsEvent {
  @override
  String toString() => 'Refetch';
}

class FetchContactsFromBucket extends ContactsEvent {
  final List<Contact> contacts;

  FetchContactsFromBucket({@required this.contacts});

  @override
  String toString() => 'FetchContactsFromBucket';
}
