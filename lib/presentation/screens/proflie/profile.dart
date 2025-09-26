import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy user data
    const String username = "JohnDoe99";
    const String email = "johndoe@example.com";
    const String avatarUrl = "https://i.pravatar.cc/150?img=5";
    const String favouriteClub = "Manchester United";

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile page
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            const SizedBox(height: 16),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Username",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "JohnDoe99",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  "Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "johndoe@example.com",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(Icons.sports_soccer),
                title: Text(
                  "Favourite Club",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "Manchester United",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const Spacer(),

            ElevatedButton.icon(
              onPressed: () {
                context.goNamed("login");
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
