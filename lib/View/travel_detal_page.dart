import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:travelui/Model/destination_model.dart';
import 'package:travelui/Utils/const.dart';

class TravelDetalPage extends StatelessWidget {
  Destination destination;
  TravelDetalPage({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    destination.image!,
                    height: MediaQuery.of(context).size.height * 0.5,
                    fit: BoxFit.cover,
                  ),
                ),
                //for back button and bookmark
                backButton(context)
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination.name!,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            tripMembers()
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 25,
                                color: lightblue,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${destination.rate}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  descriptionAbout(),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Facilities',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              'All',
                              style: TextStyle(
                                fontSize: 14,
                                color: blue,
                              ),
                            ),
                            Icon(
                              Icons.arrow_right_rounded,
                              color: blue,
                              size: 25,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // const SizedBox(height: 10),
                  faciliDetailpage(context)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: bookNow(),
    );
  }

  FloatingActionButton bookNow() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.white,
      elevation: 0,
      onPressed: () {},
      label: Row(
        children: [
          Text.rich(TextSpan(
              text: "Price\n",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: '\$${destination.price}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ])),
          const SizedBox(
            width: 40,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: const Row(
              children: [
                Text(
                  "Book Bow",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding faciliDetailpage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
              destination.facilities!.length,
              (index) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: MediaQuery.of(context).size.width * 0.2,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: blue[50],
                          ),
                          child: Image.asset(
                            destination.facilities![index].image,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          destination.facilities![index].text,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ],
                    ),
                  ))
        ],
      ),
    );
  }

  Padding descriptionAbout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ReadMoreText(
        destination.description!,
        trimCollapsedText: "Read more",
        trimExpandedText: 'Show less',
        colorClickableText: Colors.lightBlue,
        trimMode: TrimMode.Length,
        trimLength: 120,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
          height: 1.5,
        ),
      ),
    );
  }

  Row tripMembers() {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 70,
          child: Stack(
            children: [
              ...List.generate(
                destination.members!.length > 3
                    ? 3
                    : destination.members!.length,
                (index) => Positioned(
                  left: index * 15,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(destination.members![index]),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
        const Text(
          "+20 trip members",
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  SafeArea backButton(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.arrow_back_ios_rounded),
            ),
          ),
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.bookmark_outline_rounded,
              color: Colors.blue,
            ),
          )
        ],
      ),
    ));
  }
}
