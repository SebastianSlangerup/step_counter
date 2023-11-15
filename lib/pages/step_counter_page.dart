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
  String _status = '?', _steps = '100';

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
    _stepCountStream.listen(onStepCount);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 128),
          width: 200,
          height: 100,
          child: const AutoSizeTextField(
            decoration: ,
            maxLines: 1,
            minFontSize: 24,
          ),
        ),
        const SizedBox(
          width: 320,
          height: 320,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Element 1', style: TextStyle(fontSize: 24)),
                        Text('|', style: TextStyle(fontSize: 24)),
                        Text('Element 2', style: TextStyle(fontSize: 24)),
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
