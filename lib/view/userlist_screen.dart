import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/user_service.dart';
import 'login_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserService _userService = UserService();

  List<User> userList = [];

  @override
  void initState() {
    super.initState();

    _userService.getUserList().then((value) {
      userList = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async{
              await _userService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              userList = await _userService.getUserList();
              setState(() {});
            },
          ),
        ],
      ),
      body: userList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :
        ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${userList[index].first_name} ${userList[index].last_name}'),
              subtitle: Text('${userList[index].email}'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage('${userList[index].avatar}'),
              ),
            );
          }),
    );
  }
}
