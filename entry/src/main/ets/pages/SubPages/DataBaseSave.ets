import { relationalStore } from '@kit.ArkData'
import { Context } from '@ohos.abilityAccessCtrl';
import { taskpool } from '@kit.ArkTS';
import json from '@ohos.util.json';

@Concurrent
async function create(context: Context) {
  const CONFIG: relationalStore.StoreConfig = {
    name: "TestStore.db",
    securityLevel: relationalStore.SecurityLevel.S1
  };

  let store: relationalStore.RdbStore = await relationalStore.getRdbStore(context, CONFIG);
  console.log('获取数据库成功');
  const CREAT_TABLE_SQL = "CREATE TABLE IF NOT EXISTS testTable ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER, salary REAL, blobType BLOB)";
  const CREAT_TABLE_SQL_0 = "CREATE TABLE IF NOT EXISTS test00Table ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER, salary REAL, blobType BLOB)";

  await store.executeSql(CREAT_TABLE_SQL);
  await store.executeSql(CREAT_TABLE_SQL_0);
  console.log('创建表成功');
}

@Concurrent
async function insert(context: Context, valueBucketArray: Array<relationalStore.ValuesBucket>) {
  const CONFIG: relationalStore.StoreConfig = {
    name: "TestStore.db",
    securityLevel: relationalStore.SecurityLevel.S1
  };
  // 默认数据库文件路径为 context.databaseDir + rdb + StoreConfig.name
  let store: relationalStore.RdbStore = await relationalStore.getRdbStore(context, CONFIG);
  console.log('创建数据库成功');

  //数据插入
  await store.batchInsert("testTable", valueBucketArray as Object as Array<relationalStore.ValuesBucket>);
  console.log('数据插入成功');

  //数据插入
  await store.batchInsert("test00Table", valueBucketArray as Object as Array<relationalStore.ValuesBucket>);

}

@Concurrent
async function query(context: Context): Promise<Array<relationalStore.ValuesBucket>> {
  const CONFIG: relationalStore.StoreConfig = {
    name: "TestStore.db",
    securityLevel: relationalStore.SecurityLevel.S1
  };

  let store: relationalStore.RdbStore = await relationalStore.getRdbStore(context, CONFIG);

  //查询数据
  let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates("TestTable");
  let resultSet = await store.query(predicates);
  let index = 0;
  let result = new Array<relationalStore.ValuesBucket>(resultSet.rowCount);
  resultSet.goToFirstRow();
  do {
    // result[index++] = resultSet.getRow();
  }while (resultSet.goToNextRow());
  resultSet.close();


  //查询数据
  let predicates00: relationalStore.RdbPredicates = new relationalStore.RdbPredicates("test00Table");
  let resultSet00 = await store.query(predicates00);
  let index00 = 0;
  resultSet00.goToFirstRow();
  do {
    result[index00++] = resultSet00.getRow();
  }while (resultSet00.goToNextRow());
  resultSet00.close();

  return result;
}

@Concurrent
async function queryName(context: Context, name: string): Promise<relationalStore.ValuesBucket[]> {
  const CONFIG: relationalStore.StoreConfig = {
    name: "TestStore.db",
    securityLevel: relationalStore.SecurityLevel.S1
  }
  console.log('获取数据库数据 开始查询名字0 - ' + name);
  let store: relationalStore.RdbStore = await relationalStore.getRdbStore(context, CONFIG);
  let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates("test00Table");
  predicates.equalTo('name', name)
  predicates.and().equalTo('salary', 5000)
  let resultSet = await store.query(predicates);
  let index = 0;
  let result = new Array<relationalStore.ValuesBucket>(resultSet.rowCount);
  resultSet.goToFirstRow()
  do {
    result[index++] = resultSet.getRow()
  }while (resultSet.goToNextRow())
  resultSet.close()
  console.log('获取数据库数据 开始查询名字1' + ' ' + json.stringify(result));
  let index0 = 0;
  for (let v of result) {
    console.log(`获取数据库数据 name Row[${index0}].id = ${v.id}`);
    console.log(`获取数据库数据 name Row[${index0}].name = ${v.name}`);
    console.log(`获取数据库数据 name Row[${index0}].age = ${v.age}`);
    console.log(`获取数据库数据 name Row[${index0}].salary = ${v.salary}`);
    index0++;
  }
  return result;
}

@Concurrent
async function clear(context: Context) {
  const CONFIG: relationalStore.StoreConfig = {
    name: "TestStore.db",
    securityLevel: relationalStore.SecurityLevel.S1
  }

  await relationalStore.deleteRdbStore(context, CONFIG);
  console.log('删除数据库成功');
}

@Entry
@Component
struct DataBaseSave {
  @State message: string = 'Hello World';
  @State count: number = 5;

  build() {
    Column({ space: 30 }) {
      Text(this.message)
        .id('Hello World')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(async () => {
          let context = getContext(this);

          for (let x = 0; x < 5; x++) {
            console.log('获取数据库数据 走了这里0')
          }

          //准备数据
          let valueBucketArray = new Array<relationalStore.ValuesBucket>(this.count);
          for (let i = 0; i < this.count; i++) {
            let v: relationalStore.ValuesBucket = {
              id: i,
              name: "zhangsan" + i,
              age: 20,
              salary: 5000 + 50 * i
            }
            valueBucketArray[i] = v;
          }
          await taskpool.execute(create, context)
          await taskpool.execute(insert, context, valueBucketArray)
          let index = 0
          let ret = await taskpool.execute(query, context) as Array<relationalStore.ValuesBucket>
          for (let v of ret) {
            console.log(`获取数据库数据 Row[${index}].id = ${v.id}`);
            console.log(`获取数据库数据 Row[${index}].name = ${v.name}`);
            console.log(`获取数据库数据 Row[${index}].age = ${v.age}`);
            console.log(`获取数据库数据 Row[${index}].salary = ${v.salary}`);
            index++;
          }
          this.count++;

          console.log('获取数据库数据 走了这里1')
          let ret0 = await taskpool.execute(queryName, context, 'zhangsan1') as Array<relationalStore.ValuesBucket>

        })

      Text('开始测试')
        .fontSize(30)
        .onClick(() => {
          let context = getContext(this);
          taskpool.execute(queryName, context, 'zhangsan0').then((re) => {

          })
        })
    }
    .width('100%')
    .height('100%')
  }
}








