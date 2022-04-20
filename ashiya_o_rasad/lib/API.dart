import 'package:http/http.dart' as http;

Future getData(url) async {
  var url1 = Uri.parse(url);
  http.Response response = await http.get(url1);
  return response.body;
}