import 'package:listchat/src/redux/common.dart';
import 'package:listchat/src/redux/state.dart';
import 'package:listchat/src/redux/string.dart';

ReduxState reducer(ReduxState state, dynamic action) {
  StateAction _action = action as StateAction;
  print(_action.action);
  switch (_action.action) {
    case SET_USER:
      state.user = _action.payload;
      break;
    default:
      break;
  }
  return state;
}
