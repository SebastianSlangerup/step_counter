import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';

class StepCounterPage extends StatefulWidget {
  const StepCounterPage({super.key});

  @override
  State<StepCounterPage> createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '0';
  int distanceWalked = 1000;
  int caloriesBurned = 100;
  String measurement = "km";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status.toString();
    });
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  void onStepCountError(error) {
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 150),
          width: 300,
          height: 280,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(_steps),
          ),
        ),
        SizedBox(
          width: 320,
          height: 260,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(measurement, style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black54)
                        ),
                        Text(distanceWalked.toString(), style: const TextStyle(fontSize: 24)),
                        const VerticalDivider(
                          thickness: 2,
                          width: 50,
                        ),
                        Text(caloriesBurned.toString(), style: const TextStyle(fontSize: 24)),
                        const Text('kcal', style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54, )
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
        ),
        Text(_status, style: const TextStyle(color: Colors.red)),
      ],
    );
  }
}
