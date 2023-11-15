import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text, 
    });

  final Function()? onTap;
  final String text; 

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isTouching = false;


  @override
  Widget build(BuildContext context) {
    return Listener(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isTouching == false ? Colors.blueGrey : Colors.blueAccent,
          ),
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
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