/// Message : "Data Fetched Successfully"
/// Success : true
/// response : ["Puntland","TIYEEGLOW","KALABAYDH","DIINSOOR","CADAADO","YEET","BUURDHUXUNLE","GEDO LUUQ","GARBAHAARAY","Puntland_MMT","GAALKACAYO","GALCAD","KISMAAYO","N/A","Afgooye","GURACEEL","JALALAQSI SHAW BUURWEYN","GODINLABE","GAROWE","GALKACYO","BOORAME","CELGARAS","BULOBARTE","JILIB","UFUROOW","CAATO","EDAHAB INTEGRATION","BIYACADE","XERAALE","GALHARERI","BUURHAKABA","BOOCAME","Baydhabo_MMT","AFGOOYE","GAROOWE","GALINSOOR","XARARDHERE","BARDAALE","BAXDO","BAYDHABO","BUAALE","SAAKO","QANSAXDHEERE","BUHOODLE","YAGOORI","HARGEISA","WAJAALE SOMALI LAND","CEELBARDE","BULOMAREER","BELED XAWO","BARAAWE","BAARDHEERE","CEELGARAS BAKOOL","MOGADISHU GUBTA","GABILEY","JANAALE","BALCAD","WAAJID","DOOLOW","BOOSAASO","MOGADISHU","BALADWEYNE","BUDBUD SOMALIA","CEELDHEER","CEELBUUR","Budbud Somalia","HOBYO","RABDHUURE","QORYOOLEEY","CEERIGAABO","AFMADOOW","MASAGAWAY","DHOOBLEY","XUDDUN","CEELBERDE","AWDHEEGLE BARIRE","BALANBAL","BACAADWEYN","CAABUUDWAAQ","DHUSAMAREB","WALAWEYN","JAMAAME","BURCO","SO","MARKA","Any State","SOMHQ","XINBARWAQO","XINDHERE","SHALANBOOD","XABAAL BARBAAR","Warsheekh","Bakaal Bank Limit","BURTINLE","LAASCAANOOD","XUDDUR","KAMSUUMA","CELLAHELAY","ARABSIYA","JOWHAR"]

class GetCollectionPointStates {
  GetCollectionPointStates({
      this.message, 
      this.success, 
      this.response,});

  GetCollectionPointStates.fromJson(dynamic json) {
    message = json['Message'];
    success = json['Success'];
    response = json['response'] != null ? json['response'].cast<String>() : [];
  }
  String? message;
  bool? success;
  List<String>? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['Success'] = success;
    map['response'] = response;
    return map;
  }

}