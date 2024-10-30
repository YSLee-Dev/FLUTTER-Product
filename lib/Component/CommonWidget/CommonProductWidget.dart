import 'package:flutter/material.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'CommonText.dart';

class ComminProductWidget extends StatelessWidget {
  final ProductModel _sendedModel;
  ComminProductWidget({required ProductModel model}): _sendedModel = model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
      child: Row(
        children: [
          Image.network(
            '${_sendedModel.thumbnail}',
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return SizedBox(width: 120, height: 120, child: child);
              }
              return SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(),
              );
            },
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(2.5),
                  decoration: BoxDecoration(color: Color(0xfffcffcc).withOpacity(0.5), border: Border.all(color: Colors.black12, width: 0.5) ,borderRadius: BorderRadius.circular(5)),
                  child:   CommonText(text: '${_sendedModel.tags?.first ?? ""}', fontSize: 14, fontColor: Colors.black, fontWeight: FontWeight.w500,),
                ),
                CommonText(text: '${_sendedModel.title}', fontSize: 17, fontWeight: FontWeight.w700, maxLine: 3,),
                SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text
                      ("${((_sendedModel.price ?? 0.0) / ((100 - (_sendedModel.discountPercentage ?? 0.0)) / 100)).toStringAsFixed(2)}\$",
                        style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 13.5, color: Colors.redAccent)
                    ),
                    SizedBox(width: 10),
                    CommonText(text: '${_sendedModel.price}\$', fontSize: 15, fontWeight: FontWeight.w500),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
