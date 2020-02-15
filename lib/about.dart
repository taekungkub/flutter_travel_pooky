import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "About",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            image(),
            Text("ประวัติความเป็นมา",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Prompt_regular")),
            Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 10),
              child: Text(
                  "เทศบาลตําาบลบ้านใหม่ จัดตั้งขึ้นตามพระราชบัญญัติสภาตําาบลและองค์การ บริหารส่วนตําาบล พ.ศ. 2537 โดยยกฐานะจากสภาตําาบลเดิมขึ้นเป็นองค์การบริหารส่วนตําาบล เมื่อวันที่ 2 มีนาคม 2538 มีนายสมศักดิ์ ปานย้อย เป็นประธานกรรมการบริหาร เมื่อแรกจัดตั้ง เป็นองค์การบริหารส่วนตําาบลขนาดกลาง มีงบประมาณ ในการบริหารงาน ปีละสิบล้านบาท ต่อมาเมื่อมีรายได้มากขึ้น จึงกําาหนดให้เป็นองค์การบริหารส่วนตําาบล ขนาดใหญ่ ในปี 2545",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Prompt_regular")),
            ),
            Text("ตราสัญญาลักษณ์",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Prompt_regular")),
            Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 10, bottom: 20),
              child: Text(
                  "ความหมายของตราสัญลักษณ์ ดอกบัว หมายถึง สัญลักษณ์แทนจังหวัดปทุมธานี ซึ่งเดิมชื่อเมืองสามโคก และได้รับพระราชทานนามจากพระบาทสมเด็จพระพุทธเลิศหล้านภาลัย รัชกาลที่ 2 เป็นเมืองปทุมธานี ต้นเทียน หมายถึงเทศบาลตําาบลบ้านใหม่ รัศมีเปลวเทียน หมายถึง สมาชิกเทศบาลตําาบลบ้านใหม่ ซึ่งเป็นตัวแทนของราษฎรที่มาจากการเลือกตั้ง ภายใต้ระบอบประธิปไตย",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Prompt_regular")),
            ),
          ],
        ),
      ),
    );
  }

  Widget image() {
    return Container(
      child: Center(child: Image.asset("images/logo_menu.png")),
    );
  }
}
