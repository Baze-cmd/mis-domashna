import 'package:flutter/material.dart';
import '../models/Tournament.dart';
import 'Home.dart';
import '../services/TournamentService.dart';

class TournamentDetails extends StatefulWidget
{
    final Tournament tournament;
    const TournamentDetails({super.key, required this.tournament});

    @override
    State<TournamentDetails> createState() => TournamentDetailsState();
}

class TournamentDetailsState extends State<TournamentDetails>
{
    final tournamentService = TournamentService();

    String getPlacement(int index)
    {
        if (index == 0) return "🏆 1st";
        if (index == 1) return "🥈 2nd";
        if (index == 2 || index == 3) return "🥉 3rd-4th";
        return "5th-8th";
    }

    void delete()
    {
        tournamentService.deleteTournament(widget.tournament);
        returnToHomePage();
    }

    void returnToHomePage()
    {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false
        );
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.tournament.name, style: const TextStyle(fontSize: 20)),
                centerTitle: true
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                        Card(
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Table(
                                    columnWidths: const
                                    {
                                        0: FlexColumnWidth(3),
                                        1: FlexColumnWidth(2)
                                    },
                                    children: [
                                        const TableRow(
                                            children: [
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text(
                                                            'Participant',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 18
                                                            )
                                                        )
                                                    )
                                                ),
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text(
                                                            'Place',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 18
                                                            )
                                                        )
                                                    )
                                                )
                                            ]
                                        ),
                                        ...List.generate(
                                            widget.tournament.teams.length,
                                            (index) => TableRow(
                                                children: [
                                                    TableCell(
                                                        child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                                widget.tournament.teams[index],
                                                                style: const TextStyle(fontSize: 16)
                                                            )
                                                        )
                                                    ),
                                                    TableCell(
                                                        child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                                getPlacement(index),
                                                                style: const TextStyle(fontSize: 16)
                                                            )
                                                        )
                                                    )
                                                ]
                                            )
                                        )
                                    ]
                                )
                            )
                        ),
                        const Spacer(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                ElevatedButton(
                                    onPressed: () => delete(),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        textStyle: const TextStyle(fontSize: 16)
                                    ),
                                    child: const Text('Delete prediction')
                                ),
                                ElevatedButton(
                                    onPressed: () => returnToHomePage(),
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        textStyle: const TextStyle(fontSize: 16)
                                    ),
                                    child: const Text('Home')
                                )
                            ]
                        ),
                        const SizedBox(height: 20)
                    ]
                )
            )
        );
    }
}
