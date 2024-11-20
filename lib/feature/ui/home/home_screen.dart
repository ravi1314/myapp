part of 'home_import.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeRepo homeRepo = HomeRepo();
  var coffee = '☕'; // Emoji as a string
  var newspaper = '📰'; // Newspaper emoji as a string

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "Business",
              style: GoogleFonts.oldStandardTt(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24)),
            ),
            const Text(
              "Media",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Lottie.asset(
              'asset/image/chai.json',
              width: 90,
              height: 98,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Hey, update with us....$coffee',
                  style: GoogleFonts.overpass(
                      textStyle: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<NewsModel?>(
            future: homeRepo.getNews(),
            builder:
                (BuildContext context, AsyncSnapshot<NewsModel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while data is being fetched
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Handle any errors that occur
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data != null) {
                // Now checking if the articles list inside NewsModel is

                var articles = snapshot.data!.articles;

                if (articles.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        var newsItem = articles[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewsDetail(newsModel: newsItem)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 10,
                              child: Container(
                                height: 290,
                                width: 373,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsItem.title,
                                        style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    255, 13, 89, 219))),
                                      ),
                                      Expanded(
  child: Container(
    height: 160,
    width: 600,
    child: Material(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Image.network(
                  newsItem.urlToImage != null &&
                          newsItem.urlToImage!.startsWith('http')
                      ? newsItem.urlToImage!
                      : 'https://via.placeholder.com/600', // Provide a valid placeholder URL
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    // Fallback to a placeholder image in case of error
                    return Lottie.asset(
                      'asset/image/news.json',
                      width: 390,
                      height: 118,
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
  ),
),

                                      ListTile(
                                        title: Text(newsItem.author.toString()),
                                        subtitle:
                                            Text(newsItem.source.toString()),
                                        trailing: Text(
                                          newsItem.publishedAt != null
                                              ? DateFormat('yyyy-MM-dd').format(
                                                  newsItem
                                                      .publishedAt) // Format the date
                                              : 'No date available', // Fallback if date is null
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  // Handle the case where there are no articles
                  return const Center(child: Text('No news available.'));
                }
              } else {
                // Handle the case where there is no data
                return const Center(child: Text('No data available.'));
              }
            },
          ),
        ],
      ),
    );
  }
}
