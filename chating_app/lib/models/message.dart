class MessageModel {

  late String sender;
  late String reciver;
  late String sent;
  late String read;
  late Type type;
  late String message;

  MessageModel({
      required this.sender,
      required this.reciver,
      required this.sent,
      required this.read,
      required this.type,
      required this.message
      });

  MessageModel.fromJson(Map<String, dynamic> json) {
    sender = json["sender"].toString();
    reciver = json["reciver"].toString();
    sent = json["sent"].toString();
    read = json["read"].toString();
    type = json["type"].toString() == Type.image.name ? Type.image : Type.text;
    message = json["message"].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["sender"] = sender;
    data["reciver"] = reciver;
    data["sent"] = sent;
    data["read"] = read;
    data["type"] = type.name;
    data["message"] = message;
    return data;
  }
}

enum Type { text, image }