import { NavView } from '../NavView';
import UIAbility from '@ohos.app.ability.UIAbility';

@Entry
@Component
struct ParameterTransfer {

  @Provide fontSize: number = 20;
  @State title: string = '';
  // getContext(this).resourceManager.getStringValue($r('app.string.TestName')).then((rusult) => {
  //
  // });

  build() {
    Column() {
      NavView();
    }
  }
}

@Component
struct ChildOne {

  @Consume fontSize: number;

  build() {

  }

}

// function then(arg0: (rusult: any) => void) {
//   throw new Error('Function not implemented.');
// }
