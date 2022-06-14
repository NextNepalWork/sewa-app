import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sewa_digital/business_logic/bloc/faq/faq_bloc.dart';
import 'package:sewa_digital/constant/value_manager.dart';
import 'package:sewa_digital/data/repo/faq_repo.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
      ),
      body: BlocProvider(
        create: (context) => FAQBloc(RealFAQRepo())..add(GetFAQ()),
        child: BlocBuilder<FAQBloc, FAQState>(
          builder: (context, state) {
            if (state is FAQError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is FAQLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(state.response.data!.length, (index) {
                    final faqData = state.response.data![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppMargin.m10, vertical: AppMargin.m5),
                      elevation: 0,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(
                            faqData.title.toString(),
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          childrenPadding:
                              const EdgeInsets.only(left: AppPadding.p10),
                          children: [
                            Html(data: faqData.description.toString()),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
