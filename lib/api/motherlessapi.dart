import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:videowall/models/videowall_model.dart';

class MotherlessApi {
  Future<VideowallModel> getVideo(String query) async {
    var baseUrl =
        'https://cors-anywhere.herokuapp.com/http://www.motherless.com/term/videos/$query?page=1';

    var client = Client();
    Response response = await client.get(baseUrl);
    Document document = parse(response.body);

    List<Element> pageLinks = document.querySelectorAll(
        'div.browse > div.content-wrapper > div.content-inner > div.thumb-container > div.desktop-thumb > a');

    pageLinks.shuffle();

    try {
      var videoPageUrl = 'https://cors-anywhere.herokuapp.com/' +
          pageLinks.first.attributes['href'];

      response = await client.get(videoPageUrl);
      document = parse(response.body);

      Element videoplayer = document.querySelector("#content > script");

      var videourl = videoplayer.innerHtml.substring(
          videoplayer.innerHtml.indexOf('__fileurl = \'') + 13,
          videoplayer.innerHtml.indexOf('\$') - 7);

      print(videourl);

      return new VideowallModel(videourl: videourl);
    } catch (e) {
      print('!!! Motherless API error reading video URLs\n');
    }
    return VideowallModel();
  }
}
