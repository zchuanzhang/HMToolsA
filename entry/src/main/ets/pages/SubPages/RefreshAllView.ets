import { NavView } from '../NavView';

@Entry
@Component
struct RefreshAllView {
  @State refresh: number = 0;
  build() {
    Column() {

      NavView( { title: '刷新整个页面'} )

      Text()

    }
    .width('100%')
    .height('100%')

  }
}