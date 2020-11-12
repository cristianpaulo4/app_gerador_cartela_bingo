import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

import 'Cartela.dart';
import 'PdfPreviewScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pdf = pw.Document();
  PdfImage _logo;
  Random random = new Random();
  bool gerar = false;
  TextEditingController _controller = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();
  GlobalKey<FormState> _globalKey = GlobalKey();
  Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
          top: 100,
        ),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Gerador de Cartelas",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: Colors.black45,
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                enabled: !gerar,
                controller: _controller,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: 'Digite a de Páginas',
                  hintStyle: TextStyle(
                    color: Colors.black12,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                style: TextStyle(
                  fontSize: 20,
                ),
                validator: (x) {
                  if (x.isEmpty) {
                    return "Digite a de Páginas";
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 60,
                child: FloatingActionButton.extended(
                  icon: gerar
                      ? CupertinoActivityIndicator()
                      : Icon(Icons.date_range),
                  label: Text(
                    gerar ? 'Aguarde...' : 'Gerar cartelas',
                  ),
                  onPressed: () async {
                    if (_form.currentState.validate()) {
                      setState(() {
                        gerar = !gerar;
                      });

                      await writeOnPdf();
                      await savePdf();

                      Directory documentDirectory =
                          await getApplicationDocumentsDirectory();

                      String documentPath = documentDirectory.path;
                      String fullPath = "$documentPath/cartelas.pdf";

                      setState(() {
                        gerar = !gerar;
                        _controller.clear();
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfPreviewScreen(
                            path: fullPath,
                            bytes: bytes,
                          ),
                        ),
                      );
                    } else {
                      var snak = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Digite a de páginas'),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  writeOnPdf() {
    int qtd = int.parse(_controller.text);

    print('Quantidade de paginas: ' + qtd.toString());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(5),
        orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          return <pw.Widget>[
            // quantidade de paginas
            for (var i = 0; i < qtd; i++)
              pw.Column(
                children: [
                  for (var i = 0; i < 2; i++)
                    pw.Row(
                      children: [
                        for (var i = 0; i < 3; i++)
                          pw.Container(
                            margin: pw.EdgeInsets.all(5),
                            height: PdfPageFormat.a4.height / 3,
                            width: (PdfPageFormat.a4.width / 2) - 30,
                            decoration: pw.BoxDecoration(
                              border: pw.BoxBorder(
                                color: PdfColors.black,
                                bottom: true,
                                left: true,
                                right: true,
                                top: true,
                                width: 1,
                              ),
                              borderRadius: 10,
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                              children: [
                                pw.Container(
                                  height: 60,
                                  padding: pw.EdgeInsets.only(
                                    right: 15,
                                    left: 15,
                                  ),
                                  decoration: pw.BoxDecoration(
                                    border: pw.BoxBorder(
                                      color: PdfColors.black,
                                      bottom: true,
                                      width: 1,
                                    ),
                                  ),
                                  child: pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        'B',
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                        textAlign: pw.TextAlign.center,
                                      ),
                                      pw.Text(
                                        'I',
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                        textAlign: pw.TextAlign.center,
                                      ),
                                      pw.Text(
                                        'N',
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                        textAlign: pw.TextAlign.center,
                                      ),
                                      pw.Text(
                                        'G',
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                        textAlign: pw.TextAlign.center,
                                      ),
                                      pw.Text(
                                        'O',
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                        textAlign: pw.TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Container(
                                    padding: pw.EdgeInsets.all(10),
                                    child: pw.GridView(
                                      crossAxisCount: 5,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      children: [
                                        for (var item
                                            in Cartela().gerarNumeros())
                                          pw.Container(
                                            decoration: pw.BoxDecoration(
                                              border: pw.BoxBorder(
                                                color: PdfColors.black,
                                                width: 0.5,
                                                bottom: true,
                                                top: true,
                                                left: true,
                                                right: true,
                                              ),
                                            ),
                                            alignment: pw.Alignment.center,
                                            height: 80,
                                            width: 30,
                                            child: item != 0
                                                ? pw.Text(
                                                    '${item < 10 ? '0$item' : item.toString()}',
                                                    style: pw.TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 25,
                                                    ),
                                                  )
                                                : pw.Padding(
                                                    padding:
                                                        pw.EdgeInsets.all(10),
                                                    child: pw.PdfLogo(),
                                                  ),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
          ];
        },
      ),
    );
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/cartelas.pdf");
    bytes = pdf.save();
    file.writeAsBytesSync(bytes);
  }
}
