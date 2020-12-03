import 'package:byte_bank_version_two/database/ContactDao.dart';
import 'package:byte_bank_version_two/database/app_database.dart';
import 'package:byte_bank_version_two/modelo/contact.dart';
import 'package:flutter/material.dart';

class ContactsForm extends StatefulWidget {
  @override
  _ContactsFormState createState() => _ContactsFormState();
}

class _ContactsFormState extends State<ContactsForm> {
  final TextEditingController _nameController =TextEditingController ();

  final TextEditingController _accountNumberController =TextEditingController();
  final ContactDao _dao = ContactDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewContact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full name',
              ),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account number',
                ),
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                child: RaisedButton(child: Text("Create"), onPressed: () {
                  final String name = _nameController.text;
                  final int accountNumber=int.tryParse(_accountNumberController.text);
                  final Contact newContact=Contact(0,name, accountNumber);
                  _dao.save(newContact).then((id)=>Navigator.pop(context));

                }))
            ),],
        ),
      ),
    );
  }
}
