import QtQuick

Item {
    id: root
    property string icon: "terminal"
    property string color: "black"
    property real fill: 0
    property real weight: 400
    property real grad: 0
    property real opsz: 24
    property real scaleFactor: 1

    Text {
        id: iconText
        anchors.centerIn: parent
        text: root.icon
        font.family: "Material Symbols Rounded"
        font.pointSize: 24
        color: root.color

        width: implicitWidth
        height: implicitHeight

        font.variableAxes: ({
            FILL: root.fill,
            wght: root.weight,
            GRAD: root.grad,
            opsz: root.opsz
        })
    }
}