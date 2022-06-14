import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sewa_digital/business_logic/bloc/policies/policies_bloc.dart';
import 'package:sewa_digital/constant/color_manager.dart';
import 'package:sewa_digital/constant/font_manager.dart';

class ReturnPolicy extends StatelessWidget {
  const ReturnPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Return Policy"),
      ),
      body: BlocBuilder<PoliciesBloc, PoliciesState>(
        builder: (context, state) {
          if (state is PoliciesError) {
            return Center(
              child: Text(state.message.toString()),
            );
          } else if (state is PoliciesLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Html(
                  shrinkWrap: true,
                  data: state.privacyResponse.data![0].content.toString(),
                  customRender: {
                    "table": (context, child) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: (context.tree as TableLayoutElement)
                            .toWidget(context),
                      );
                    }
                  },
                  style: {
                    "body": Style(
                        fontSize: FontSize.rem(0.978),
                        wordSpacing: 3,
                        textAlign: TextAlign.justify,
                        lineHeight: LineHeight.number(1.2),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorManager.white
                            : ColorManager.black,
                        fontFamily: FontConstants.fontFamily),
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
