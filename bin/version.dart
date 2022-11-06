
import 'package:manager_version/manager_version.dart';

void main(List<String> arguments) {
  if(arguments.isNotEmpty){
    final generateVersion = GenerateVersion(environment: arguments[0]);
    String environment = arguments[0];
    if(GenerateVersion.listEnvironment.contains(environment)){
      print("Version: $environment");
      generateVersion.changeLauncher();
      generateVersion.changeId();
      generateVersion.changeEnvironment();
      generateVersion.changeFirebase();
    }
  }
}