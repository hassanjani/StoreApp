import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_app/api_services.dart';
import 'package:user_app/banner_model22.dart';
import 'package:user_app/data/model/response/base/api_response.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  List<BannerModel22> list = [];
  bool listcheck = false;
  getDataHere() async {
    print('check screen');
    list = await ApiServicesClass().getData(list);
    print(list.length);
    print('done');
    setState(() {
      listcheck = true;
    });
    print(list[0].price);
    print(list[1].price);
  }

  @override
  void initState() {
    super.initState();
    getDataHere();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('check'),
        ),
        body: listcheck
            ? ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      // InkWell(
                      // onTap: () {},
                      // child: Container(
                      //   alignment: Alignment.bottomCenter,
                      //   height: 150,
                      //   width: 70,
                      //   decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //     image: NetworkImage(
                      //         'https://alhafizcloth.com/100min/storage/app/public/banner/store/' +
                      //             // 'https://alhafizcloth.com/100min/storage/app/public/product/store/thumbnail/2021-11-10-618b67c004a3b.png' +
                      //             list[i].photo),
                      //     fit: BoxFit.cover,
                      //   )),
                      //   child:
                      Text(
                        list[i].price.toString(),
                        // style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.white),
                        // ),
                        // ),
                      )
                    ],
                  );
                })
            : Text('Loading'));
  }
}
