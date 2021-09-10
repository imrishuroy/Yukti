import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:yukti/models/google_form.dart';

class FormExpansionTile extends StatefulWidget {
  final GlobalObjectKey<ExpansionTileCardState> cardKey;

  final GoogleForms? form;

  const FormExpansionTile({Key? key, required this.cardKey, required this.form})
      : super(key: key);

  @override
  State<FormExpansionTile> createState() => _FormExpansionTileState();
}

class _FormExpansionTileState extends State<FormExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: ExpansionTileCard(
        key: widget.cardKey,
        // leading: CircleAvatar(child: Text('A')),
        title: Text(
          '${widget.form?.title ?? 'N/A'}',
          style: TextStyle(fontSize: 17.0),
        ),
        // subtitle: Text(
        //   _isExpanded ? '' : '${widget.form?.description ?? 'N/A'}',
        //   style: TextStyle(
        //     color: Colors.grey.shade700,
        //   ),
        //   maxLines: 1,
        //   overflow: TextOverflow.fade,
        // ),
        subtitle: Text(
          '${widget.form?.dateTime.toIso8601String()}',
          style: TextStyle(
            color: Colors.grey.shade700,
          ),
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),

        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                '${widget.form?.description}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 52.0,
            buttonMinWidth: 90.0,
            children: <Widget>[
              TextButton(
                style: buttonStyle,
                onPressed: () {
                  widget.cardKey.currentState?.expand();
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                  print('is Expanded $_isExpanded');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_downward),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Open'),
                  ],
                ),
              ),
              TextButton(
                style: buttonStyle,
                onPressed: () {
                  widget.cardKey.currentState?.collapse();
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                  print('is Expanded $_isExpanded');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_upward),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Close'),
                  ],
                ),
              ),
              TextButton(
                style: buttonStyle,
                onPressed: () {
                  widget.cardKey.currentState?.toggleExpansion();

                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                  print('is Expanded $_isExpanded');
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.swap_vert),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Text('Toggle'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
