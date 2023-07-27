import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blood_stock/blood_in.dart';
import '../blood_stock/blood_out.dart';
import '../dash/dash.dart';
import '../stations/station.dart';

class PagesView extends StatefulWidget {
  PagesView({super.key});

  @override
  State<PagesView> createState() => _PagesViewState();
}

class _PagesViewState extends State<PagesView> {
  List<String> pageLabel = ['Home', 'Blood in', 'Blood out'];

  var _controller = PageController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Container(
              width: 120,
              decoration: const BoxDecoration(
                color: Color(0xffE0222B),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    pageLabel.length,
                    (index) => GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(index);
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              height: 20,
                              width: 5,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              duration: const Duration(milliseconds: 500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              pageLabel[index],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: [
                  const DashView(),
                  // const StationsView(),
                  BloodInflow(),
                  BloodOutflow(),
                ],

                // scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
