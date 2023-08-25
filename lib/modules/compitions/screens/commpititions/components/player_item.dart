
import 'package:flutter/material.dart';

class PlayerItem extends StatelessWidget {
  PlayerItem({
    Key? key,
    required this.playerName,
    required this.playerProfileImage,
  }) : super(key: key);

  String? playerName;
  final String playerProfileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      child: Row(
        children: [
          if (playerName != null)
            CircleAvatar(
              backgroundColor: Colors.grey,
              minRadius: 12,
            ),
          SizedBox(
            width: 5,
          ),
          //Text(playerName ?? ''),
        ],
      ),
    );
  }
}
