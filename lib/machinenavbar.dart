import 'package:flutter/material.dart';


class NavBarM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            ListTile(
                iconColor: Colors.green,
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                 // Navigator.push(context,
                    //  MaterialPageRoute(builder: (context) => EditMachine()));
                }
            ),
            ListTile(
              iconColor: Colors.green,
              leading: Icon(Icons.delete),
              title: Text('Delete'),
              onTap: () => null,
            ),
            //
          ],
        ),
      ),
    );
  }
}