import { Ability } from "@kit.AbilityKit";
import { display, promptAction } from "@kit.ArkUI";

export class CommonUtil {

  static getScreenW(): number {
    return display.getDefaultDisplaySync().width;
  }

  static getScreenH(): number {
    return display.getDefaultDisplaySync().height;
  }

  static getScreenW_vp(): number {
    return px2vp(display.getDefaultDisplaySync().width);
  }

  static getScreenH_vp(): number {
    return px2vp(display.getDefaultDisplaySync().height);
  }

  static showToast(msg: string) {
    promptAction.showToast({
      message: msg,
      duration: 3,
      alignment: Alignment.Center
    })
  }

}