@Component
export default struct CustomTitle {
  @Link order: boolean
  @Link isAddDialogShow: boolean

  // 重用样式
  @Styles
  titleButtonStyle(){
    .width(56)
    .height(32)
    .borderWidth(1)
    .borderColor('#BFBFBF')
    .borderRadius(4)
  }

  build() {
    Row() {
      // 排序
      Column() {
        if (this.order) {
          Image($r('app.media.up'))
            .width(18)
        } else {
          Image($r('app.media.down'))
            .width(18)
        }
      }
      .titleButtonStyle()
      .justifyContent(FlexAlign.Center)
      .margin({ left: 20 })
      .onClick(() => {
        this.order = !this.order
      })

      Blank()
      // 标题
      Text('NotE')
        .fontColor('#000000')//
        .fontSize('22')
        .fontWeight(550)

      Blank()
      // 新建笔记
      Column() {
        Image($r('app.media.edit'))
          .width(18)
      }
      .titleButtonStyle()
      .justifyContent(FlexAlign.Center)
      .margin({ right: 20 })
      .onClick(() => {
        this.isAddDialogShow = true
      })
    }
    .width('100%')
    .height(60)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#F5F5F5', 0], ['#E0E0E0', 1]]
    })
    .shadow({
      radius: 5, // 阴影半径
      color: 'rgba(0,0,0,0.2)', // 透明度
      offsetX: 0,
      offsetY: 5 // 阴影偏移
    })
  }
}
