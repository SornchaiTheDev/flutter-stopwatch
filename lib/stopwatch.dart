import 'package:flutter/material.dart';
import "dart:async";

class StopWatchWidget extends StatefulWidget {
  const StopWatchWidget({super.key});

  @override
  State<StopWatchWidget> createState() => _StopWatchWidgetState();
}

class _StopWatchWidgetState extends State<StopWatchWidget> {
  late Timer? timer;
  int seconds = 0;
  bool _isTick = false;

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void onStart() {
    if (_isTick) return;
    timer = Timer.periodic(const Duration(seconds: 1), count);
    setState(() {
      _isTick = true;
    });
  }

  void onStop() {
    if (!_isTick) return;
    timer?.cancel();
    setState(() {
      _isTick = false;
    });
  }

  void count(Timer timer) {
    setState(() {
      seconds = timer.tick;
    });
  }

  @override
  Widget build(BuildContext context) {
    String unit = seconds == 1 ? "second" : "seconds";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$seconds $unit",
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: onStart,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: const Text("Start"),
            ),
            const SizedBox(
              width: 10,
            ),
            FilledButton(
              onPressed: onStop,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Text("Stop"),
            ),
          ],
        )
      ],
    );
  }
}
