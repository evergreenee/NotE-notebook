@Component
export default struct CustomSearch {
  @Link keywords: string
  cleanKeywords: () => void = () => {
  }

  build() {
    Row() {
      Row() {
        Image($r('app.media.search'))
          .width(16)
          .margin({ left: 10 })
        TextInput({
          placeholder: '搜索笔记',
          text: this.keywords
        })
          .onChange((value: string) => {
            this.keywords = value
          })
          .backgroundColor('#F0F0F0')// 搜索框背景色
          .fontColor('#7D7D7D') // 搜索框内文字颜色
        if (this.keywords) {
          Image($r('app.media.cancel'))
            .width(16)
            .margin({ right: 10 })
            .onClick(() => {
              this.cleanKeywords()
            })
        }
      }
      .padding({ right: 52 })
      .backgroundColor('#F0F0F0') // 整体搜索框背景色
      .borderRadius(16)
      .borderWidth(1) // 边框宽度
      .borderColor('#C0C0C0') // 设置边框
    }
    .padding({ left: 20, right: 20 })
    .margin({ top: 12 })
  }
}
