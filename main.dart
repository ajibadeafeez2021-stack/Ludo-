import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const LudoApp());
}

class LudoApp extends StatelessWidget {
  const LudoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ludo Master',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

// ================= HOME PAGE =================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff17122b), Color(0xff43206f)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text('🎲', style: TextStyle(fontSize: 70)),
                  const Text(
                    'LUDO MASTER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Classic 4-player Ludo',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GamePage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.groups),
                      label: const Text(
                        'PLAY 4 PLAYERS',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonalIcon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GamePage(
                              cpu: [false, true, true, true],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.smart_toy),
                      label: const Text(
                        'PLAY VS COMPUTER',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => const HowToDialog(),
                        );
                      },
                      icon: const Icon(Icons.help_outline),
                      label: const Text(
                        'HOW TO PLAY',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= HOW TO PLAY =================

class HowToDialog extends StatelessWidget {
  const HowToDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('How to Play'),
      content: const Text(
        '• Roll a 6 to bring a token out of home.\n\n'
        '• Tap a highlighted token to move it.\n\n'
        '• Rolling a 6 gives another turn.\n\n'
        '• Landing on an opponent on a non-safe square sends that token home.\n\n'
        '• Squares marked with a star, and each start square, are safe.\n\n'
        '• You must land exactly on the last square of your colored lane to finish a token.\n\n'
        '• Get all 4 tokens to the finish to win.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

// ================= PLAYERS =================

class PlayerInfo {
  final String name;
  final String emoji;
  final Color color;
  final int start;

  const PlayerInfo(this.name, this.emoji, this.color, this.start);
}

// Red = top-left, Green = top-right, Yellow = bottom-right, Blue = bottom-left.
const players = <PlayerInfo>[
  PlayerInfo('Red', '🔴', Color(0xffe53935), 0),
  PlayerInfo('Green', '🟢', Color(0xff43a047), 13),
  PlayerInfo('Yellow', '🟡', Color(0xffffca28), 26),
  PlayerInfo('Blue', '🔵', Color(0xff1e88e5), 39),
];

// ================= BOARD DATA =================

const path = <Point<int>>[
  Point(6, 0), Point(7, 0), Point(8, 0),
  Point(8, 1), Point(8, 2), Point(8, 3), Point(8, 4), Point(8, 5),
  Point(9, 6), Point(10, 6), Point(11, 6), Point(12, 6), Point(13, 6),
  Point(14, 6), Point(14, 7), Point(14, 8),
  Point(13, 8), Point(12, 8), Point(11, 8), Point(10, 8), Point(9, 8),
  Point(8, 9), Point(8, 10), Point(8, 11), Point(8, 12), Point(8, 13),
  Point(8, 14), Point(7, 14), Point(6, 14),
  Point(6, 13), Point(6, 12), Point(6, 11), Point(6, 10), Point(6, 9),
  Point(5, 8), Point(4, 8), Point(3, 8), Point(2, 8), Point(1, 8),
  Point(0, 8), Point(0, 7), Point(0, 6),
  Point(1, 6), Point(2, 6), Point(3, 6), Point(4, 6), Point(5, 6),
  Point(6, 5), Point(6, 4), Point(6, 3), Point(6, 2), Point(6, 1),
];

const safeSquares = <int>{0, 8, 13, 21, 26, 34, 39, 47};

// Colored finishing lanes (5 squares each, entered after progress 51).
const lanes = <int, List<Point<int>>>{
  0: [Point(7, 1), Point(7, 2), Point(7, 3), Point(7, 4), Point(7, 5)],
  1: [Point(13, 7), Point(12, 7), Point(11, 7), Point(10, 7), Point(9, 7)],
  2: [Point(7, 13), Point(7, 12), Point(7, 11), Point(7, 10), Point(7, 9)],
  3: [Point(1, 7), Point(2, 7), Point(3, 7), Point(4, 7), Point(5, 7)],
};

// Token resting spots inside each home corner (in cell units).
const homeCenters = <int, List<Point<double>>>{
  0: [Point(1.7, 1.7), Point(4.3, 1.7), Point(1.7, 4.3), Point(4.3, 4.3)],
  1: [Point(10.7, 1.7), Point(13.3, 1.7), Point(10.7, 4.3), Point(13.3, 4.3)],
  2: [Point(10.7, 10.7), Point(13.3, 10.7), Point(10.7, 13.3), Point(13.3, 13.3)],
  3: [Point(1.7, 10.7), Point(4.3, 10.7), Point(1.7, 13.3), Point(4.3, 13.3)],
};

// Where finished tokens sit in the center, one triangle per color.
const finishCenters = <int, Point<double>>{
  0: Point(7.5, 6.65),
  1: Point(8.35, 7.5),
  2: Point(7.5, 8.35),
  3: Point(6.65, 7.5),
};

// ================= GAME PAGE =================

class GamePage extends StatefulWidget {
  // cpu[i] == true means player i is controlled by the computer.
  final List<bool> cpu;

  const GamePage({
    super.key,
    this.cpu = const [false, false, false, false],
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Random random = Random();

  List<List<int>> tokens = List.generate(4, (_) => List.filled(4, -1));

  int currentPlayer = 0;
  int dice = 0;

  bool hasRolled = false;
  bool gameOver = false;

  // True while waiting to hand the turn to the next player.
  bool locked = false;

  // Incremented on reset so stale delayed callbacks are ignored.
  int turnId = 0;

  // Dice animation state.
  bool rolling = false;
  int shownFace = 0;

  List<bool> get cpu => widget.cpu;

  String message = 'Roll the dice to start.';

  int globalIndex(int player, int progress) {
    return (players[player].start + progress) % 52;
  }

  Point<int> tokenCell(int player, int progress) {
    if (progress < 52) {
      return path[globalIndex(player, progress)];
    }
    return lanes[player]![progress - 52];
  }

  bool canMove(int player, int token) {
    final position = tokens[player][token];

    if (position == 56) return false;
    if (position == -1) return dice == 6;
    return position + dice <= 56;
  }

  List<int> movableTokens() {
    return [0, 1, 2, 3].where((t) => canMove(currentPlayer, t)).toList();
  }

  void scheduleNext(Duration delay) {
    final id = turnId;
    Future.delayed(delay, () {
      if (id == turnId) nextPlayer();
    });
  }

  @override
  void initState() {
    super.initState();
    maybeCpuTurn();
  }

  // ================= ROLL DICE =================

  Future<void> rollDice() async {
    if (hasRolled || gameOver || locked || rolling) return;

    final id = turnId;
    final name = players[currentPlayer].name;

    setState(() {
      rolling = true;
      message = '$name is rolling...';
    });

    // Quick flicker of dice faces.
    for (int i = 0; i < 9; i++) {
      await Future.delayed(const Duration(milliseconds: 70));
      if (!mounted || id != turnId) return;
      setState(() => shownFace = random.nextInt(6) + 1);
    }

    final value = random.nextInt(6) + 1;

    setState(() {
      dice = value;
      shownFace = value;
      rolling = false;
      hasRolled = true;
    });

    if (movableTokens().isEmpty) {
      if (value == 6) {
        setState(() {
          hasRolled = false;
          message = '$name rolled 6 but has no move. Roll again.';
        });
        maybeCpuTurn();
      } else {
        setState(() {
          locked = true;
          message = '$name rolled $value. No move.';
        });
        scheduleNext(const Duration(milliseconds: 900));
      }
      return;
    }

    setState(() {
      message = cpu[currentPlayer]
          ? '$name rolled $value.'
          : '$name rolled $value. Tap a highlighted token.';
    });

    if (cpu[currentPlayer]) {
      scheduleCpuMove();
    }
  }

  // ================= COMPUTER PLAYER =================

  void maybeCpuTurn() {
    if (gameOver || !cpu[currentPlayer]) return;

    final id = turnId;
    final who = currentPlayer;

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted || id != turnId || gameOver) return;
      if (currentPlayer != who || hasRolled || locked || rolling) return;
      rollDice();
    });
  }

  void scheduleCpuMove() {
    final id = turnId;
    final who = currentPlayer;

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted || id != turnId || gameOver) return;
      if (currentPlayer != who || !hasRolled || locked) return;

      final moves = movableTokens();
      if (moves.isEmpty) return;

      moves.sort((a, b) => scoreMove(who, b).compareTo(scoreMove(who, a)));
      moveToken(moves.first);
    });
  }

  // Simple heuristic: prefer captures, finishing, leaving home,
  // entering the lane and safe squares.
  double scoreMove(int player, int token) {
    final old = tokens[player][token];
    final next = old == -1 ? 0 : old + dice;

    double score = next * 0.1;

    if (old == -1) score += 50;
    if (next == 56) score += 80;
    if (old < 52 && next >= 52 && next < 56) score += 30;

    if (next < 52) {
      final g = globalIndex(player, next);
      if (safeSquares.contains(g)) {
        score += 20;
      } else {
        for (int p = 0; p < 4; p++) {
          if (p == player) continue;
          for (int e = 0; e < 4; e++) {
            final pos = tokens[p][e];
            if (pos >= 0 && pos < 52 && globalIndex(p, pos) == g) {
              score += 100;
            }
          }
        }
      }
    }

    return score;
  }

  // ================= MOVE TOKEN =================

  void moveToken(int token) {
    if (!hasRolled ||
        gameOver ||
        locked ||
        rolling ||
        !canMove(currentPlayer, token)) {
      return;
    }

    final me = currentPlayer;
    final rolled = dice;
    final name = players[me].name;
    final oldPosition = tokens[me][token];
    final newPosition = oldPosition == -1 ? 0 : oldPosition + rolled;

    int captured = 0;
    bool won = false;

    setState(() {
      tokens[me][token] = newPosition;
      hasRolled = false;

      // Captures happen only on the shared track, on non-safe squares.
      if (newPosition < 52) {
        final global = globalIndex(me, newPosition);
        if (!safeSquares.contains(global)) {
          for (int p = 0; p < 4; p++) {
            if (p == me) continue;
            for (int e = 0; e < 4; e++) {
              final pos = tokens[p][e];
              if (pos >= 0 && pos < 52 && globalIndex(p, pos) == global) {
                tokens[p][e] = -1;
                captured++;
              }
            }
          }
        }
      }

      won = tokens[me].every((p) => p == 56);

      if (won) {
        gameOver = true;
        message = '🏆 $name WINS!';
        return;
      }

      final captureText = captured > 0
          ? ' $name captured $captured token${captured > 1 ? 's' : ''}!'
          : '';

      if (rolled == 6) {
        dice = 0;
        message = '$name moved token ${token + 1}.$captureText Roll again!';
      } else {
        locked = true;
        message = '$name moved token ${token + 1}.$captureText';
      }
    });

    if (won) {
      _showWinner(me);
      return;
    }

    if (rolled == 6) {
      maybeCpuTurn();
    } else {
      scheduleNext(const Duration(milliseconds: 450));
    }
  }

  void _showWinner(int player) {
    if (!mounted) return;
    final info = players[player];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text('🏆 ${info.name} wins!'),
        content: Text(
          '${info.emoji} ${info.name} got all 4 tokens home.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('HOME'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              resetGame();
            },
            child: const Text('PLAY AGAIN'),
          ),
        ],
      ),
    );
  }

  // ================= NEXT PLAYER =================

  void nextPlayer() {
    if (!mounted || gameOver) return;

    final next = (currentPlayer + 1) % 4;

    setState(() {
      currentPlayer = next;
      dice = 0;
      hasRolled = false;
      locked = false;
      message = '${players[next].name} is ready.';
    });

    maybeCpuTurn();
  }

  // ================= RESET =================

  void resetGame() {
    setState(() {
      turnId++;
      tokens = List.generate(4, (_) => List.filled(4, -1));
      currentPlayer = 0;
      dice = 0;
      shownFace = 0;
      rolling = false;
      hasRolled = false;
      gameOver = false;
      locked = false;
      message = 'Roll the dice to start.';
    });

    maybeCpuTurn();
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    final player = players[currentPlayer];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ludo Master'),
        actions: [
          IconButton(
            onPressed: resetGame,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: player.color.withValues(alpha: .13),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${player.emoji} ${player.name}’s turn${cpu[currentPlayer] ? ' (CPU)' : ''}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                    DiceFace(
                      value: rolling ? shownFace : dice,
                      size: 44,
                      rolling: rolling,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 1,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomPaint(painter: LudoBoardPainter()),
                        ...buildTokens(constraints.maxWidth),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: (!hasRolled &&
                              !gameOver &&
                              !locked &&
                              !rolling &&
                              !cpu[currentPlayer])
                          ? rollDice
                          : null,
                      icon: const Icon(Icons.casino),
                      label: Text(
                        rolling
                            ? 'ROLLING...'
                            : cpu[currentPlayer]
                                ? 'COMPUTER PLAYING'
                                : dice == 0
                                    ? 'ROLL DICE'
                                    : 'DICE: $dice',
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: resetGame,
                    child: const Text('RESET
