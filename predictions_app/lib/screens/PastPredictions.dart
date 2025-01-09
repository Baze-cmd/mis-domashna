import 'package:flutter/material.dart';
import '../models/Tournament.dart';
import '../services/TournamentService.dart';
import 'TournamentDetails.dart';

class PastPredictions extends StatefulWidget
{
    const PastPredictions({super.key});

    @override
    State<PastPredictions> createState() => PastPredictionsState();
}

class PastPredictionsState extends State<PastPredictions>
{
    final TournamentService _tournamentService = TournamentService();
    late Future<List<Tournament>> _tournamentsFuture;

    @override
    void initState()
    {
        super.initState();
        _loadTournaments();
    }

    void _loadTournaments()
    {
        _tournamentsFuture = _tournamentService.getAllTournaments();
    }

    void deleteTournament(Tournament tournament)
    {
        _tournamentService.deleteTournament(tournament);
        setState(()
            {
                _loadTournaments();
            }
        );

    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Past Predictions')
            ),
            body: FutureBuilder<List<Tournament>>(
                future: _tournamentsFuture,
                builder: (context, snapshot)
                {
                    if (snapshot.connectionState == ConnectionState.waiting)
                    {
                        return const Center(
                            child: CircularProgressIndicator()
                        );
                    }

                    if (snapshot.hasError)
                    {
                        return Center(
                            child: Text('Error: ${snapshot.error}')
                        );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty)
                    {
                        return const Center(
                            child: Text('No past tournaments found')
                        );
                    }

                    final tournaments = snapshot.data!;

                    return ListView.builder(
                        itemCount: tournaments.length,
                        itemBuilder: (context, index)
                        {
                            final tournament = tournaments[index];
                            final winner = tournament.teams.isNotEmpty ? tournament.teams[0] : 'No winner';

                            return Card(
                                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: ListTile(
                                    title: Text(tournament.name),
                                    subtitle: Text('🏆 $winner'),
                                    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            ElevatedButton(
                                                onPressed: ()
                                                {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => TournamentDetails(tournament: tournament)
                                                        )
                                                    );
                                                },
                                                child: const Text('Results')
                                            ),
                                            const SizedBox(width: 8),
                                            ElevatedButton(
                                                onPressed: ()
                                                {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context)
                                                        {
                                                            return AlertDialog(
                                                                title: const Text('Confirm Deletion'),
                                                                content: Text('Are you sure you want to delete "${tournament.name}"?'),
                                                                actions: [
                                                                    TextButton(
                                                                        onPressed: ()
                                                                        {
                                                                            Navigator.of(context).pop();
                                                                        },
                                                                        child: const Text('Cancel')
                                                                    ),
                                                                    TextButton(
                                                                        onPressed: ()
                                                                        {
                                                                            Navigator.of(context).pop();
                                                                            deleteTournament(tournament);
                                                                        },
                                                                        child: const Text('Delete',
                                                                            style: TextStyle(color: Colors.red)
                                                                        )
                                                                    )
                                                                ]
                                                            );
                                                        }
                                                    );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red
                                                ),
                                                child: const Text('Delete')
                                            )
                                        ]
                                    )
                                )
                            );
                        }
                    );
                }
            )
        );
    }
}
