import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yukti/models/assignment.dart';

class AssignmentTile extends StatelessWidget {
  final Assignment? assignment;

  const AssignmentTile({Key? key, this.assignment}) : super(key: key);
  Future<void> _launchInBrowser({String? url, BuildContext? context}) async {
    try {
      if (url != null) {
        await launch(url);
        // }

        // if (await canLaunch(url!)) {
        //   await launch(
        //     url,
        //     forceSafariVC: false,
        //     forceWebView: false,
        //     headers: <String, String>{'my_header_key': 'my_header_value'},
        //   );
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      // print(error);
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'No file available',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 4.0,
      ),
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Container(
            color: Color.fromRGBO(255, 203, 0, 1),
            height: 60.0,
            width: 60.0,
            child: Center(
              child: Text(
                '${assignment?.subCode?.toUpperCase()}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          title: Text(
            '${assignment?.subName}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${assignment?.name}'),
              SizedBox(height: 0.8),
              Row(
                children: [
                  Text('Last Date : '),
                  Text(
                    '${assignment?.date}',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0)
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ElevatedButton(
              onPressed: () =>
                  _launchInBrowser(url: assignment?.link, context: context),
              child: Text(
                'Download',
                style: TextStyle(
                  fontSize: 12.5,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
