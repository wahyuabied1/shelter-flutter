import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            title: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?cs=srgb&dl=pexels-sulimansallehi-1704488.jpg&fm=jpg', // Replace with an actual image URL
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text(
                              "Justinus William",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            width: 220,
                            child: Table(children: const [
                              TableRow(
                                children: [
                                  Text(
                                    "justinuswilliam",
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                  Text("· KRY-001",style:
                                    TextStyle(fontSize: 12, color: Colors.black87)),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text(
                                    "Departemen",
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                  Text(
                                    ": Keamanan",
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black87),
                                  )
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text(
                                    "Jabatan",
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                  Text(
                                    ": Staff",
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text(
                                    "Grup/Template",
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                  Text(
                                    ": Tim Keamanan",
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Text(
                                    "Site",
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                  Text(
                                    ": AMERTA INDAH OTSUKA KEJAYAN",
                                    style:
                                    TextStyle(fontSize: 12, color: Colors.black87),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: [
              Container(
                margin: EdgeInsets.all(12),
                child: Table(
                    border: TableBorder.all(color: Colors.grey),
                    children: const [
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Hari",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Jam",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Senin, Rabu, Jumat"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("08.00 - 16.00"),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Selasa, Kamis, Rabu"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("19.00 - 23.00"),
                          ),
                        ],
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
