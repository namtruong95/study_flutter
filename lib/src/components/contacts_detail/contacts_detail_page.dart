import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:study_flutter/src/components/contacts/contacts.dart';

class ContactsDetailPage extends StatelessWidget {
  final Contact contact;
  final ContactsBloc contactsBloc;
  const ContactsDetailPage(
      {Key key, @required this.contact, @required this.contactsBloc})
      : super(key: key);

  void _removeContact(
      {@required BuildContext context, @required ContactsBloc contactsBloc}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Remove contact'),
            content: new Text('Do you want remove this contact?'),
            actions: <Widget>[
              new RaisedButton(
                onPressed: () {
                  Navigator.pop(context, true);

                  ContactsService.deleteContact(contact).then((success) {
                    contactsBloc.dispatch(Refetch());
                    Navigator.pop(context);
                  });
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              new FlatButton(
                child: new Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.displayName ?? ''),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => shareVCFCard(context, contact: contact),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () =>
                _removeContact(context: context, contactsBloc: contactsBloc),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Name'),
              trailing: Text(contact.givenName ?? ''),
            ),
            ListTile(
              title: Text('Middle name'),
              trailing: Text(contact.middleName ?? ''),
            ),
            ListTile(
              title: Text('Family name'),
              trailing: Text(contact.familyName ?? ''),
            ),
            ListTile(
              title: Text('Prefix'),
              trailing: Text(contact.prefix ?? ''),
            ),
            ListTile(
              title: Text('Suffix'),
              trailing: Text(contact.suffix ?? ''),
            ),
            ListTile(
              title: Text('Company'),
              trailing: Text(contact.company ?? ''),
            ),
            ListTile(
              title: Text('Job'),
              trailing: Text(contact.jobTitle ?? ''),
            ),
            AddressesTile(contact.postalAddresses),
            ItemsTile('Phones', contact.phones),
            ItemsTile('Emails', contact.emails)
          ],
        ),
      ),
    );
  }
}

class AddressesTile extends StatelessWidget {
  AddressesTile(this._addresses);
  final Iterable<PostalAddress> _addresses;

  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(title: Text('Addresses')),
          Column(
              children: _addresses
                  .map((a) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                                title: Text('Street'),
                                trailing: Text(a.street)),
                            ListTile(
                                title: Text('Postcode'),
                                trailing: Text(a.postcode)),
                            ListTile(
                                title: Text('City'), trailing: Text(a.city)),
                            ListTile(
                                title: Text('Region'),
                                trailing: Text(a.region)),
                            ListTile(
                                title: Text('Country'),
                                trailing: Text(a.country)),
                          ],
                        ),
                      ))
                  .toList())
        ]);
  }
}

class ItemsTile extends StatelessWidget {
  ItemsTile(this._title, this._items);
  final Iterable<Item> _items;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(title: Text(_title)),
          Column(
              children: _items
                  .map((i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListTile(
                          title: Text(i.label ?? ''),
                          trailing: Text(i.value ?? ''))))
                  .toList())
        ]);
  }
}
