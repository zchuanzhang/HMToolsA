import { CommonUtil } from '../Common/CommonUtil'
import { router } from '@kit.ArkUI'

@Component
export  struct NavView {

  @State title: string = '';

  build() {

    Stack() {
      Image($r('app.media.des_back'))
        .objectFit(ImageFit.Fill)
        .margin({
          left: 15
        })
        .zIndex(2)
        .width(20)
        .height(20)
        .onClick(() => {
          router.back();
          console.log('点击事件 点击了返回');
        })

      Text(this.title)
        .textAlign(TextAlign.Center)
        .fontColor('#333333')
        .fontSize(17)
        .maxLines(1)
        .clip(true)
        .onClick(() => {
          console.log('点击事件 点击Text');
        })
        .zIndex(1)
        .padding({
          left: 50,
          right: 50
        })
        .width('100%')
        .height(44)
    }
    .alignContent(Alignment.Start)
    .width(CommonUtil.getScreenW_vp())
    .height(44.0)
  }
}