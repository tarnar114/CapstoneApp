import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:go_router/go_router.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  var arr = [1, 2, 3];
  int index = 0;
  bool lastpage = false;
  List pages = <Widget>[pg1, pg2, pg3];
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
          child: Column(children: [
        Expanded(
          child: PageView.builder(
            itemBuilder: (context, index) {
              return pages[index];
            },
            onPageChanged: (value) {
              setState(() {
                index = value;
              });
              print("index " + index.toString());
              if (value == 2) {
                if (!lastpage) {
                  setState(() {
                    lastpage = true;
                  });
                }
              } else {
                if (lastpage) {
                  setState(() {
                    lastpage = false;
                  });
                }
              }
            },
            controller: _controller,
            itemCount: pages.length,
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SmoothPageIndicator(
            controller: _controller,
            count: pages.length,
            effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.lightBlue.shade700),
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                if (lastpage) {
                  GoRouter.of(context).go('/');
                } else {
                  _controller.animateToPage(index + 1,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeIn);
                }
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.lightBlue.shade700),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(Size(300, 60))),
              child: Text(
                lastpage ? "Scan" : "Next",
                style: GoogleFonts.cabin(
                    fontSize: 25, fontWeight: FontWeight.w500),
              )),
        ]),
        Container(
          padding: EdgeInsets.all(20),
        )
      ])),
    );
  }
}

Widget pg1 = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      margin: EdgeInsets.only(top: 50),
      child: Image.asset('assets/ONB-1.png'),
    ),
    Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
              child: Text(
            "Page 1",
            style: GoogleFonts.ralewayDots(
                fontSize: 30, fontWeight: FontWeight.w600),
          )),
          Container(
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur viverra lorem ligula",
              textAlign: TextAlign.center,
              style: GoogleFonts.cabin(
                  fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    ),
  ],
);
Widget pg2 = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 75),
      child: Image.asset('assets/Onboard-2.png'),
    ),
    Container(
      padding: EdgeInsets.only(top: 7),
      child: Column(
        children: [
          Text(
            "Page 2",
            style: GoogleFonts.ralewayDots(
                fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Container(
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur viverra lorem ligula",
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.cabin(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    ),
  ],
);
Widget pg3 = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 50),
      child: Image.asset('assets/ONB-3.png'),
    ),
    Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text(
            "Page 3",
            style: GoogleFonts.ralewayDots(
                fontSize: 30, fontWeight: FontWeight.w600),
          ),
          Container(
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur viverra lorem ligula",
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.cabin(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    ),
  ],
);
