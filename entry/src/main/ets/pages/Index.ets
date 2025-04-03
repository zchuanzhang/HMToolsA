import { NavView } from './NavView';
import { router } from '@kit.ArkUI';
import { DataVM } from '../DataVM/DataVM';
import { DataModel } from '../DataModel/DataModel';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State dataArr: DataModel[] = [];
  @State dataVM: DataVM = new DataVM();

  aboutToAppear(): void {
    DataVM.getRawfileData('DataFile').then((result) => {
      this.dataArr = result;
    });
  }

  build() {
    Column() {

      List({ space : 10}) {
        ForEach( this.dataArr, ( model: DataModel, index: number) => {
          ListItem() {
            Row() {
              Text(model.title)
                .fontSize(17)
                .fontColor('#000000')
                .textAlign(TextAlign.Start)
                .backgroundColor(Color.Gray)
                .margin({
                  left : 20,
                  right : 20
                })
                .width('90%')
                .height('100%')
            }
            .width('100%')
            .height('100%')
          }
          .margin({
            left: 20,
            right: 20
          })
          .backgroundColor(Color.Gray)
          .borderRadius({
            topLeft : 8,
            topRight : 8,
            bottomLeft : 8,
            bottomRight : 8
          })
          .onClick(() => {

          })
          .width('90%')
          .height(40)
        })
      }
      .margin({
        top : 30
      })
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}