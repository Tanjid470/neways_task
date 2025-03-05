import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neways_task/const/app_colors.dart';

Future<Map<String, dynamic>?> fetchUserByEmail(String email) async {
  var snapshot = await FirebaseFirestore.instance
      .collection('register')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();

  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.data();
  }
  return null; // Return null if no user is found
}

class UserInfoView extends StatelessWidget {
  final String email; // Pass the email to search for
  const UserInfoView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Info')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchUserByEmail(email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("User not found"));
          }
          var user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoRow(title: 'Name', value: user['name']),
                UserInfoRow(title: 'Email', value: user['email']),
                UserInfoRow(title: 'Gender', value: user['gender']),
                UserInfoRow(title: 'Date of birth', value: user['dob']),
                //UserInfoRow(title: 'Image', value: user['image']),
                UserInfoRow(title: 'Position', value: user['position']),
              ],
            ),
          );
        },
      ),
    );
  }
}


class UserInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const UserInfoRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.baseColor),
            ),
          ),
        ],
      ),
    );
  }
}

