import 'package:flutter/material.dart';

class MatchBox extends StatelessWidget
{
    final String team1;
    final String team2;
    final TextEditingController controller1;
    final TextEditingController controller2;

    const MatchBox({
        super.key,
        required this.team1,
        required this.team2,
        required this.controller1,
        required this.controller2
    });

    @override
    Widget build(BuildContext context)
    {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                    Container(
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Column(
                            children: [
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.black))
                                    ),
                                    child: Row(
                                        children: [
                                            Expanded(
                                                child: Text(
                                                    team1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(fontSize: 14)
                                                )
                                            ),
                                            const SizedBox(width: 8),
                                            SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: TextField(
                                                    controller: controller1,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 4),
                                                        border: OutlineInputBorder()
                                                    )
                                                )
                                            )
                                        ]
                                    )
                                ),
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                        children: [
                                            Expanded(
                                                child: Text(
                                                    team2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(fontSize: 14)
                                                )
                                            ),
                                            const SizedBox(width: 8),
                                            SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: TextField(
                                                    controller: controller2,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 4),
                                                        border: OutlineInputBorder()
                                                    )
                                                )
                                            )
                                        ]
                                    )
                                )
                            ]
                        )
                    )
                ]
            )
        );
    }
}
