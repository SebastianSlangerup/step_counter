import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_counter/constants/walking_preferences.dart';

class StepCounterPage extends StatefulWidget {
  const StepCounterPage({super.key});

  @override
  State<StepCounterPage> createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '178';
  String distanceWalked = '1000';
  String caloriesBurned = '100';
  bool _isMetric = true;
  int caloriesPerKilometer = 70;
  int caloriesPerMile = 100;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) async {
    setState(() {
      _steps = event.steps.toString();
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('stepsWalked', event.steps);
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

double kmToMiles(double distance) {
  double miles = distance * 0.621371;
  return miles;
}

double milesToKm(double distance) {
  double km = distance / 1.621371;
  return km;
}

double distanceToKcal(String pace, double distanceInMiles) {
  double caloriesPerMile;

  switch (pace) {
    case 'Slow':
      caloriesPerMile = 60;
      break;
    case 'Average':
      caloriesPerMile = 70;
      break;
    case 'Fast':
      caloriesPerMile = 85;
      break;
    default:
      throw ArgumentError('Invalid pace. Choose "Slow", "Average", or "Fast".');
  }

  return distanceInMiles * caloriesPerMile;
}

double calculateDistanceInKm(int steps, String pace) {
  double stepLengthMeters;

  switch (pace) {
    case 'Slow':
      stepLengthMeters = 0.65;
      break;
    case 'Average':
      stepLengthMeters = 0.75;
      break;
    case 'Fast':
      stepLengthMeters = 0.85;
      break;
    default:
      throw ArgumentError('Invalid pace. Choose "Slow", "Average", or "Fast".');
  }

  double distanceMeters = steps * stepLengthMeters;
  return distanceMeters / 1000; // Convert meters to kilometers
}

  void initPlatformState() async {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount);

    final prefs = await SharedPreferences.getInstance();
    if (! context.mounted) return;

    var steps = prefs.getInt('stepsWalked') ?? int.parse(_steps);
    setState(() {
      _steps = steps.toString();
    });

    String walkingPreference = prefs.getString('walkingPreference') ?? 'Average';
    _isMetric = prefs.getBool('isMetric') ?? true;

    setState(() {
      distanceWalked = (steps / WalkingPreferences.metricDistanceCalculations[walkingPreference]!)
          .toStringAsFixed(2);
    });

    setState(() {
      caloriesBurned = (double.parse(distanceWalked) * caloriesPerKilometer).toStringAsFixed(1);
    });

    // Recalculate the distance walked to imperial measurement
    if (! _isMetric) {
      setState(() {
        distanceWalked = (double.parse(distanceWalked) * 0.621).toStringAsFixed(2);
      });
    }
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
            child: Text(_steps.toString()),
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
                        Text(_isMetric ? "km" : "mil", style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white54
                                : Colors.black54)
                        ),
                        Text(distanceWalked.toString(), style: const TextStyle(fontSize: 24)),
                        const VerticalDivider(
                          thickness: 2,
                          width: 50,
                        ),
                        Text(caloriesBurned.toString(), style: const TextStyle(fontSize: 24)),
                        Text('kcal', style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white54
                              : Colors.black54, )
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
