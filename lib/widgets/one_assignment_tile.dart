import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentTile extends StatelessWidget {
  final String? subCode;
  final String? subName;
  final String? assignmentName;
  final String? downloadLink;
  final String? date;

  const AssignmentTile({
    Key? key,
    this.date,
    this.subCode,
    this.subName,
    this.assignmentName,
    this.downloadLink,
  }) : super(key: key);

  Future<void> _launchInBrowser({String? url, BuildContext? context}) async {
    try {
      if (await canLaunch(url!)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );
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
        horizontal: 10.0,
        // vertical: 5.0,
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
                '${subCode?.toUpperCase()}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          title: Text(
            '$subName',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$assignmentName'),
              SizedBox(height: 0.8),
              Row(
                children: [
                  Text('Last Date : '),
                  Text(
                    '$date',
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
          trailing: SizedBox(
            width: 100.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.cloud_upload, color: Colors.lightBlueAccent,
                    //color: Colors.orange,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.download_rounded,
                    color: Colors.green,
                  ),
                  onPressed: () =>
                      _launchInBrowser(url: downloadLink!, context: context),
                ),
              ],
            ),
          ),

          //  ElevatedButton(
          //   onPressed: () =>
          //       _launchInBrowser(url: downloadLink!, context: context),
          //   child: Text(
          //     'Download',
          //     style: TextStyle(
          //       fontSize: 12.5,
          //       letterSpacing: 1.2,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
        ),
      ),
      //  ),
    );
  }
}
