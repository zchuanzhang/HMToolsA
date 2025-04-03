import { Ability } from "@kit.AbilityKit";
import { display } from "@kit.ArkUI";

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

}