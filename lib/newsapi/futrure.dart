import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/newsapi/newsApi.dart';
import 'package:news/newsapi/newsContents.dart';
import 'package:provider/provider.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class StateWd extends StatelessWidget {
  const StateWd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsCategory(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NeWs'),
        ),
        drawer: AppDrawer(),
        body: NewsList(),
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsCategory = Provider.of<NewsCategory>(context);
    final newsApi = NewsApi(newsCategory.selectedCategory, "everything");

    return StreamBuilder<List<NewsArticle>>(
      stream: newsApi.fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          );
        } else {
          final articles = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) {
              final article = articles![index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  constraints: BoxConstraints(minHeight: 200),
                  decoration: containerdecor(),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NewsWeb(
                                url: article.Nurl, title: article.title);
                          },
                        ));
                      },
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          imageFoundOrNot(article.imageUrl),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              article.title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: articles?.length ?? 0,
            padding: EdgeInsets.all(0.8),
          );
        }
      },
    );
  }

  Widget imageFoundOrNot(String pathToImage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Image(
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
        image: NetworkImage(
          pathToImage,
        ),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return ClipRRect(
            child: Image.asset(
              'assetImage/OIP.png',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            borderRadius: BorderRadius.circular(22),
          );
        },
      ),
    );

    //print(pathToImage);
  }

  containerdecor() {
    return BoxDecoration(borderRadius: BorderRadius.circular(22), boxShadow: const [
      BoxShadow(
        color: Color.fromARGB(106, 197, 195, 195),
        spreadRadius: 1,
        blurRadius: 1,
      ),
    ]);
  }
  //######???
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsCategory = Provider.of<NewsCategory>(context);

    return Drawer(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15))),
      //shape: BoxBorder,
      width: 230,
      backgroundColor: Colors.grey[100],
      child: ListView(
        padding: EdgeInsets.all(0.2),
        children: [
          DrawerHeader(
            child: Container(
              height: 200,
              child: Center(
                child: Text(
                  'NeWs',
                  style: TextStyle(fontSize: 25, wordSpacing: 10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('Top Headline'),
            onTap: () {
              newsCategory.selectedCategory = 'international';
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Sports'),
            onTap: () {
              newsCategory.selectedCategory = 'sports';
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Politics'),
            onTap: () {
              newsCategory.selectedCategory = 'politics';
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Technology'),
            onTap: () {
              newsCategory.selectedCategory = 'technology';
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              heightFactor: 5,
              child: TextButton(
                onPressed: () {
                  showPopupWindow(
                    gravity: KumiPopupGravity.center,
                    context,
                    childSize: Size(200, 200),
                    childFun: (popup) {
                      return SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              radius: 50,
                              child: Text(
                                'NeWs',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),const SizedBox(height: 50,),
                            Center(
                              child: Container(width: 260,decoration: BoxDecoration(borderRadius: BorderRadius.circular(22),color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style.copyWith(height: 1.5),
                                      children: const <TextSpan>[
                                        TextSpan(
                                          text: 'NewsApp',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text:
                                              ' is a Flutter application developed by '),TextSpan(
                                          text: 'MOHAMMED FAWAZ ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),TextSpan(text:'a skilled Flutter developer. The app efficiently fetches and displays up-to-date news articles from various categories using the News API.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text("About"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCategory extends ChangeNotifier {
  String _selectedCategory = "international";

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
