import 'package:newsapp/data/models/news_model.dart';
import 'package:newsapp/data/services/repository_config.dart';

class NewsService {
  void getData({
    Function()? beforeSend,
    Function(List<NewsModel> data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final String url = "$baseUrl/v2/everything?q=apple&from=$startDate&to=$currentDate&sortBy=popularity&apiKey=$apiKey";
    APIRequest(url: url).get(
        beforeSend: () => {
              if (beforeSend != null) beforeSend(),
            },
        onSuccess: (data) => {
              onSuccess!((data["articles"] as List)
                  .map((e) => NewsModel.fromJson(e))
                  .toList())
            },
        onError: (error) => {
              if (error != null)
                {
                  onError!(error),
                }
            });
  }
}
