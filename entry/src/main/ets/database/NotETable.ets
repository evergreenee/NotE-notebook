import relationalStore from '@ohos.data.relationalStore';
import NotEModel from '../model/NotEModel'
import CommonConstants from '../constants/CommonConstants';
import Rdb from './Rdb';

// 基于Rdb类的数据库类
export default class NotETable {
  private noteTable = new Rdb(CommonConstants.NOTE_TABLE.tableName, CommonConstants.NOTE_TABLE.sqlCreate,
    CommonConstants.NOTE_TABLE.columns);

  constructor(callback: Function = () => {
  }) {
    this.noteTable.getRdbStore(callback);
  }

  getRdbStore(callback: Function = () => {
  }) {
    this.noteTable.getRdbStore(callback);
  }

  // 插入数据
  insertData(note: NotEModel, callback: Function) {
    // 通过工具函数，将单条笔记，转化为存储健值对
    const valueBucket: relationalStore.ValuesBucket = generateBucket(note);
    // 执行Table的插入数据方法，透传回调函数
    this.noteTable.insertData(valueBucket, callback);
  }

  // 删除数据
  deleteData(note: NotEModel, callback: Function) {
    // 初始化操作数据库的谓词对象
    let predicates = new relationalStore.RdbPredicates(CommonConstants.NOTE_TABLE.tableName);
    // 配置谓词以匹配数据表的id列中值的字段，为笔记对象的id
    predicates.equalTo('id', note.id);
    // 使用谓词执行Table的删除方法
    this.noteTable.deleteData(predicates, callback);
  }

  // 更新数据
  updateData(note: NotEModel, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(note);
    let predicates = new relationalStore.RdbPredicates(CommonConstants.NOTE_TABLE.tableName);
    predicates.equalTo('id', note.id);
    this.noteTable.updateData(predicates, valueBucket, callback);
  }

  // 查询全部笔记
  query(callback: Function) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.NOTE_TABLE.tableName);
    this.noteTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      let count: number = resultSet.rowCount;
      // 如果查询的结果为0，执行回调函数，传入空数组
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG}` + 'Query no results!');
        callback([]);
      } else {
        resultSet.goToFirstRow();
        // 存储最后将返回的结果数组
        const result: NotEModel[] = [];
        // 使用循环为结果添加内容
        for (let i = 0; i < count; i++) {
          // let tmp: NotEModel = {
          //   id: 0, updateTime: 0, content: ''
          // };
          let tmp: NotEModel = new NotEModel(0, 0, ' ')
          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.updateTime = resultSet.getDouble(resultSet.getColumnIndex('updateTime'));
          tmp.content = resultSet.getString(resultSet.getColumnIndex('content'));
          result[i] = tmp;
          // 转至下一行
          resultSet.goToNextRow();
        }
        // 执行回调函数，把所有的查询结果传入
        callback(result);
      }
    });
  }
}

// 将笔记的数据结构转化为存储键值对
function generateBucket(note: NotEModel): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.updateTime = note.updateTime
  obj.content = note.content
  return obj;
}