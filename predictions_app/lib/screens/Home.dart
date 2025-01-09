import 'package:flutter/material.dart';
import 'PastPredictions.dart';
import 'SeedTeams.dart';

class Home extends StatelessWidget
{
    const Home({super.key});

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text('Home')
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        ElevatedButton(
                            onPressed: ()
                            {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PastPredictions()
                                    )
                                );
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 60),
                                textStyle: TextStyle(fontSize: 18)
                            ),
                            child: Text('Past Predictions')
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: ()
                            {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SeedTeams()
                                    )
                                );
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 60),
                                textStyle: TextStyle(fontSize: 18)
                            ),
                            child: Text('Start New Prediction')
                        )
                    ]
                )
            )
        );
    }

}
