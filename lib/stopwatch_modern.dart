import 'package:flutter/material.dart';
import "dart:async";

class StopWatchModernWidget extends StatefulWidget {
  const StopWatchModernWidget({super.key});

  @override
  State<StopWatchModernWidget> createState() => _StopWatchModernWidgetState();
}

class _StopWatchModernWidgetState extends State<StopWatchModernWidget> {
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

  void onPressed() {
    if (!_isTick) {
      onStart();
    } else {
      onStop();
    }
  }

  @override
  Widget build(BuildContext context) {
    String unit = seconds == 1 ? "second" : "seconds";
    String time = seconds.toString().padLeft(2, "0");
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 64.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 100.0,
                  child: Text(
                    unit,
                    style: const TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                IconButton(
                  onPressed: onPressed,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.lime,
                    ),
                    iconSize: MaterialStateProperty.all(64.0),
                  ),
                  icon: Icon(
                    _isTick ? Icons.stop : Icons.play_arrow,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32.0),
          Text(
            "Lap",
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24.0),
          Expanded(
              child: ListView(
            children: const [
              TimeLap(order: 1, seconds: 1),
            ],
          )),
        ],
      ),
    );
  }
}

class TimeLap extends StatelessWidget {
  const TimeLap({super.key, required this.order, required this.seconds});

  final int order;
  final int seconds;

  String formatedTime() {
    return "00:00:00";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            order.toString(),
            style: TextStyle(color: Colors.grey[500]),
          ),
          Text(
            formatedTime(),
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
