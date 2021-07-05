import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: 'BMI app',
  theme: ThemeData(primarySwatch: Colors.deepOrange),
  debugShowCheckedModeBanner: false,
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //define state variable

  String weight = '0';
  String height = '0';
  String date = '';
  double age = 30;
  //Radio Button
  var gender = ['Male', 'Female'];
  int index = 0;

  //dropdownbutton
  var fitOption = [
    '1 time',
    '2 times',
    '3 times',
    '4 times',
    '5 times',
    '6 times'
  ];

  String fit = '1 time';

  double bmi;
  String status;

  List<Reading> data = []; // to save each reading (data source of ListView)

  var txtStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI App'),
      ),
      body: ListView(
        //  physics: ScrollPhysics(),
          children:[ Column(
            children: [
              row1(),
              row2(),
              row3(),
              row4(),
              row5(),
              row6(),
              row7(),
              row8(),
              row9(),
            ],
          ),
          ]
      ),
    );
  }

  Widget row1() {
    return Image.asset(
      'assets/imgs/BMI.png',
      width: 150,
      height: 150,
    );
  }

  Widget row2() {
    return Row(
      children: [
        Text(
          " Weight",
          style: txtStyle,
        ),
        Flexible(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter your weight"),
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            )),
      ],
    );
  }

  Widget row3() {
    return Row(
      children: [
        Text(
          " Height",
          style: txtStyle,
        ),
        Flexible(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter your height"),
              onChanged: (value) {
                setState(() {
                  height = value;
                });
              },
            )),
      ],
    );
  }

  Widget row4() {
    return Row(
      children: [
        Text(
          "Date",
          style: txtStyle,
        ),
        Flexible(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter Date"),
              onChanged: (value) {
                setState(() {
                  date = value;
                });
              },
            )),
      ],
    );
  }

  Widget row5() {
    return Row(
      children: [
        Text(
          "Gender",
          style: txtStyle,
        ),
        Flexible(
            child: RadioListTile(
              value: 0,
              groupValue: index,
              title: Text(gender[0]),
              activeColor: Colors.red,
              onChanged: (value) {
                setState(() {
                  index = value;
                });
              },
            )),
        Flexible(
            child: RadioListTile(
              value: 1,
              groupValue: index,
              title: Text(gender[1]),
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  index = value;
                });
              },
            )),
      ],
    );
  }

  Widget row6() {
    return Row(
      children: [
        Text(
          'Fit ',
          style: txtStyle,
        ),
        DropdownButton(
          items: fitOption.map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          value: fit,
          icon: Icon(Icons.arrow_downward_rounded, size:30, color: Colors.orange,),
          onChanged: (value) {
            setState(() {
              fit=value;
            });
          },
        )
      ],
    );
  }

  Widget row7()
  {
    return Row(children: [
      Text('Age', style: txtStyle,),
      Slider(
        min: 20,
        max: 100,
        divisions: 80,
        value: age,
        label: age.toString(),
        onChanged: (value) {
          setState(() {
            age=value;
          });
        },
      ),
    ],);
  }

  Widget row8()
  {
    return Row(
      children: [
        RaisedButton(child: Text('Save', style: txtStyle,), onPressed: (){
          setState(() {
            double w= double.parse(weight);
            double h= double.parse(height);
            bmi=w/(h*h);
            if(bmi<18) status='Not Fit';
            else if(bmi>25) status='Fat';
            else status='healthy';

            data.add(Reading(date: date, bmi: bmi, status: status, age: age));
          });
        }),
        RaisedButton(child: Text('Clear', style: txtStyle,), onPressed: (){})

      ],
    );
  }

  Widget row9()
  {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index].displayTitle(), style: txtStyle,),
          subtitle:  Text(data[index].displaySubTitle(), style: txtStyle,) ,
          trailing: Icon(Icons.email, size:30, color: Colors.green)  ,
          leading: Icon(Icons.home, size:30, color: Colors.red) ,

        );
      },);



  }

}

//template of data that will be displayed inside ListView ListTile
class Reading {
  String status;
  String date;
  double bmi;
  double age;

  Reading({this.status, this.date, this.bmi, this.age});

  String displayTitle() {
    return date + '  ' + status;
  }

  String displaySubTitle() {
    return bmi.toString() + '    ' + age.toString();
  }
}


