
@Component

export struct CatView {

  @Prop catFood:number = 0;

  build() {
    Column({space: 30}) {

      Text('猫的食品:' + this.catFood)
        .fontSize(30)
        .onClick(() => {
          this.catFood++;
        })

    }
  }
}