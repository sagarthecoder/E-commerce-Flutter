import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: user != null ? _buildProfileInfo(user!) : _buildNoUserInfo(),
      ),
    );
  }

  Widget _buildProfileInfo(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: user.photoURL != null
                ? NetworkImage(user.photoURL!)
                : const AssetImage('utils/assets/images/default_avatar.png')
                    as ImageProvider,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            user.displayName ?? "No Display Name",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            user.email ?? "No Email",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        const Divider(height: 40, thickness: 1),
        _buildUserInfoRow(
            "Phone Number", user.phoneNumber ?? "No Phone Number"),
        _buildUserInfoRow("Email Verified", user.emailVerified ? "Yes" : "No"),
        _buildUserInfoRow(
          "Last Sign-In",
          user.metadata.lastSignInTime?.toLocal().toString() ?? "Unknown",
        ),
        _buildUserInfoRow(
          "Account Created",
          user.metadata.creationTime?.toLocal().toString() ?? "Unknown",
        ),
      ],
    );
  }

  Widget _buildNoUserInfo() {
    return const Center(
      child: Text(
        "No user information available.",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
