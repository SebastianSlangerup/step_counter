import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepCounterPage extends StatefulWidget {
  const StepCounterPage({super.key});

  @override
  State<StepCounterPage> createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

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
        Text(_steps, style: const TextStyle(fontSize: 62)),
        Icon(
            _status == 'walking'
                ? Icons.directions_walk
                : _status == 'stopped'
                    ? Icons.accessibility_new
                    : Icons.error,
            size: 100),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Element 1', style: TextStyle(fontSize: 24)),
            Text('|', style: TextStyle(fontSize: 24)),
            Text('Element 2', style: TextStyle(fontSize: 24)),
          ],
        )
      ],
    );
  }
}
