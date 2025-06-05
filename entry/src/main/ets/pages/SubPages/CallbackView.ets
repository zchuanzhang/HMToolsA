import { NavView } from '../NavView'

@Entry
@Component

struct CallbackView {

  @State msg: string = '这是检测方法回调';
  endNum: number = 0;

  build() {
    Column() {
      //nav
      NavView({title: "方法回调"})

      //text
      Text(this.msg)
        .fontSize(20)
        .onClick(() => {
          this.addNum('开始', (num) => {
            let ms: string = '开始增加 -> ' + num;
            this.msg = ms;
          });
        })
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(100)
    }
    .width('100%')
    .height('100%')
  }

  private addNum(start: string, callback: (num: number) => void) {
    callback(this.endNum++);
  }
}