import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:videowall/models/videowall_model.dart';

class XVideosApi {
  Future<VideowallModel> getVideo(String query) async {
    var baseUrl =
        'https://cors-anywhere.herokuapp.com/https://www.xvideos.com/?k=$query';

    var client = Client();
    Response response = await client.get(baseUrl);
    Document document = parse(response.body);

    Element container = document.querySelector("#content");

    List<Element> pageLinks =
        container.querySelectorAll('div.thumb-inside > div.thumb > a');

    pageLinks.shuffle();

    try {
      var videoPageUrl =
          'https://cors-anywhere.herokuapp.com/https://www.xvideos.com/' +
              pageLinks.first.attributes['href'];

      response = await client.get(videoPageUrl);
      document = parse(response.body);
      Element videoplayer =
          document.querySelectorAll("#video-player-bg > script").elementAt(3);

      var regExp = new RegExp(r"setVideoUrlHigh\('(.*?)'\)");

      // poor mans solution.. but i hate regex
      String videourl = regExp.stringMatch(videoplayer.innerHtml.toString());
      videourl = videourl.substring(17, videourl.length - 2);

      print('XXvideos: ' + videourl);
      return new VideowallModel(videourl: videourl);
    } catch (e) {
      print('!!! XVideos API error reading video URLs\n');
    }

    return VideowallModel();
  }
}
