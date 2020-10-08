import 'dart:async';
import 'dart:io' show Platform;

import 'package:contacts_service/contacts_service.dart';
import 'package:simple_permissions/simple_permissions.dart';

class ContactsRepository {
  static final ContactsRepository _contactsRepository =
      new ContactsRepository._internal();
  factory ContactsRepository() => _contactsRepository;
  ContactsRepository._internal();

  FutureOr<List<Contact>> getListPost([String query]) async {
    final bool canAccess = await _checkOrRequestPermission();

    try {
      if (canAccess) {
        Iterable<Contact> contacts =
            await ContactsService.getContacts(query: query);

        return contacts.toList();
      }
    } catch (e) {
      throw e;
    }

    return throw new Exception('no read rights. Aborting mission!');
  }

  Future<bool> _checkOrRequestPermission() async {
    if (Platform.isIOS) {
      final status =
          await SimplePermissions.getPermissionStatus(Permission.ReadContacts);

      return status == PermissionStatus.authorized;
    }

    if (Platform.isAndroid) {
      final status =
          await SimplePermissions.requestPermission(Permission.ReadContacts);

      return status == PermissionStatus.authorized;
    }

    return false;
  }
}
