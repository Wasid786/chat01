import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserDetailsBottomSheet extends StatelessWidget {
  final User user;

  UserDetailsBottomSheet(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(user.imageUrl),
          ),
          SizedBox(height: 15),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
