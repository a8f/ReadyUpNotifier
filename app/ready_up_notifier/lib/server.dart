import 'utils.dart';

class Server {
  String nickname;
  String ip;
  int port;
  int id;
  static String stringDelimeter =
      "/~~/"; // Delimeter for converting to/from string

  static Server fromString(String serverString) {
    List<String> info = serverString.split(stringDelimeter);
    return Server(int.parse(info[0]), info[1],
        port: int.parse(info[2]), nickname: info[3]);
  }

  Server(int id, String ip, {String nickname, int port}) {
    this.ip = ip;
    this.port = port == null ? DEFAULT_PORT : port;
    this.nickname =
        nickname == null ? ip.toString() + ":" + port.toString() : nickname;
    this.id = id;
  }

  String delimitedString() {
    return id.toString() +
        stringDelimeter +
        ip +
        stringDelimeter +
        port.toString() +
        stringDelimeter +
        nickname;
  }

  String toString() {
    return "ID: $id, IP: $ip, Port: $port, Nickname: $nickname";
  }

  @override
  bool operator ==(other) {
    return this.id == other.id;
  }
}

List<String> serverListToStringList(List<Server> servers) {
  List<String> stringList = new List<String>();
  for (Server s in servers) {
    stringList.add(s.delimitedString());
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

int newServerId() {
  List<Server> existingServers = stringListToServerList(
      SyncSharedPreferences.sharedPreferences.getStringList("servers"));
  int maxId = 0;
  for (Server s in existingServers) {
    if (s.id > maxId) maxId = s.id;
  }
  return maxId + 1;
}

List<Server> removeServerById(List<Server> servers, int id) {
  List<Server> updatedServers = servers;
  for (Server s in updatedServers) {
    if (s.id == id) {
      updatedServers.remove(s);
      break;
    }
  }
  return updatedServers;
}

void saveServers(List<Server> servers) {
  SyncSharedPreferences.sharedPreferences
      .setStringList("servers", serverListToStringList(servers));
}

void deleteServerById(int id) {
  List<Server> savedServers = getSavedServers();
  savedServers = removeServerById(savedServers, id);
  saveServers(savedServers);
}
