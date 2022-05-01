import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nymble/logic_layer/tic_tac_toe_brain/brain.dart';
import 'package:nymble/presentation_layer/screens/game_selection_page.dart';
import 'package:nymble/presentation_layer/utils/colors.dart';
import 'package:nymble/presentation_layer/widgets/alert.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;
  String result = "";

  Game game = Game();
  int canWinPos = 999;

  @override
  void initState() {
    game.board = Game.initGameBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackGround,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Tic Tac Toe",style: TextStyle(color: Colors.white,fontSize: 25.sp,fontWeight: FontWeight.w400,fontFamily: "PermanentMarker"),),),
          SizedBox(height: 5.h,),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Playing as ',style: TextStyle(fontSize: 18.sp,color: kPrimary),),
                TextSpan(
                  text: 'X',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp,color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
          SizedBox(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 3,
              padding: EdgeInsets.all(16.w),
              mainAxisSpacing: 8.0.w,
              crossAxisSpacing: 8.0.w,
              children: List.generate(
                Game.boardLength,
                (index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: gameOver
                        ? null
                        : () {
                            if (game.board![index] == 2) {
                              setState(
                                () {
                                  turn++;
                                  game.board![index] = turn.isOdd ? 3 : 5;
                                  canWinPos = game.winnerCheck(
                                    lastValue == "X" ? 3 : 5,
                                    index,
                                    turn,
                                    game.board!,
                                  );
                                  gameOver = (canWinPos == 555) ? true : false;
                                  if (gameOver) {
                                    showAlert(context, lastValue);
                                    result = "$lastValue is the Winner";
                                  } else if (!gameOver && turn == 9) {
                                    result = "It's a Draw!";
                                    showAlert(context, "D");
                                    gameOver = true;
                                  }
                                  lastValue == "X"
                                      ? lastValue = "O"
                                      : lastValue = "X";
                                  if (turn < 9 && !gameOver) {
                                    turn++;
                                    if (canWinPos != 999 && canWinPos != 555) {
                                      game.board![canWinPos] =
                                          turn.isOdd ? 3 : 5;
                                    } else {
                                      canWinPos = game.board!.indexOf(2);
                                      game.board![canWinPos] =
                                          turn.isOdd ? 3 : 5;
                                    }
                                    canWinPos = game.winnerCheck(
                                      lastValue == "X" ? 3 : 5,
                                      canWinPos,
                                      turn,
                                      game.board!,
                                    );
                                    gameOver =
                                        (canWinPos == 555) ? true : false;
                                    if (gameOver) {
                                      showAlert(context, lastValue);
                                      result = "$lastValue is the Winner";
                                    } else if (!gameOver && turn == 9) {
                                      result = "It's a Draw!";
                                      gameOver = true;
                                      showAlert(context, "D");
                                    }
                                    lastValue == "X"
                                        ? lastValue = "O"
                                        : lastValue = "X";
                                  }
                                },
                              );
                            }
                          },
                    child: Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          game.board![index] == 3
                              ? "X"
                              : game.board![index] == 5
                                  ? "O"
                                  : "",
                          style: TextStyle(
                            color: game.board![index] == 3
                                ? Colors.red
                                : Colors.indigo,
                            fontSize: 64.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 125.h,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                setState(
                  () {
                    game.board = Game.initGameBoard();
                    lastValue = "X";
                    gameOver = false;
                    turn = 0;
                    result = "";
                  },
                );
              });
              Get.to(GameSelection());
            },
            style: ElevatedButton.styleFrom(
              primary: kPrimary,
              fixedSize: Size(120.w, 30.h),
            ),
            child: Text(
              "Quit",
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}
