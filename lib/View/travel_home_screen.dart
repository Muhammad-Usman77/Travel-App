import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:travelui/Model/destination_model.dart';
import 'package:travelui/Utils/const.dart';
import 'package:travelui/View/travel_detal_page.dart';

class TravelHomeScreen extends StatefulWidget {
  const TravelHomeScreen({super.key});

  @override
  State<TravelHomeScreen> createState() => _TravelHomeScreenState();
}

class _TravelHomeScreenState extends State<TravelHomeScreen> {
  String category = 'Popular';
  List<Destination> myDestination = destinations;
  int selectedIndex = 0;
  List<Destination> mDestination = destinations;
  List<IconData> icons = [
    Icons.home_rounded,
    Icons.location_on_rounded,
    Icons.bookmark_outline_rounded,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              headerPart(),
              SizedBox(
                height: size.height * 0.03,
              ),
              searchBar(),
              // const SizedBox(
              //   height: 30,
              // ),
              exploreCities(),
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
              categorySelection(),
              cardSwiper(size),
            ],
          ),
        ),
        bottomSheet: BottomNavigationBar(
            backgroundColor: Colors.white,
            iconSize: 30,
            unselectedItemColor: Colors.black26,
            selectedItemColor: Colors.lightBlue,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            items: [
              ...List.generate(
                  icons.length,
                  (index) => BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Icon(icons[index]),
                          const SizedBox(
                            height: 5,
                          ),
                          selectedIndex == index
                              ? Container(
                                  height: 5,
                                  width: 5,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      label: ""))
            ]),
      ),
    );
  }

  Container cardSwiper(Size size) {
    return Container(
      height: size.height * 0.51,
      padding: const EdgeInsets.only(top: 10, bottom: 2, right: 10, left: 20),
      child: Swiper(
        itemCount: myDestination.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        axisDirection: AxisDirection.right,
        onTap: (index) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      TravelDetalPage(destination: myDestination[index])));
        },
        loop: true,
        itemBuilder: (contex, index) {
          final travel = myDestination[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(travel.image!))),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              travel.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 14,
                                  color: Colors.blue[300],
                                ),
                                Text(
                                  travel.location!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue[300],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 25,
                            width: 220,
                            child: Stack(
                              children: [
                                Positioned(
                                    left: -20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 270,
                                          child: DottedLine(
                                            dashColor:
                                                Colors.grey.withOpacity(0.4),
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "\$${travel.price}/",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Person",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.shade50),
                              child: const Icon(
                                Icons.bookmark_outline,
                                color: blue,
                                size: 23,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView categorySelection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              categories.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            category = categories[index];
                            category == "Popular"
                                ? myDestination = destinations
                                : myDestination = destinations
                                    .where(
                                      (element) =>
                                          element.category!.toLowerCase() ==
                                          categories[index].toLowerCase(),
                                    )
                                    .toList();
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: category == categories[index]
                              ? Colors.blue
                              : Colors.white,
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                              color: category == categories[index]
                                  ? Colors.white
                                  : Colors.grey[400]),
                        ),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }

  Padding exploreCities() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Explore Cities",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Text(
                'All',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
              Icon(Icons.arrow_right_rounded),
            ],
          )
        ],
      ),
    );
  }

  Padding headerPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Sophia 👏',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'Explore Beautiful World ',
                style: TextStyle(),
              ),
            ],
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.amber[100],
                backgroundImage: const NetworkImage(
                    'https://photos.peopleimages.com/picture/202306/2829749-influencer-fashion-and-selfie-on-an-isolated-and-transparent-png-background-for-social-media-profile-picture-or-video-call.-smile-happy-woman-or-model-on-photography-in-blogging-fit_400_400.jpg'),
              ),
              const Positioned(
                  right: 3,
                  top: 5,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.amber,
                  ))
            ],
          )
        ],
      ),
    );
  }

  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
                hintText: 'Search Place',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                hintStyle: const TextStyle(fontSize: 15, color: Colors.black26),
                contentPadding: const EdgeInsets.all(20),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20))),
          )),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.tune,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
