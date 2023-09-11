import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId:0)
class CartItem {

  @HiveField(0)
  late String image;

  @HiveField(1)
  late int mainText;

  @HiveField(2)
  late int subText;

  CartItem(this.image, this.mainText,this.subText);
}
