import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

const storage = FlutterSecureStorage();
// ignore: constant_identifier_names
const String SERVER_IP = 'http://192.168.15.239:3333';
Map? user;

Future<String> get jwtOrEmpty async {
  var jwt = await storage.read(key: "jwt");
  if (jwt == null) return '';
  return jwt;
}

Future<Map?> getUser(token) async {
  try {
    var res = await http.get(
      Uri.parse("$SERVER_IP/session/"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
    );
    if (res.statusCode == 200) {
      // print(res.body);
      var cjson = json.decode(res.body);
      return cjson;
    } else {
      return null;
    }
  } catch (error) {
    return null;
  }
}

Future<Map?> attemptLogIn(
  context, {
  required String username,
  required String password,
}) async {
  try {
    var body = {
      "username": username,
      "password": password,
    };
    var res = await http.post(
      Uri.parse("$SERVER_IP/session"),
      body: json.encode(body),
      headers: {'Content-Type': "application/json"},
    );
    if (res.statusCode == 200) {
      // print(res.body);
      var cjson = json.decode(res.body);
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<String?> getMesas(
  BuildContext context,
) async {
  var token = await storage.read(key: "jwt");
  try {
    var res = await http.get(
      Uri.parse("$SERVER_IP/tables/"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
    );
    if (res.statusCode == 200) {
      // print(res.body);
      var cjson = res.body;
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<String?> getContas(
  BuildContext context,
) async {
  var token = await storage.read(key: "jwt");
  try {
    var res = await http.get(
      Uri.parse("$SERVER_IP/bills/"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
    );
    if (res.statusCode == 200) {
      // print(res.body);
      var cjson = res.body;
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<String?> getPedidos(
  BuildContext context,
) async {
  var token = await storage.read(key: "jwt");
  try {
    var res = await http.get(
      Uri.parse("$SERVER_IP/orders/"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
    );
    if (res.statusCode == 200) {
      var cjson = res.body;
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<String?> getItens(
  BuildContext context,
) async {
  try {
    var res = await http.get(
      Uri.parse("$SERVER_IP/items/"),
      headers: {
        'Content-Type': "application/json",
      },
    );
    if (res.statusCode == 200) {
      var cjson = res.body;
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<String?> putPedidos(
  BuildContext context,
  Map order, [
  bool done = false,
]) async {
  var token = await storage.read(key: "jwt");
  print("///////////////////////////////////");
  print(order['ready']);
  print(done);
  var body = {
    'id': order['id'],
    'bill_id': order['bill_id'],
    'ready': true,
    'delivered': done,
    'order_date': order['order_date'],
    'active': order['active'],
  };
  try {
    var res = await http.put(
      Uri.parse("$SERVER_IP/orders/"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
      body: json.encode(body),
    );
    if (res.statusCode == 200) {
      // print(res.body);
      var cjson = res.body;
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<String?> createContas(BuildContext context, Map table) async {
  var token = await storage.read(key: "jwt");
  Map body = {
    'table_id': '${table['id']}',
    'total_value': 0,
    'active': true,
  };
  try {
    var res = await http.post(
      Uri.parse("$SERVER_IP/bills/"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
      body: json.encode(body),
    );
    if (res.statusCode == 200) {
      // print(res.body);
      var cjson = res.body;
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<String?> createOrder(
  BuildContext context,
  List<Map> items,
  String table,
) async {
  var token = await storage.read(key: "jwt");
  Map body = {
    'table_id': table,
    'items': items,
    'active': true,
    'ready': false,
    'delivered': false,
  };
  try {
    var res = await http.post(
      Uri.parse("$SERVER_IP/orders/"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
      body: json.encode(body),
    );

    if (res.statusCode == 200) {
      // print(res.body);
      var cjson = res.body;
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<List?> getOrderItems(
  BuildContext context,
  String orderId,
) async {
  var token = await storage.read(key: "jwt");
  try {
    var res = await http.get(
      Uri.parse("$SERVER_IP/orderitem/byOrder/$orderId"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
    );

    if (res.statusCode == 200) {
      // print(res.body);
      var cjson = json.decode(res.body);
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<Map?> putMesas(
  BuildContext context,
  Map table,
  String lugares,
) async {
  var token = await storage.read(key: "jwt");
  var body = table;
  body['seats'] = lugares;
  try {
    var res = await http.put(
      Uri.parse("$SERVER_IP/tables/"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
      body: json.encode(body),
    );
    if (res.statusCode == 200) {
      print(res.body);
      var cjson = json.decode(res.body);
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<List?> getOrderItemsByBill(
  BuildContext context,
  String id,
) async {
  var token = await storage.read(key: "jwt");
  try {
    var res = await http.get(
      Uri.parse("$SERVER_IP/orderitem/byBill/$id"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
    );
    if (res.statusCode == 200) {
      print(res.body);
      var cjson = json.decode(res.body);
      return cjson;
    } else {
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

Future<Map?> closeBill(
  BuildContext context,
  String id,
) async {
  var token = await storage.read(key: "jwt");
  var body = {'bill_id': id};
  try {
    var res = await http.post(
      Uri.parse("$SERVER_IP/bills/closeBill"),
      headers: {
        'Content-Type': "application/json",
        'Authorization': 'bearer $token',
      },
      body: json.encode(body),
    );
    if (res.statusCode == 200) {
      print('res.body status 200');
      print(res.body);
      var cjson = json.decode(res.body);
      return cjson;
    } else {
      print('res.body status error');
      print(res.body);
      var cjson = json.decode(res.body);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(cjson['error'] ?? 'Ocorreu um erro'),
          ),
        );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$error'),
        ),
      );
    return null;
  }
}

processLogout(context) {
  storage.delete(key: 'jwt');
  storage.delete(key: 'user');
  Navigator.pushNamed(context, '/first');
}
