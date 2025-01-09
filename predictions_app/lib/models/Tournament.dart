
class Tournament
{
    int? id;
    String name;
    DateTime dateTime;
    List<String> teams;

    Tournament({
        this.id,
        required this.name,
        required this.dateTime,
        required this.teams
    });

    Map<String, dynamic> toMap()
    {
        return
        {
            'id': id,
            'name': name,
            'dateTime': dateTime.toIso8601String(),
            'teams': teams.join(',')
        };
    }

    factory Tournament.fromMap(Map<String, dynamic> map)
    {
        return Tournament(
            id: map['id'],
            name: map['name'],
            dateTime: DateTime.parse(map['dateTime']),
            teams: map['teams'].split(',')
        );
    }
}
