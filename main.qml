import QtQuick 2.4
import QtQuick.LocalStorage 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.2
import "js/main.js" as Main
ApplicationWindow {
    visible: true
    title: "無線網路自動登入"
    property int margin: 11
    width: mainLayout.implicitWidth + 2 * margin
    height: mainLayout.implicitHeight + 2 * margin
    minimumWidth: mainLayout.Layout.minimumWidth + 2 * margin
    minimumHeight: mainLayout.Layout.minimumHeight + 2 * margin
    Component.onCompleted: {
        Main.getAccounts();
    }

    Dialog {
        id: msgDialog
        visible: false
        title: "提示訊息"
        contentItem: Rectangle {
            color: "lightskyblue"
           implicitWidth: 400
           implicitHeight: 100

            Text {
                id: msgTxt
                text: "請稍後..."
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            Button {
                text: "確定"
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                onClicked: {
                    msgDialog.close();
                    msgTxt.text = "請稍候...";
                }
            }

        }
    }
    ColumnLayout {
        id: mainLayout
        GroupBox {
            id: descBox
            title: "使用方法："
            anchors.margins: margin
            ColumnLayout {
                RowLayout {
                   Text {
                      id: step1
                      text: qsTr("第一步：設定學校信箱與密碼")
                      color: "darkblue"
                    }
                }
                RowLayout {
                     Text {
                          id: step2
                          text: qsTr("第二步：完成並按下設定，若已經設定過，請按下自動登入。")
                          color: step1.color
                    }
                }
                RowLayout {
                    Text {
                       id: step3
                       text: qsTr("第三步：若要重新設定信箱與密碼，請按下重新設定。")
                       color: step1.color
                     }
                }
              ColumnLayout {
                  RowLayout {
                      Text {
                          text: qsTr("請輸入學校信箱：")
                      }
                  }
                  RowLayout {
                      id: rowLayout
                      TextField {
                          id: mailText
                          Layout.fillWidth: true
                      }
                  }
                  RowLayout {
                      Text {
                          text: qsTr("請輸入學校密碼：")
                      }
                  }
                  RowLayout {
                      TextField {
                          id:passText
                          echoMode: TextInput.Password
                          Layout.fillWidth: true
                      }
                  }

                 RowLayout {
                     id: btnLayout
                     Button {
                         id: setBtn
                        text: "設定"
                        Layout.fillWidth: true
                        onClicked: {
                            var result = Main.setting(mailText.getText(0,mailText.length), passText.getText(0,passText.length));
                            if(result!==undefined)
                                msgTxt.text = result;
                            msgDialog.open();
                        }
                     }
                     Button {
                         id: autoBtn
                        text: "自動登入"
                         Layout.fillWidth: true
                         onClicked: {
                              Main.httpGet("https://google.com.tw");
                              var result = Main.autoLogin(mailText.getText(0,mailText.length), passText.getText(0,passText.length),msgTxt.text.toString());
                             msgTxt.text = result;
                             msgDialog.open();
                         }
                     }
                     Button {
                         id: resetBtn
                        text: "重新設定"
                         Layout.fillWidth: true
                         onClicked: {
                             msgTxt.text = Main.reset();
                             msgDialog.open();
                         }
                     }
                 }
                 RowLayout {
                    ProgressBar {
                        id: loadingBar
                        Layout.fillWidth: true
                        visible: false
                    }
                 }
              }
            }
        }
    }
}

