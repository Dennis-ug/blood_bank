import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/size_gen.dart';

class DashView extends StatelessWidget {
  const DashView({super.key});

  @override
  Widget build(BuildContext context) {
    Sizing size = Sizing(context);
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: size.wyt(230),
            height: double.infinity,
            color: Color(0xffE0222B),
          ),
          Expanded(
            child: PageView(
              children: [
                Container(
                  // width: double.infinity,
                  // height: double.infinity,
                  child: Column(children: [
                    Row(
                      children: [
                        Image.asset('assets/user dp.png'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Clever Kim",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Branch Administrator",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff160304).withOpacity(0.4),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
