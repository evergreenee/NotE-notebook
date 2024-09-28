import NotEModel from '../model/NotEModel'

interface TimeFormat {
  range: string
  formatDate: string
  formatTime: string
}

function getFormatTime(timeStamp: number): TimeFormat {
  const today = new Date();
  const date = new Date(timeStamp);

  // 计算日期差值
  const diffTime = today.getTime() - date.getTime();
  // 向下取整
  const diffDays = Math.floor(diffTime / (24 * 60 * 60 * 1000));

  let range: string = ''

  if (diffDays === 0) {
    range = '今天'
  } else if (diffDays === 1) {
    range = '昨天'
  } else if (diffDays === 2) {
    range = '前天'
  } else {
    range = '更早'
  }

  const month: string = (date.getMonth() + 1).toString().padStart(2, '0')
  const day: string = date.getDate().toString().padStart(2, '0')
  const hours: string = date.getHours().toString().padStart(2, '0')
  const minute: string = date.getMinutes().toString().padStart(2, '0')

  const formatDate: string = `${month}月${day}日`
  const formatTime: string = `${hours}:${minute}`

  return { range, formatDate, formatTime }

}

@Component
export default struct NotEItem {
  @ObjectLink note: NotEModel
  onNotEClick: (note: NotEModel) => void = () => {
  }

  build() {
    Row() {
      Stack() {
        Row() {
          // 左侧
          Column() {

          }
          .width(26)
          .height(90)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#fafafa', 0.5], ['#f7f7f7', 1]] // 浅灰
          })
          .borderRadius({ topLeft: 4, bottomLeft: 4 })

          // 纵向分割线
          Divider()
            .vertical(true)
            .height(90)
            .color('#E0E0E0') // 灰色分割线

          // 右侧
          Column() {
            Row({ space: 10 }) {
              Text(getFormatTime(this.note.updateTime).range)
                .fontSize(12).fontColor('#A0A0A0') // 灰色字体
              Text(getFormatTime(this.note.updateTime).formatDate)
                .fontSize(12).fontColor('#A0A0A0')
              Text(getFormatTime(this.note.updateTime).formatTime)
                .fontSize(12).fontColor('#A0A0A0')
            }
            .margin({ left: 10 })
            .height(25)

            Divider()
              .color('#E0E0E0')

            Column() {
              Text(this.note.content)
                .fontColor('#333333')// 深灰色字体
                .maxLines(2)
                .margin({ right: 10 })
            }
            .margin({ left: 10 })
            .justifyContent(FlexAlign.Center)
            .height(64)

          }
          .alignItems(HorizontalAlign.Start)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#fafafa', 0.5], ['#f7f7f7', 1]]
          })
          .height(90)
          .borderRadius({ topRight: 4, bottomRight: 4 })
          .margin({ right: 27 })
        }
        .shadow({
          radius: 5,
          color: "rgba(0,0,0,0.1)",
          offsetY: 2
        })
      }
      .width('100%')
      .alignContent(Alignment.Start)
      .onClick(() => {
        this.onNotEClick(this.note)
      })
    }
    .margin({ top: 12 })
    .padding({ left: 20, right: 20 })
  }
}

