import 'package:flutter/material.dart';

class DiscreteButton extends StatefulWidget {
  const DiscreteButton({
    super.key,
    required this.onTap,
    required this.text, 
    });

  final Function()? onTap;
  final String text; 

  @override
  State<DiscreteButton> createState() => _DiscreteButtonState();
}

class _DiscreteButtonState extends State<DiscreteButton> {
  bool isTouching = false;


  @override
  Widget build(BuildContext context) {
    return Listener(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: isTouching ? Colors.white : Colors.blue,
              ),
            ),
          ),
        ),
      ),
      onPointerDown: (event) => setState(() {
        isTouching = true;
      }),
        onPointerUp: (event) => setState(() {
        isTouching = false;
      }),
    );
  }
}