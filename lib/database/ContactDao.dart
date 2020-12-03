
import 'package:byte_bank_version_two/modelo/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'app_database.dart';

class ContactDao{
  static const String TABLESQL = 'CREATE TABLE _tableName('
                                  '$_id INTEGER PRIMARY KEY,'
                                  '$_name TEXT,'
                                  '$_account_number INTEGER'
                                  ')';
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _account_number = 'account_number';
  Future<int> save(Contact contact) async{
    return await _toMap(contact);
  }

  _toMap(Contact contact) async {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_account_number] = contact.accountNumber;
    Database database = await getDatabase();
    return database.insert(_tableName, contactMap);
  }


  Future<List<Contact>> loadAll()async {
    return await _toList();
  }

  Future<List<Contact>> _toList() async {
    Database database = await getDatabase();
    ////return createDataBase().then((database) {
    List<Map<String, dynamic>> rows = await database.query('contacts');
    //return database.query(_tableName).then((rows) {
    final List<Contact> contacts= List();
    for (Map<String, dynamic> row in rows) {
      Contact contact = Contact(row[_id],row[_name],row[_account_number]);
      contacts.add(contact);
    }
    return contacts;
  }
}