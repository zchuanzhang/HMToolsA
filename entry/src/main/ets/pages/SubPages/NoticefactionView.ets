import { NavView } from '../NavView'
import { Event } from '@kit.ArkTS';
import { common, wantAgent, WantAgent } from '@kit.AbilityKit';
import { notificationManager } from '@kit.NotificationKit';
import { data } from '@kit.TelephonyKit';
import json from '@ohos.util.json';
import { BusinessError } from '@kit.BasicServicesKit';
import { CommonUtil } from '../../Common/CommonUtil';

@Entry
@Component
struct NoticefactionView {
  build() {
    Column({ space: 30} ) {

      //导航
      NavView({title: '通知测试'});

      //发送按钮
      Button('发送通知')
        .fontSize(20)
        .padding({
          left: 30,
          right: 30,
        })
        .height(60)
        .onClick(() => {
          this.pushNotice();
        })
    }
  }

  private pushNotice(){
    let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
    notificationManager.isNotificationEnabled().then((data: boolean) => {
      console.log('通知 ' + '通知权限标识 ' + json.stringify(data));
      if (!data) {
        //没有开通权限
        notificationManager.requestEnableNotification(context).then(() => {
          //请求授权成功
        }).catch((error: BusinessError) => {
          if (error.code == 1600004) {
            //用户主动拒绝
            console.log('通知 ' + '用户主动拒绝 ' + error.code + ' msg:' + error.message);
            CommonUtil.showToast('您已决绝授权, 重新打开请到设置页操作');
          } else {
            console.log('通知 ' + '获取授权失败 ' + error.code + ' msg:' + error.message);
          }
        });
      } else {
        //已开通权限

        //发送通知

        //创建按钮

        let wantAgentObj: WantAgent; // 用于保存创建成功的WantAgent对象，后续使用其完成触发的动作。
        // 通过WantAgentInfo的operationType设置动作类型
        //创建意图
        let wantAgentInfo:wantAgent.WantAgentInfo = {
          wants: [
            {
              deviceId: '',
              bundleName: context.abilityInfo.bundleName, //'com.cz.HMToolsA'
              abilityName: context.abilityInfo.name,
              action: '',
              entities: [],
              uri: '',
              parameters: {}
            }
          ],
          actionType: wantAgent.OperationType.START_ABILITY,
          requestCode: 0,
          wantAgentFlags:[wantAgent.WantAgentFlags.CONSTANT_FLAG]
        };

        //获取意图
        wantAgent.getWantAgent(wantAgentInfo, (err: BusinessError, data:WantAgent) => {
          if (err) {
            return;
          }
          wantAgentObj = data;

          //创建按钮
          let actionButton: notificationManager.NotificationActionButton = {
            title: '继续阅读',
            wantAgent: wantAgentObj
          }

          //创建请求
          let request: notificationManager.NotificationRequest = {
            id: 1,
            content: {
              notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
              normal: {
                title: '抗战:李云龙的意大利炮',
                text: '李云龙的意大利炮刚出击就收获满满',
                additionalText: '李云龙'
              }
            },
            // 通知消息的WantAgent
            wantAgent: wantAgentObj,
            // 通知按钮
            actionButtons: [actionButton]
          }

          //添加展示样式
          notificationManager.addSlot(notificationManager.SlotType.UNKNOWN_TYPE);

          //开始发送
          notificationManager.publish(request, (error: BusinessError) => {
            if (error) {
              console.log('通知 ' + '发送通知失败 ' + error.code + ' ' + error.message);
            }
            console.log('通知 ' + '发送成功');
          });
        });

      }
    }).catch((error: BusinessError) => {
      console.log('通知 ' + '获取通知权限失败:' + error);
    });
  }



  //end
}

