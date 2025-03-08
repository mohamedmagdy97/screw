import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardChatGPT extends StatefulWidget {


  const DashboardChatGPT({
    super.key,

  });

  @override
  State<DashboardChatGPT> createState() => _DashboardChatGPTState();
}

class _DashboardChatGPTState extends State<DashboardChatGPT> {



  @override
  Widget build(BuildContext context) {


    return GameScreen();
  }

 }

class Player {
  String name;
  int totalScore;

  Player({required this.name, this.totalScore = 0});
}

class Round {
  int player1Score;
  int player2Score;

  Round({required this.player1Score, required this.player2Score});
}


class GameProvider with ChangeNotifier {
  List<Round> rounds = [];
  int player1Total = 0;
  int player2Total = 0;

  void addRound(int p1Score, int p2Score) {
    rounds.add(Round(player1Score: p1Score, player2Score: p2Score));
    player1Total += p1Score;
    player2Total += p2Score;
    notifyListeners();
  }

  void resetGame() {
    rounds.clear();
    player1Total = 0;
    player2Total = 0;
    notifyListeners();
  }
}




class GameScreen extends StatelessWidget {
  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("حاسبة لعبة سكرو")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: gameProvider.rounds.length,
              itemBuilder: (context, index) {
                final round = gameProvider.rounds[index];
                return ListTile(
                  title: Text("الجولة ${index + 1}"),
                  subtitle: Text(
                    "لاعب 1: ${round.player1Score} | لاعب 2: ${round.player2Score} | الفريق: ${round.player1Score + round.player2Score}",
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: player1Controller,
                    decoration: InputDecoration(labelText: "نتيجة لاعب 1"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: player2Controller,
                    decoration: InputDecoration(labelText: "نتيجة لاعب 2"),
                    keyboardType: TextInputType.number,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    final p1Score = int.tryParse(player1Controller.text) ?? 0;
                    final p2Score = int.tryParse(player2Controller.text) ?? 0;
                    gameProvider.addRound(p1Score, p2Score);
                    player1Controller.clear();
                    player2Controller.clear();
                  },
                ),
              ],
            ),
          ),
          Text("إجمالي النقاط: لاعب 1 = ${gameProvider.player1Total} | لاعب 2 = ${gameProvider.player2Total} | الفريق = ${gameProvider.player1Total + gameProvider.player2Total}"),
          ElevatedButton(
            onPressed: () => gameProvider.resetGame(),
            child: Text("إعادة تعيين اللعبة"),
          ),
        ],
      ),
    );
  }
}
