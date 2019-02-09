import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:study_flutter/src/commons/link_text_span.dart';
import 'package:study_flutter/src/components/contacts/contacts.dart';
import 'package:study_flutter/src/components/contacts_detail/contacts_detail.dart';

class ContactsPage extends StatefulWidget {
  final PageStorageBucket bucket;

  ContactsPage({Key key, @required this.bucket}) : super(key: key);

  @override
  ContactsPageState createState() {
    return new ContactsPageState();
  }
}

class ContactsPageState extends State<ContactsPage> {
  final ContactsBloc _contactsBloc = ContactsBloc();

  Future<void> _refresh() {
    _contactsBloc.dispatch(Refetch());

    return Future.delayed(Duration(milliseconds: 1000));
  }

  @override
  void initState() {
    final contacts =
        widget.bucket.readState(context, identifier: ValueKey('Contacts'));
    if (contacts != null) {
      _contactsBloc.dispatch(FetchContactsFromBucket(contacts: contacts));
    } else {
      _contactsBloc.dispatch(Fetch());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: BlocBuilder<ContactsEvent, ContactsState>(
          bloc: _contactsBloc,
          builder: (BuildContext context, ContactsState state) {
            if (state is ContactsInitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ContactsError) {
              return Center(
                child: Text('failed to fetch contacts'),
              );
            }

            if (state is IOSAccessContacts) {
              return Center(
                child: RaisedButton(
                  onPressed: SimplePermissions.openSettings,
                  child: new Text('Open settings'),
                ),
              );
            }

            if (state is ContactsLoaded) {
              widget.bucket.writeState(context, state.contacts,
                  identifier: ValueKey('Contacts'));

              if (state.contacts.isEmpty) {
                return Center(
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'no contacts \n',
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      LinkTextSpan(
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          onPressed: _refresh,
                          text: 'tap to reload!')
                    ]),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ContactsWidget(
                      contact: state.contacts[index],
                      contactsBloc: _contactsBloc,
                    );
                  },
                  itemCount: state.contacts.length,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ContactsWidget extends StatelessWidget {
  final Contact contact;
  final ContactsBloc contactsBloc;

  ContactsWidget({Key key, @required this.contact, this.contactsBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ContactsDetailPage(
                contact: contact, contactsBloc: contactsBloc),
          ),
        );
      },
      leading: (contact.avatar != null && contact.avatar.length > 0)
          ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar))
          : CircleAvatar(
              child: Text(
                contact.displayName.length > 1
                    ? contact.displayName?.substring(0, 2)
                    : '',
              ),
            ),
      title: Text(contact.displayName ?? ''),
    );
  }
}
