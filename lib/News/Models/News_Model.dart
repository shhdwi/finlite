class Source{
  dynamic id;
  String name;
  Source({this.id="",this.name=""});
  factory Source.fromJson(Map <String,dynamic> json){
        return Source(id: json["id"],name: json["name"]);
  }

}


class NewsData {
  dynamic source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  NewsData(
      {this.source,
        this.author="",
        this.title="",
        this.description="",
        this.url="",
        this.urlToImage="https://images.unsplash.com/photo-1623921555510-70458f621816?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80",
        this.publishedAt="",
        this.content="No content Available"});
  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      source: Source.fromJson(json['source']),
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String,
    );
  }
}