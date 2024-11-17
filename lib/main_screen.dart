import 'package:dicoding_wisata_bandung/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_wisata_bandung/model/tourism_place.dart';

var infTxtStyle= const TextStyle(fontFamily: 'Futura', color: Colors.black, decoration: TextDecoration.none);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wisata Bandung. Size: ${MediaQuery.of(context).size.width}',
          style: infTxtStyle,
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return const TourismPlaceList();
          } else {
            return const TourismPlaceGrid();
          }
        },
      )
    );
  }
}

class TourismPlaceList extends StatelessWidget {
  const TourismPlaceList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final TourismPlace place = tourismPlaceList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => DetailScreen(place: place),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
          },
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image.asset(place.imageAsset),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          place.name,
                          style: infTxtStyle.copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(place.location),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: tourismPlaceList.length,
    );
  }
}

class TourismPlaceGrid extends StatelessWidget {
  const TourismPlaceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.count(
        crossAxisCount: 4,
        children: [
            Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              Expanded(
                child: Image.asset(
                tourismPlaceList[0].imageAsset,
                fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                tourismPlaceList[0].name,
                style: infTxtStyle.copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                tourismPlaceList[0].location,
                style: infTxtStyle,
                ),
              ),
              ],
            ),
            ),
        ],
      ),
    );
  }
}