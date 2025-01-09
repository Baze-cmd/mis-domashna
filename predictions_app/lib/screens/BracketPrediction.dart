import 'package:flutter/material.dart';
import '../models/Tournament.dart';
import '../models/Match.dart';
import '../widgets/MatchBox.dart';
import '../drawings/BracketLines.dart';

class BracketPrediction extends StatefulWidget
{
    final Tournament tournament;
    const BracketPrediction({super.key, required this.tournament});

    @override
    State<BracketPrediction> createState() => BracketPredictionState();
}

class BracketPredictionState extends State<BracketPrediction>
{
    final Map<int, TextEditingController> scoreControllers = {};
    final Map<String, List<Match>> matches = {};
    final ScrollController _horizontalController = ScrollController();

    @override
    void initState()
    {
        super.initState();
        for (int i = 0; i < 14; i++)
        {
            scoreControllers[i] = TextEditingController();
            scoreControllers[i]!.addListener(() => updateBracket());
        }

        List<Match> quarters = [];
        quarters.add(Match(team1: widget.tournament.teams[0], team2: widget.tournament.teams[7], team1Score: 0, team2Score: 0));
        quarters.add(Match(team1: widget.tournament.teams[3], team2: widget.tournament.teams[4], team1Score: 0, team2Score: 0));
        quarters.add(Match(team1: widget.tournament.teams[1], team2: widget.tournament.teams[6], team1Score: 0, team2Score: 0));
        quarters.add(Match(team1: widget.tournament.teams[2], team2: widget.tournament.teams[5], team1Score: 0, team2Score: 0));

        matches.putIfAbsent("quarters", () => quarters);
        matches.putIfAbsent("semis", () => List.generate(2, (index) =>
                Match(team1: "TBD", team2: "TBD", team1Score: 0, team2Score: 0)));
        matches.putIfAbsent("grands", () => List.generate(1, (index) =>
                Match(team1: "TBD", team2: "TBD", team1Score: 0, team2Score: 0)));
    }

    void updateBracket()
    {
        setState(()
            {
                // Update quarterfinal scores
                for (int i = 0; i < matches["quarters"]!.length; i++)
                {
                    matches["quarters"]![i].team1Score = int.tryParse(scoreControllers[i * 2]!.text) ?? 0;
                    matches["quarters"]![i].team2Score = int.tryParse(scoreControllers[i * 2 + 1]!.text) ?? 0;
                }

                // Update semifinals
                for (int i = 0; i < 2; i++)
                {
                    matches["semis"]![i].team1 = matches["quarters"]![i * 2].getWinner();
                    matches["semis"]![i].team2 = matches["quarters"]![i * 2 + 1].getWinner();
                    matches["semis"]![i].team1Score = int.tryParse(scoreControllers[8 + i * 2]!.text) ?? 0;
                    matches["semis"]![i].team2Score = int.tryParse(scoreControllers[9 + i * 2]!.text) ?? 0;
                }

                // Update finals
                matches["grands"]![0].team1 = matches["semis"]![0].getWinner();
                matches["grands"]![0].team2 = matches["semis"]![1].getWinner();
                matches["grands"]![0].team1Score = int.tryParse(scoreControllers[12]!.text) ?? 0;
                matches["grands"]![0].team2Score = int.tryParse(scoreControllers[13]!.text) ?? 0;
            }
        );
    }

    void saveBracket()
    {
        for (var key in ['quarters', 'semis', 'grands'])
        {
            for (var match in matches[key]!)
            {
                if (match.team1 == 'TBD' || match.team2 == 'TBD')
                {
                    showDialog(
                        context: context,
                        builder: (BuildContext context)
                        {
                            return AlertDialog(
                                title: Text('Incomplete Bracket'),
                                content: Text('Fill out bracket first'),
                                actions: [
                                    TextButton(
                                        onPressed: ()
                                        {
                                            Navigator.of(context).pop();
                                        },
                                        child: Text('OK')
                                    )
                                ]
                            );
                        }
                    );
                    return;
                }
            }
        }

        // TODO:
        // Order teams in tournament.teams
        // save tournament to database
        // redirect to tournament screen
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.tournament.name)
            ),
            body: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _horizontalController,
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                            width: 800,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                    // Quarterfinals
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                            MatchBox(
                                                team1: matches["quarters"]![0].team1,
                                                team2: matches["quarters"]![0].team2,
                                                controller1: scoreControllers[0]!,
                                                controller2: scoreControllers[1]!
                                            ),
                                            const SizedBox(height: 80),
                                            MatchBox(
                                                team1: matches["quarters"]![1].team1,
                                                team2: matches["quarters"]![1].team2,
                                                controller1: scoreControllers[2]!,
                                                controller2: scoreControllers[3]!
                                            ),
                                            const SizedBox(height: 80),
                                            MatchBox(
                                                team1: matches["quarters"]![2].team1,
                                                team2: matches["quarters"]![2].team2,
                                                controller1: scoreControllers[4]!,
                                                controller2: scoreControllers[5]!
                                            ),
                                            const SizedBox(height: 80),
                                            MatchBox(
                                                team1: matches["quarters"]![3].team1,
                                                team2: matches["quarters"]![3].team2,
                                                controller1: scoreControllers[6]!,
                                                controller2: scoreControllers[7]!
                                            )
                                        ]
                                    ),

                                    // Connecting Lines from quarters to semis
                                    CustomPaint(
                                        size: const Size(100, 640),
                                        painter: QuartersToSemisLines()
                                    ),

                                    // Semifinals
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                            Padding(
                                                padding: const EdgeInsets.only(top: 0.0),
                                                child: MatchBox(
                                                    team1: matches["semis"]![0].team1,
                                                    team2: matches["semis"]![0].team2,
                                                    controller1: scoreControllers[8]!,
                                                    controller2: scoreControllers[9]!
                                                )
                                            ),
                                            const SizedBox(height: 80),
                                            MatchBox(
                                                team1: matches["semis"]![1].team1,
                                                team2: matches["semis"]![1].team2,
                                                controller1: scoreControllers[10]!,
                                                controller2: scoreControllers[11]!
                                            )
                                        ]
                                    ),

                                    // Connecting Lines from semis to grands
                                    CustomPaint(
                                        size: const Size(100, 600),
                                        painter: SemisToGrandsLines()
                                    ),

                                    // Grand final
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                            Padding(
                                                padding: const EdgeInsets.only(top: 0.0),
                                                child: MatchBox(
                                                    team1: matches["grands"]![0].team1,
                                                    team2: matches["grands"]![0].team2,
                                                    controller1: scoreControllers[12]!,
                                                    controller2: scoreControllers[13]!
                                                )
                                            )
                                        ]
                                    )
                                ]
                            )
                        )
                    )
                )
            ),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: FloatingActionButton(
                    onPressed: saveBracket,
                    tooltip: 'Save prediction',
                    child: Icon(Icons.save)
                )
            )
        );
    }
}
