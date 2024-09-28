import CustomAddDialog from '../component/CustomAddDialog'
import CustomEditDialog from '../component/CustomEditDialog'
import CustomSearch from '../component/CustomSearch'
import CustomTitle from '../component/CustomTitle'
import NotEItem from '../component/NotEItem'
import NotETable from '../database/NotETable'
import NotEModel from '../model/NotEModel'

@Entry
@Component
struct Index {
  // 缓存的原始数组
  originNotEList: NotEModel[] = []
  // 页面中展示的列表
  @State noteList: NotEModel[] = []
  // 是否展示新建弹窗
  @State isAddDialogShow: boolean = false
  // 新建暂存内容
  @State addContent: string = ''
  // 是否展示编辑笔记弹窗
  @State isEditDialogShow: boolean = false
  // 编辑弹窗文本输入的暂存内容
  @State editContent: string = ''
  // 当前编辑的索引
  editingNotEIndex: number = -1
  // 数据库初始化
  private NotETable = new NotETable(() => {
  })
  // 点击笔记
  clickNotE = (note: NotEModel) => {
    for (let i = 0; i < this.originNotEList.length; i++) {
      this.originNotEList[i].id = note.id
      this.editingNotEIndex = i
      this.isEditDialogShow = true
      this.editContent = note.content
    }
  }
  // 新增笔记
  createNotE = () => {
    const date: Date = new Date()
    const newNotE: NotEModel = new NotEModel(0, date.getTime(), this.addContent)
    this.NotETable.insertData(newNotE, (id: number) => {
      newNotE.id = id
      this.originNotEList.push(newNotE)
      this.noteList = this.originNotEList
      this.refreshByOrder()
      this.closeDialog()
    })
    // this.originNotEList.push(newNotE)
    // this.noteList = this.originNotEList
    // this.refreshByOrder()
    // this.closeDialog()
  }
  // 删除笔记
  deleteNotE = () => {
    if (this.editingNotEIndex !== -1) {
      this.NotETable.deleteData(this.originNotEList[this.editingNotEIndex], () => {
        this.originNotEList.splice(this.editingNotEIndex, 1)
        this.noteList = this.originNotEList
        this.refreshByOrder()
        this.closeDialog()
      })
    }
  }
  // 修改笔记
  saveNotE = () => {
    const date: Date = new Date()
    this.originNotEList[this.editingNotEIndex].updateTime = date.getTime()
    this.originNotEList[this.editingNotEIndex].content = this.editContent
    this.NotETable.updateData(this.originNotEList[this.editingNotEIndex], () => {
      this.noteList = this.originNotEList
      this.refreshByOrder()
      this.closeDialog()
    })
  }
  // 关闭弹窗
  closeDialog = () => {
    this.isAddDialogShow = false
    this.addContent = ''
    this.isEditDialogShow = false
    this.editContent = ''
    this.editingNotEIndex = -1
  }

  // 页面初始化前向页面加载数据
  aboutToAppear() {
    this.originNotEList = []
    this.noteList = []
    this.order = false
    this.keywords = ''
    this.isAddDialogShow = false
    this.isEditDialogShow = false
    this.addContent = ''
    this.editingNotEIndex = -1
    this.editContent = ''

    this.NotETable.getRdbStore(() => {
      this.NotETable.query((result: NotEModel[]) => {
        this.originNotEList = result
        this.noteList = this.originNotEList
        this.refreshByOrder()
      })
    })
  }

  // 排序状态
  @State @Watch('refreshByOrder') order: boolean = true

  // 监听排序状态变化事件
  refreshByOrder() {
    let orderList: NotEModel[] = this.noteList
    const length = orderList.length
    for (let i = 0; i < length - 1; i++) {
      for (let j = 0; j < length - i - 1; j++) {
        const timeA = orderList[j].updateTime
        const timeB = orderList[j+1].updateTime

        if ((timeA > timeB && this.order) || (timeA < timeB && !this.order)) {
          const temp = orderList[j]
          orderList[j] = orderList[j+1]
          orderList[j+1] = temp
        }
      }
    }
    this.noteList = orderList
  }

  // 搜索关键词
  @State @Watch('onKeywordsChange') keywords: string = ''
  // 清空搜索关键词
  cleanKeywords = () => {
    this.keywords = ''
  }

  // 监听搜索关键词
  onKeywordsChange() {
    if (this.keywords.length === 0) {
      this.noteList = this.originNotEList
      this.refreshByOrder()
    } else {
      let resultList: NotEModel[] = []

      for (const noteItem of this.originNotEList) {
        if (noteItem.content.includes(this.keywords)) {
          resultList.push(noteItem)
        }
      }
      this.noteList = resultList
    }
  }

  build() {
    Stack() {
      // 主体页面
      Column() {
        // 标题栏
        CustomTitle({
          order: $order,
          isAddDialogShow: $isAddDialogShow
        })

        Divider()
          .color('#604637')

        // 搜索框
        CustomSearch({ keywords: $keywords, cleanKeywords: this.cleanKeywords })

        // 笔记列表
        Scroll() {
          Column() {
            ForEach(
              this.noteList,
              (note: NotEModel, index: number) => {
                // 笔记点击方法
                NotEItem({ note: this.noteList[index], onNotEClick: this.clickNotE })
              },
              (note: NotEModel) => {
                return note.content
              }
            )
          }
        }

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#efefef')

      // 新增笔记
      if (this.isAddDialogShow) {
        CustomAddDialog({
          addContent: $addContent,
          onClose: this.closeDialog,
          onCreate: this.createNotE
        })
      }

      // 编辑弹窗
      if (this.isEditDialogShow) {
        CustomEditDialog({
          editContent: $editContent,
          onClose: this.closeDialog,
          onDelete: this.deleteNotE,
          onSave: this.saveNotE
        })
      }

    }
    .width('100%')
    .height('100%')
  }
}