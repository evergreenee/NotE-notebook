@Component
export default struct CustomAddDialog {
  @Link addContent: string
  onClose: () => void = () => {
  }
  onCreate: () => void = () => {
  }

  build() {
    Stack() {
      // 蒙层
      Rect()
        .height('100%')
        .width('100%')
        .fill('rgba(255, 255, 255, 0.8)')
        .onClick(() => {
          this.onClose()
        })

      Column() {
        // 文本输入
        TextArea({
          placeholder: '请输入',
          text: this.addContent
        })
          .onChange((value: string) => {
            this.addContent = value
          })
          .height('70%')
          .margin(20)

        // 按钮
        Row() {
          // 返回
          Column() {
            Image($r('app.media.back'))
              .width(24)
          }
          .backgroundColor('#D9D9D9')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.onClose()
          })

          // 保存
          Column() {
            Image($r('app.media.save'))
              .width(24)
          }
          .backgroundColor('#BFBFBF')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.onCreate()
          })

        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .width('100%')
      .height('50%')
      .borderRadius({ topLeft: 16, topRight: 16 })
      .backgroundColor('#F0F0F0')

    }
    .height('100%')
    .width('100%')
    .alignContent(Alignment.Bottom)

  }
}

@Preview
@Component
struct CustomEditDialogPreView {
  @State addContent: string = ''

  build() {
    CustomAddDialog({ addContent: $addContent })
  }
}