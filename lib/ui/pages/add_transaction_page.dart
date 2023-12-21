import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({
    super.key,
  });

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _waktuController = TextEditingController();
  TextEditingController _shiftController = TextEditingController();
  TextEditingController _kodeMejaController = TextEditingController();
  TextEditingController _namaPelangganController = TextEditingController();
  TextEditingController _metodePembayaranController = TextEditingController();
  TextEditingController _namaMenuController = TextEditingController();
  TextEditingController _jumlahController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023, 1),
      lastDate: DateTime(2024, 12),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _tanggalController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        _waktuController.text = selectedTime.format(context);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _tanggalController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _waktuController,
                readOnly: true,
                onTap: () => _selectTime(context),
                decoration: InputDecoration(
                  labelText: 'Waktu',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _shiftController,
                decoration: InputDecoration(
                  labelText: 'Shift',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _kodeMejaController,
                decoration: InputDecoration(
                  labelText: 'Kode Meja',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _namaPelangganController,
                decoration: InputDecoration(
                  labelText: 'Nama Pelanggan',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _metodePembayaranController,
                decoration: InputDecoration(
                  labelText: 'Metode Pembayaran',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _namaMenuController,
                decoration: InputDecoration(
                  labelText: 'Nama Menu',
                  border: OutlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Aksi saat tombol "Simpan" ditekan
                  // Anda bisa mengambil nilai dari field-field ini dengan menggunakan
                  // _tanggalController.text, _waktuController.text, dst.
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
