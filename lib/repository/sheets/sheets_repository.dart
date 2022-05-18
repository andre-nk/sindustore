import 'package:gsheets/gsheets.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:uuid/uuid.dart';

class SheetsRepository {
  final gSheetCredentials = {
    "type": "service_account",
    "project_id": "sindustore-dev",
    "private_key_id": "365a9ac3f0c183fb794caae855d35dcef8232277",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDOr0kWGNPcaL2I\n7l4c0K4JjLHN4MBhBz1QvWrb4RvfUDxTWilJ+ArGXya6YlsUxY4KcPgRNgRLviuQ\nF1JHHuoMKkxp1zIIAUU+t6O8ihFZu9IMti8Ix+zam31omvYnAeSlBTXXOBgKMdHb\n15ge6Vh04xbnvtjJPUJ0zTXwg8m6kG9DQ1dw/1wKgu4vEH5XqOTWrzVRceZHypyc\nB4RjVPTQ+Zuyp03ciFadio0FMWBwuEYfb/esg5YlLe7COvd3kZ0BZhit7sJBz6fi\naZ4gp94nn3Mu1DsRDTn3ZTdHX7TJCZINwxgKItO/3VWUR6E1JrpdmGTgAkwywOhx\ngDEz4EzhAgMBAAECggEAAkFbJa60bB6n980rEXss9P14KLgTvVNOBdolRvwyOMn4\nOIwesHgQjQjXhDfjyMqdkctZB54MZrOu58H7Y7uIgAS7o/mFSh1SbzxjgOCMTyt7\nn6gixACjeuCwugIb3sHYZ/0SMPSjnYPc535XIno3HQJn2vRECxEcLyhYlvTnL/4T\nr738CjM5KkGdCgv367bm/G8+PXBC25fxMgja1jhwRDOps8dryx91EPPjSMg2fJ7H\nEPIzUKGxE53HPG8mV3m8QlCmrcrURai2JwYHZBrDVaO3m3MRmgcawzI85BSVmPK8\nXF0Pt3VSn/P6XiYpmNVdvnHt9hP475sqNjwGjoTTIQKBgQD9EWdL1CiymyN/8I+s\nkHvnNOGzgQXINeBELs2FpdUro/Ga3/FYrtKOm3/QPaQJ0ZaVgSuzWWMLNMlu6o4F\npGZSK0SUgRDUE2XE2U7mRWUly+Nj60VNlHDjTSD8eUWTqRSpdTq5UjTAT2ops5L2\nfzz1blr1E789fvoHdh690Cgs8QKBgQDRFE9No3TY9tAiEko9PZiUzXBetj6jM2nR\nHmiIn/TwdWnEE69Dsc3gj9F3Iu1ngaNNHAA/MbLK0UzhfqtHmwc7Pw0RpGJnimAc\nI3w1aixpui2KTevk/rUGU0cEgITVRCwbFILK6SNXIgP+UvrVCwky8k9p+mAjZGdR\nmj0ObGXe8QKBgQC3Ekn5rycp3dUWjr5BBdy8a6MDKkk2htMQQBNppYfKpDT55xs/\nHmkvxQn3aUAr4jTfPqyQeA+QYcV+uau4JS/oLWjVTXERGl86wkGzj2wWpaJ//AkM\nkGAB7x/3xPsyUNSjqiyrN+71V/3i4QdlzrIYkpa2SGzGXf8eOrMOeXE24QKBgQC0\niuUwFcYA1KBFy6Vv3JC1bfFq19Se+PaXLbr2v6mzOrBqMNVXj2JIV+h5CCAZEUkC\nfPt5lmDd4n6Q+eDNpIFKF9ghM+IFpuf3ZG0NcvGHGs3YcBETXR7Up3Tb3l7WClhL\nyhpnPYrW4viv1Nfkv/Lhm3wX96ys4zaUsKuomNIfAQKBgEF9BaSco8ETu0iJDp3Q\nuxvHxaUOkm6BpagcZLRpii66luShHn/7IEaPdBGULu2nCLL4zlbENNosc+EGjT3h\nbPLja0NCi0WFpK0uoUbxCuK4NCoxxo7nEbxT2Xxq4LBZhA+rh+8axaOFFF8q4QeB\nb1oGR+oVCi7G/rB7SKPu6jfk\n-----END PRIVATE KEY-----\n",
    "client_email": "gsheets@sindustore-dev.iam.gserviceaccount.com",
    "client_id": "107323263620317863127",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40sindustore-dev.iam.gserviceaccount.com"
  };

  Future<void> insertInvoice(Invoice invoice) async {
    try {
      final gsheets = GSheets(gSheetCredentials);
      // fetch spreadsheet by its id
      final ss =
          await gsheets.spreadsheet("1Wh8BB5t0cKA5yyHKwIjgYjUkYBHZl7LphR5BDiGsiKg");

      // get worksheet by its title
      var invoiceSheet = ss.worksheetByTitle('invoices');
      if(invoiceSheet != null){
        await invoiceSheet.values.insertValue('Nota ${const Uuid().v4()}', column: 1, row: 2);
        await invoiceSheet.values.insertValue(invoice.adminHandlerUID, column: 2, row: 2);
      } else {
        throw Exception("Worksheet can't be found");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
