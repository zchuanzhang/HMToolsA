import { NavView } from '../NavView';
import UIAbility from '@ohos.app.ability.UIAbility';

@Entry
@Component
struct ParameterTransfer {

  @Provide fontSize: number = 20;
  title: string = getContext(this).resourceManager.getStringValue($r('app.string.TestName'));

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