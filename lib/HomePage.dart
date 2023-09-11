import 'package:flutter/material.dart';
import 'package:list/product.dart';


class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();

  int index = 0;

  List tableWidgets = [
    "",
    const Text(
      'cart',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    const Text(
      'profile',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
  ];

  List<Books> bookList = [
    Books('book1', 'Novels', 'price:150', true),
    Books('book2', 'Adu jeevitham', 'price:250', false),
    Books('book3', 'Benyamin', 'price:200', false),
    Books('book4', 'Janu', 'price:100', true),
    Books('book5', 'Mathilukal', 'price:300', true),
    Books('book6', 'Pathumayude Adu', 'price:300', false),
    Books('book07', 'Vijayapatham', 'price:200', false),
    Books('book08', 'Mittayi theruv', 'price:350', true),
  ];

  // Create a list to store the filtered book titles.
  List<String> filteredBookList = [];

  @override
  void initState() {
    super.initState();

    // Initialize the filteredBookList with all book titles.
    filteredBookList = bookList.map((book) => book.mainText).toList();
  }

  // Function to filter and update the book list based on the search query.
  void itemsSearchedResults(String query) {
    List<String> searchResults = filteredBookList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredBookList = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          'Books',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.yellow[200],
        actions: [
          SizedBox(
            height: 5,
            width: 330,
            child: TextField(
              onChanged: (value) {
                // Handle filtering and resetting when the search bar changes.
                if (value.isEmpty) {
                  // If the search bar is empty, reset the filteredBookList.
                  setState(() {
                    filteredBookList =
                        bookList.map((book) => book.mainText).toList();
                  });
                } else {
                  // Otherwise, filter the list based on the search query.
                  itemsSearchedResults(value);
                }
              },
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'search..',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    // Clear the search bar and reset the filtered list.
                    _searchController.clear();
                    setState(() {
                      filteredBookList =
                          bookList.map((book) => book.mainText).toList();
                    });
                  },
                ),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {},
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              child: Text(
                'Book',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('home'),
              onTap: () {
                setState(() {
                  index = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_cart_outlined,
              ),
              title: const Text('cart'),
              onTap: () {
                setState(() {
                  index = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: const Text('profile'),
              onTap: () {
                setState(() {
                  index = 2;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: index == 0 ? home() : tableWidgets[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.yellow[200],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "CART"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
        ],
        currentIndex: index,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (int val) {
          setState(() {
            index = val;
          });
        },
      ),
    );
  }

  // Function to build the home screen.
  Widget home() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      height: MediaQuery.of(context).size.height,
      color: Colors.yellow[200],
      child: GridView.builder(
        itemCount: filteredBookList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          // Build a list of filtered book titles here.
          final book = bookList.firstWhere(
                (element) => element.mainText == filteredBookList[index],
            orElse: () => Books('', '', '', false), // A placeholder if not found.
          );

          return getExpanded(
            book.image,
            book.mainText,
            book.subText,
            book.offer,
          );
        },
      ),
    );
  }

  Widget getExpanded(
      String image,
      String mainText,
      String subText,
      bool visibility,
      ) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(
          left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: visibility,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '-50%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 3.0,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Product(
                    image: image,
                    mainText: mainText,
                    subText: subText,
                    offer: true,
                  )));
            },
            child: Image.asset(
              "assets/image/$image.jpeg",
              height: 100,
            ),
          ),
          const SizedBox(
            height: 1.0,
          ),
          Text(
            mainText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 0,
          ),
          Text(
            subText,
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

class Books {
  String image;
  String mainText;
  String subText;
  bool offer;
  Books(this.image, this.mainText, this.subText, this.offer);
}