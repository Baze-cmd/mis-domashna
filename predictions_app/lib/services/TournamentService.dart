import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/Tournament.dart';

class TournamentService
{
    static Database? _database;

    Future<Database> get database async
    {
        if (_database != null) return _database!;
        _database = await _initDB();
        return _database!;
    }

    Future<Database> _initDB() async
    {
        String path = join(await getDatabasesPath(), 'tournaments.db');
        return await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) async
            {
                await db.execute('''
          CREATE TABLE tournaments(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            dateTime TEXT NOT NULL,
            teams TEXT NOT NULL
          )
        ''');
            }
        );
    }

    Future<int> addTournament(Tournament tournament) async
    {
        final db = await database;
        tournament.dateTime = DateTime.now();
        return await db.insert('tournaments', tournament.toMap());
    }

    Future<int> deleteTournament(Tournament tournament) async
    {
        final db = await database;
        return await db.delete(
            'tournaments',
            where: 'name = ?',
            whereArgs: [tournament.name]
        );
    }

    Future<Tournament?> getTournament(String name) async
    {
        final db = await database;
        final List<Map<String, dynamic>> maps = await db.query(
            'tournaments',
            where: 'name = ?',
            whereArgs: [name]
        );
        if (maps.isEmpty) return null;
        return Tournament.fromMap(maps.first);
    }

    Future<List<Tournament>> getAllTournaments() async
    {
        final db = await database;
        final List<Map<String, dynamic>> maps = await db.query('tournaments');
        return List.generate(maps.length, (i) => Tournament.fromMap(maps[i]));
    }

    Future<int> updateTournament(Tournament tournament) async
    {
        final db = await database;
        return await db.update(
            'tournaments',
            tournament.toMap(),
            where: 'id = ?',
            whereArgs: [tournament.id]
        );
    }
}
