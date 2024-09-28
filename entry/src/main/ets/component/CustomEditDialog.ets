@Component
export default struct CustomEditDialog {
  @Link editContent: string
  onClose: () => void = () => {
  }
  onDelete: () => void = () => {
  }
  onSave: () => void = () => {
  }

  build() {
    Stack() {
      // 模糊效果
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
          text: this.editContent
        })
          .onChange((value: string) => {
            this.editContent = value
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

          // 删除
          Column() {
            Image($r('app.media.delete'))
              .width(24)
          }
          .backgroundColor('#FF4C4C')
          .width(60)
          .height(60)
          .borderRadius(30)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.onDelete()
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
            this.onSave()
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
