import 'package:flutter/material.dart';
import '../models/Tournament.dart';
import 'BracketPrediction.dart';

class SeedTeams extends StatefulWidget
{
    const SeedTeams({super.key});

    @override
    SeedTeamsState createState() => SeedTeamsState();
}

class SeedTeamsState extends State<SeedTeams>
{
    final _formKey = GlobalKey<FormState>();
    final _tournamentController = TextEditingController();
    final List<TextEditingController> _teamControllers =
        List.generate(8, (_) => TextEditingController());

    @override
    void dispose()
    {
        _tournamentController.dispose();
        for (var controller in _teamControllers)
        {
            controller.dispose();
        }
        super.dispose();
    }

    void generateBracket()
    {
        if (_formKey.currentState?.validate() ?? false)
        {
            final tournament = Tournament(
                dateTime: DateTime.now(),
                name: _tournamentController.text,
                teams: _teamControllers.map((c) => c.text).toList()
            );

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BracketPrediction(tournament: tournament)
                )
            );
        }
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(title: Text('Seed Teams')),
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                        children: [
                            TextFormField(
                                controller: _tournamentController,
                                decoration: InputDecoration(
                                    labelText: 'Tournament name',
                                    border: OutlineInputBorder()
                                ),
                                validator: (value) =>
                                value?.isEmpty ?? true ? 'Please enter tournament name' : null
                            ),
                            SizedBox(height: 20),
                            ...List.generate(8, (index)
                                {
                                    return Padding(
                                        padding: EdgeInsets.only(bottom: 12),
                                        child: TextFormField(
                                            controller: _teamControllers[index],
                                            decoration: InputDecoration(
                                                labelText: '#${index + 1} Seed',
                                                border: OutlineInputBorder()
                                            ),
                                            validator: (value) =>
                                            value?.isEmpty ?? true ? 'Please enter team name' : null
                                        )
                                    );
                                }
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: generateBracket,
                                child: Text('Generate Bracket'),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50)
                                )
                            )
                        ]
                    )
                )
            )
        );
    }
}
