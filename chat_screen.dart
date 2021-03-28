import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FlutterChat'),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).backgroundColor,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (itemidentifier) {
                if (itemidentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('chats/df8dTJdkEoT4pRPtmUp4/messages')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = snapshot.data.documents;
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      child: Text(documents[index]['text']),
                    );
                  });
            }
            ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.red[800],
            onPressed: () {
              Firestore.instance
                  .collection('chats/df8dTJdkEoT4pRPtmUp4/messages')
                  .add({'text': 'this is my first backend project'});
            }));
  }
}
