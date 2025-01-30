import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PresenceLogScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Date Range Filters
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Tanggal Mulai',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Tanggal Berakhir',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          // Export Button
          ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download),
                SizedBox(width: 8.0),
                Text('Export Laporan Presensi'),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // Filters Dropdown
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(child: Text('Departemen 1'), value: '1'),
                    DropdownMenuItem(child: Text('Departemen 2'), value: '2'),
                  ],
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Departemen',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(child: Text('Jabatan 1'), value: '1'),
                    DropdownMenuItem(child: Text('Jabatan 2'), value: '2'),
                  ],
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Jabatan',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(child: Text('15'), value: '15'),
                    DropdownMenuItem(child: Text('30'), value: '30'),
                  ],
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Jumlah Karyawan',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          // Employee Cards
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/avatar.png'),
                              radius: 24.0,
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Abdul Rahman Hakim',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                                Text('abdulrahmanh • Staff Keamanan'),
                              ],
                            ),
                            Spacer(),
                            Text('KRY-002',
                                style: TextStyle(
                                    color: Colors.grey, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatusCard('Hadir', '16', Colors.green),
                            _buildStatusCard('Terlambat', '4', Colors.orange),
                            _buildStatusCard('Cuti', '2', Colors.blue),
                            _buildStatusCard('Izin', '2', Colors.purple),
                            _buildStatusCard('Sakit', '2', Colors.red),
                            _buildStatusCard('Alpha', '0', Colors.grey),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {},
                          child: Text('Lihat Detail',
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(String label, String count, Color color) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 12.0)),
      ],
    );
  }

}