import 'package:breezly/helpers/colors.dart';
import 'package:breezly/helpers/function.dart';
import 'package:breezly/helpers/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TableWidget extends StatefulWidget {
  final List<String> dates;
  final Map<String, List> data;
  const TableWidget({Key? key, required this.dates, required this.data})
      : super(key: key);

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  List<Widget> _buildCells(List data) {
    List<Widget> _widget = [];
    for (int i = 0; i < data.length; i++) {
      var _date = data[i].toString().split(' ');
      var day = _date[0];
      var month = _date[1];

      _widget.add(Container(
        alignment: Alignment.centerLeft,
        width: 30.0,
        height: 58.0,
        margin: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text(
              day,
              style: smallMediumFont().copyWith(
                fontSize: 18,
              ),
            ),
            Text(
              month,
              style: smallFont().copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ));
    }
    _widget.insert(0, const SizedBox(height: 30));
    return _widget;
  }

  List<Widget> _buildRows(Map data) {
    List<Widget> _widget = [];

    for (var key in data.keys) {
      List<dynamic> val = data[key];
      List<Widget> _tempWidget = [];

      // First we add header data
      _tempWidget.add(Container(
        alignment: Alignment.center,
        width: 50.0,
        // color: Colors.white,
        margin: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text(key,
                style: smallBoldFont()
                    .copyWith(fontSize: 12, color: Colors.black)),
          ],
        ),
      ));

      // Once done, add the data list according to time
      for (int i = 0; i < val.length; i++) {
        var mainData = val[i].toString();

        if (mainData == '-' || mainData == '') {
          _tempWidget.add(Container(
              alignment: Alignment.center,
              width: 50.0,
              height: 60.0,
              // color: Colors.white,
              margin: const EdgeInsets.all(4.0),
              child: const Text('')));
        } else {
          var _data = val[i].toString().split('|');
          var temp = _data[0];
          var desc = _data[1];

          var hour = key.split(':');
          var asset = getAssets(desc, hour: int.parse(hour[0]));

          _tempWidget.add(Container(
            alignment: Alignment.center,
            width: 50.0,
            height: 60.0,
            // color: Colors.white,
            margin: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/$asset.svg',
                  height: 30,
                  width: 30,
                ),
                //Text(val[i]),
                Text(temp + ' °C',
                    style: smallBoldFont()
                        .copyWith(fontSize: 12, color: purpleColor)),
              ],
            ),
          ));
        }
      }
      var _widgetx = Column(
        children: [..._tempWidget],
      );
      _widget.add(_widgetx);
    }

    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildCells(widget.dates),
            ),
            Container(
              height: 50 * 7,
              width: 1,
              color: Colors.black54.withOpacity(0.2),
            ),
            Flexible(
              child: Stack(children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildRows(widget.data),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 50 * 7,
                    width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [blueAccent.withOpacity(0.4), blueAccent],
                      ),
                    ),
                    //   color: Colors.purple.withOpacity(0.5),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
