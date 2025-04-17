import { DataModel } from "../DataModel/DataModel"
import utils from "@arkts.utils"
import { common } from "@kit.AbilityKit"
import { util } from "@kit.ArkTS";
import { router } from "@kit.ArkUI";

export class DataVM {

static async getRawfileData(name: string): Promise<Array<DataModel>> {
  let context = getContext(DataVM) as common.UIAbilityContext;
  console.log('获取本地数据->开始')
  let localJson = await context.resourceManager.getRawFileContent(`${name}.json`);
  console.log(`获取本地数据->${JSON.stringify(localJson)}`);
  let textDecoderOption: util.TextDecoderOptions = { ignoreBOM: true };
  let textDecoder = util.TextDecoder.create('utf-8', textDecoderOption);
  let result = textDecoder.decodeToString(localJson, { stream: false});
  let arr: DataModel[] = JSON.parse(result) as Array<DataModel>;
  return arr;
}


  static pushToVC(title: string) {
    switch (title) {
      case '切圆角': {
        router.pushUrl({
          url: "pages/CornerView"
        })
      }
        break
      case '获取兄弟页面的宽高': {

      }
        break
      case '切圆角': {

      }
        break
      case '切圆角': {

      }
        break
      case '切圆角': {

      }
        break
      case '切圆角': {

      }
        break
      case '切圆角': {

      }
        break
      default :{

      }
    }
  }
}