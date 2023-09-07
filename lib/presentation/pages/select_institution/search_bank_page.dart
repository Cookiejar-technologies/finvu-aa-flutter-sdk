import 'package:finvu_bank_pfm/core/utilities/labels.dart';
import 'package:finvu_bank_pfm/presentation/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/bank_model.dart';

class SearchBank extends SearchDelegate<Bank?>{

  List<Bank> banks;
  SearchBank({required this.banks});

  List<Bank> filter(){
    return List.from(banks.where((e) => e.fipName.toLowerCase().startsWith(query.toLowerCase())));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = "";
        },
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        query = "";
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: filter().length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index){
        return ListTile(
          onTap: (){
            close(context, filter()[index]);
            query = filter()[index].fipName;
          },
          leading: AppNetworkImage(url: filter()[index].entityLogoUri ?? "", fit: BoxFit.contain,),
          title: Text(filter()[index].fipName),
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: filter().length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index){
        return filter().isEmpty && query.isNotEmpty ? const Center(child: Text(Labels.noResultsFound),) : ListTile(
          onTap: (){
            close(context, filter()[index]);
            query = filter()[index].fipName;
          },
          leading: AppNetworkImage(url: filter()[index].entityLogoUri ?? "", fit: BoxFit.contain,),
          title: Text(filter()[index].fipName),
        );
      }
    );
  }

}