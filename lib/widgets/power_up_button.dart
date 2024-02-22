import 'package:flutter/material.dart';
import 'package:green_zone/data_structures/power_up.dart';

class PowerUpButton extends StatelessWidget {
  PowerUp ability;
  VoidCallback callback;

  PowerUpButton({super.key, required this.ability, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ability.isLocked ? () {} : callback,
        child: Container(
          height: 90,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 2.0),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
          decoration: BoxDecoration(
            color: ability.isActive ? Colors.green : Colors.grey,
            border: Border.all(
              color: ability.isSelected ? Colors.green : Colors.transparent,
              width: 4.0,
            ),
          ),
          child: Center(
            child: ability.isLocked
                ? Icon(
                    Icons.lock,
                    color: Colors.white,
                  )
                : Text(
                    ability.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
          ),
        ));
  }
}
