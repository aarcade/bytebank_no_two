import 'package:byte_bank_version_two/database/ContactDao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future <Database> getDatabase() async {
  //String diretorioDosBancos = await getDatabasesPath();
  String caminhoCompletoDoBanco = join(await getDatabasesPath(), 'bytebank.db');

    return openDatabase(
        caminhoCompletoDoBanco,
        version: 1,
        onDowngrade: onDatabaseDowngradeDelete,
        onCreate: (database, version) {
        database.execute(ContactDao.TABLESQL);
    });
}