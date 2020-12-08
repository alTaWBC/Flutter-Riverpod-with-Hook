import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/game_controller.dart';

/// UI of game
class GameScreen extends HookWidget {
  ///
  final int level;

  /// Default Constructor
  GameScreen({this.level = 8});

  @override
  Widget build(BuildContext context) {
    /// Game state
    final vm = useProvider(gameProvider);
    useEffect(() {
      Future.microtask(() => vm.initState(level));
    });
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
                '${vm.time} Seconds',
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
                  itemCount: level,
                  itemBuilder: (context, index) {
                    return FlipCard(
                      key: vm.cardStateKeys[index],
                      onFlip: () => vm.matchCard(index, context),
                      flipOnTouch: vm.cardFlips[index],
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        margin: EdgeInsets.all(4),
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                      back: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF50a026),
                                Color(0xFF72c837),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.2, 1]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(4),
                        height: 20,
                        child: Center(
                          child: Text(
                            vm.data[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
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
