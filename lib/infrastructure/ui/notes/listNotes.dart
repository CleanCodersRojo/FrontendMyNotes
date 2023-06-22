import 'package:flutter/material.dart';

class listNotes extends StatelessWidget {
  const listNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "MyNotes";
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          title: Text(
            title,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  margin: const EdgeInsets.fromLTRB(10, 20, 30, 40),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 10.0,
                    children: [
                      ActionChip(
                        onPressed: () {},
                        label: const Text("Universidad"),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      ActionChip(
                        onPressed: () {},
                        label: const Text("Trabajo"),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      ActionChip(
                        onPressed: () {},
                        label: const Text("Hogar"),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  )),
              const Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _articles.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = _articles[index];
                    return Container(
                      height: 136,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text("${item.author} · ${item.postedOn}",
                                  style: Theme.of(context).textTheme.caption),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icons.bookmark_border_rounded,
                                  Icons.share,
                                  Icons.more_vert
                                ].map((e) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(e, size: 16),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          )),
                          Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(item.imageUrl),
                                  ))),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class Article {
  final String title;
  final String imageUrl;
  final String author;
  final String postedOn;

  Article(
      {required this.title,
      required this.imageUrl,
      required this.author,
      required this.postedOn});
}

final List<Article> _articles = [
  Article(
    title: "Nota Prueba 1",
    author: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla iaculis orci nec ligula iaculis, sit amet dictum dolor aliquet.",
    imageUrl: "https://picsum.photos/id/1000/960/540",
    postedOn: "Yesterday",
  ),
  Article(
      title: "Actividades semanales",
      imageUrl: "https://picsum.photos/id/1010/960/540",
      author: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla iaculis orci nec ligula iaculis, sit amet dictum dolor aliquet.",
      postedOn: "4 hours ago"),
  Article(
    title: "Lista de tareas",
    author: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla iaculis orci nec ligula iaculis, sit amet dictum dolor aliquet.",
    imageUrl: "https://picsum.photos/id/1001/960/540",
    postedOn: "2 days ago",
  )
];
