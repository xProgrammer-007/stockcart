import 'package:stockcart/pages/cart_screen/cart_model.dart';

String jeansSizeToString(JeansSizeType type){
  int size;
  switch(type){
    case JeansSizeType.size_36:
      size = 36;
      break;
    case JeansSizeType.size_37:
      size = 37;
      break;
    case JeansSizeType.size_38:
      size = 38;
      break;
    case JeansSizeType.size_39:
      size = 39;
      break;
    case JeansSizeType.size_40:
      size = 40;
      break;
    case JeansSizeType.size_41:
      size = 41;
      break;
    case JeansSizeType.size_42:
      size = 42;
      break;
    case JeansSizeType.size_43:
      size = 43;
      break;
    case JeansSizeType.size_44:
      size = 44;
      break;
    case JeansSizeType.size_45:
      size = 45;
      break;
    case JeansSizeType.none:
      print('Jeans size = none');
      size = -1;
      break;
    default:
      print('Jeans size = none');
      size = -1;
  }
  return size.toString();
}

String shirtSizeToString(ShirtSizeType type){
  String size;
  switch(type){
    case ShirtSizeType.xs:
      size = 'xs';
      break;
    case ShirtSizeType.s:
      size = 's';

      break;
    case ShirtSizeType.m:
      size = 'm';

      break;
    case ShirtSizeType.lg:
      size = 'lg';

      break;
    case ShirtSizeType.xl:
      size = 'xl';

      break;
    case ShirtSizeType.xxl:
      size = 'xxl';

      break;
    case ShirtSizeType.none:
      size = 'none';

      break;
  }
  return size;
}