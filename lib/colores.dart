import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Vista2 extends StatefulWidget {
  const Vista2({Key? key}) : super(key: key);

  @override
  State<Vista2> createState() => _Vista2State();
}

class _Vista2State extends State<Vista2> {
  late List<dynamic> _data = [];
  late int _colorIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://nrweb.com.mx/api_prueba/colores.php'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _data = jsonData['respuesta2'];
      });
    } else if (response.statusCode == 404) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Objeto no encontrado'),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('URL Error de sintaxis'),
        ),
      );
    }
  }

  Color getNextColor() {
    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
    ];
    final Color color = colors[_colorIndex];
    _colorIndex = (_colorIndex + 1) % colors.length;
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vista 2')),
      body: _data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          final item = _data[index];
          final nombre = item['nombre_user'];
          final edad = item['edad'];

          return ListTile(
            title: Text('$nombre - Edad: $edad'),
            tileColor: getNextColor(),
          );
        },
      ),
    );
  }
}
