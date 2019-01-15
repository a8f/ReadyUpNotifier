import 'utils.dart';

class Server {
  String nickname;
  String ip;
  int port;
  static String stringDelimeter =
      "/~~/"; // Delimeter for converting to/from string

  static Server fromString(String serverString) {
    List<String> info = serverString.split(stringDelimeter);
    return Server(info[0], port: int.parse(info[1]), nickname: info[2]);
  }

  Server(String ip, {String nickname, int port}) {
    this.ip = ip;
    this.port = port == null ? DEFAULT_PORT : port;
    this.nickname =
        nickname == null ? ip.toString() + ":" + port.toString() : nickname;
  }

  String toString() {
    return ip + stringDelimeter + port.toString() + stringDelimeter + nickname;
  }
}

List<String> serverListToStringList(List<Server> servers) {
  List<String> stringList = new List<String>();
  for (Server s in servers) {
    stringList.add(s.toString());
  }
  return stringList;
}

List<Server> stringListToServerList(List<String> servers) {
  List<Server> serverList = new List<Server>();
  for (String s in servers) {
    serverList.add(Server.fromString(s));
  }
  return serverList;
}

List<Server> getSavedServers() {
  List<String> savedServers =
      SyncSharedPreferences.sharedPreferences.getStringList("servers");
  if (savedServers == null) return new List<Server>();
  return stringListToServerList(savedServers);
}
