import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeff1f5),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Card Matcher",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Make a move in less time',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(
                '20 Seconds',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                        front: Container(
                          color: Colors.black,
                        ),
                        back: Container(
                          color: Colors.yellow,
                        ));
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
