import 'package:byte_bank_version_two/database/ContactDao.dart';
import 'package:byte_bank_version_two/database/app_database.dart';
import 'package:byte_bank_version_two/modelo/contact.dart';
import 'package:flutter/material.dart';

import 'formulario_de_contatos.dart';

class contactList extends StatefulWidget {
  @override
  _contactListState createState() => _contactListState();
}

class _contactListState extends State<contactList> {
  final List<Contact> contacts = List();
  final ContactDao _dao =ContactDao();

  @override
  Widget build(BuildContext context) {
    contacts.add(Contact(0, 'Alex', 1234));
    contacts.add(Contact(1, 'Amanda', 5678));
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context)=> ContactsForm(),
              ),
            );
          },
          child: Icon(Icons.add),

        ),
      body: FutureBuilder<List<Contact>>(

        initialData: List(),
        future: _dao.loadAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              List<Contact>contacts = snapshot.data;

              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final Contact
                  contact = contacts[index];
                  return _ContactItem(contact);
                },
              );
              break;
          }
          return Text('Erro desconhecido: Entre em contato com o nosso suporte');
        }
      ),
    );
  }
}
class _ContactItem extends StatelessWidget {
  final Contact contact;
  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {

    return Card(
        child: ListTile(
          title: Text(
            contact.name,
            style: TextStyle(fontSize: 24.0),
          ),
          subtitle: Text(
            contact.accountNumber.toString(),
            style: TextStyle(fontSize: 16.0),),
        ));
  }
}
