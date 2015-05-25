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
    Dialog {
        id: msgDialog
        visible: false
        title: "Blue sky dialog"
        contentItem: Rectangle {
            color: "lightskyblue"
           implicitWidth: 400
           implicitHeight: 100

            Text {
                text: "It's so cool that you are using Qt Quick."
            }

            Button {
                text: "Hello Blue!"
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                onClicked: {
                    msgDialog.close();
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
                            Main.setting();
                            msgDialog.open();
                        }
                     }
                     Button {
                         id: autoBtn
                        text: "自動登入"
                         Layout.fillWidth: true
                     }
                     Button {
                         id: resetBtn
                        text: "重新設定"
                         Layout.fillWidth: true
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

