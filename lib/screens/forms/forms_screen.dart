import 'package:flutter/material.dart';

import 'submitted_form.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          automaticallyImplyLeading: false,
          title: Text('Forms'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Color(0XFF00286E),
            indicatorWeight: 3.0,
            tabs: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.feed),
                  const SizedBox(width: 10.0),
                  const Text(
                    'Submitted',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.feed),
                  const SizedBox(width: 10.0),
                  const Text(
                    'UnSubmitted',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SubmittedForm(),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
