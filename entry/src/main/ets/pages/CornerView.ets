import { NavView } from "./NavView"

@Entry
@Component

export struct  CornerView {


  build() {

    Column() {

      NavView({ title: '切圆角' });

      Text()
        .backgroundColor('#999999')
        .borderRadius({
          topLeft: 10,
          bottomLeft: 50,
          topRight: 80,
          bottomRight: 150
        })
        .margin({
          top: 30
        })
        .clip(true)
        .width(300)
        .height(300)
    }
    .width('100%')
    .height('100%')

  }

}