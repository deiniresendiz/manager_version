import 'dart:io';
import 'dart:convert';

class GenerateVersion {
  late String _envName;
  static const List<String> listEnvironment = ["store","testing","beta","staging"];
  GenerateVersion({required String environment}){
    _envName = environment;
  }

  void changeId()async{
    String newId =  _envName == "store"?"app":_envName    ;
    var fileAndroid = File('android/app/build.gradle');
    var fileIos = File('ios/Runner.xcodeproj/project.pbxproj');
    String contentAndroid = await fileAndroid.readAsString();
    String contentIos = await fileIos.readAsString();
    var re = RegExp(r'(?<=PRODUCT_BUNDLE_IDENTIFIER)(.*)(?=;)');
    contentIos = contentIos.replaceAll(re, " = $newId");

    LineSplitter ls = const LineSplitter();
    List<String> masForUsing = ls.convert(contentAndroid);
    int index = masForUsing.indexWhere((element) => element.contains('applicationId'));
    if(index != -1){
      masForUsing[index] = '        applicationId "io.plerk.$newId"';
    }
    contentAndroid = masForUsing.join('\n');

    await fileAndroid.writeAsString(contentAndroid);
    await fileIos.writeAsString(contentIos);
  }

  void changeLauncher()async{
    List<String> listLauncher = ['background','icon','icon-android'];
    for(String launcher in listLauncher){
      var launcherFile = File('environments/$_envName/$launcher.png');
      var path = 'assets/launcher/$launcher.png';
      await launcherFile.copy(path);
    }
  }

  void changeFirebase()async{
    List<String> listFirebase = ['google-services.json','GoogleService-Info.plist'];
    for(String firebase in listFirebase){
      var launcherFile = File('environments/$_envName/$firebase');
      String path;
      if(firebase == 'google-services.json'){
        path = 'android/app/google-services.json';
      }else{
        path = 'ios/GoogleService-Info.plist';
      }
      await launcherFile.copy(path);
    }
  }

  void changeEnvironment()async{

    Map<String,dynamic> _data = {

    };
    //"store","testing","beta","staging"

    String fileEnv = 'class Environment {\n';

    for(String key in _data.keys){
      var values = key.split('-');
      // ignore: prefer_typing_uninitialized_variables
      var data;

      if(_data[key].runtimeType.toString() == "String"){
        data = _data[key];
      }else{
        data = _data[key][_getIndex(list: _data[key])];
      }

      if(values[1] == "String"){
        fileEnv += '  static const ${values[1]} ${values[0]} = "$data";\n';
      }else{
        fileEnv += '  static const ${values[1]} ${values[0]} = $data;\n';
      }
    }
    fileEnv += "}";
    var file = File('lib/environment_config.dart');
    await file.writeAsString(fileEnv);
  }

  int _getIndex({required List<dynamic> list}){
    if(list.length == 2){
      return _envName != listEnvironment.last ? 0 : 1;
    }else{
      return listEnvironment.indexOf(_envName);
    }
  }
}
