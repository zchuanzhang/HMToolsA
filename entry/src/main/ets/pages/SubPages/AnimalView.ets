import { NavView } from '../NavView';
import { CatView } from './CatView';


@Entry
@Component

struct AnimalView {

  @State animalFood:number = 0;

  build() {
    Column({space: 30}) {

      NavView({title:'子控件传参'})

      Text('动物食品:' + this.animalFood)
        .fontSize(30)
        .onClick(() => {
          this.animalFood++;
        })

      CatView({
        catFood: this.animalFood
      })





    }




  }

}

