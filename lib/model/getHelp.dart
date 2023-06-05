import 'package:flutter/material.dart';

class GetHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Help'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.headline6,
            ),
            ListTile(
              title: Text('How do I reset my password?'),
              subtitle: Text(
                  'Click on "Forgot Password" at the login page, and enter your registered Email. You will receive a link to reset your password.'),
            ),
            ListTile(
              title: Text('Can I change my email?'),
              subtitle: Text(
                  'You can change your email by going to Account Settings and updating your email.'),
            ),
            SizedBox(height: 20),
            Text(
              'Tips & Tutorials',
              style: Theme.of(context).textTheme.headline6,
            ),
            ListTile(
              title: Text('Getting Started Guide'),
              subtitle: Text(
                  'Check out our getting started guide to learn the basics of using our app.'),
            ),
            ListTile(
              title: Text('Tutorial Videos'),
              subtitle: Text(
                  'Visit our YouTube channel for tutorials on how to make the most of our app.'),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.headline6,
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(
                'For any further queries, feel free to reach out to us at m2d.khial@gmail.com.',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                // Implement functionality to send an email
              },
            ),
          ],
        ),
      ),
    );
  }
}
