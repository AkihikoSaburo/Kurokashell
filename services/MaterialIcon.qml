import QtQuick

Text {
    id: root
    property string icon: "terminal"
    property real fill: 0
    property real weight: 400
    property real grad: 0
    property real opsz: 24
    property real scaleFactor: 1

    text: root.icon
    font.family: "Material Symbols Rounded"
    font.pointSize: 24
    font.variableAxes: ({
        FILL: fill,
        wght: weight,
        GRAD: grad,
        opsz: opsz
    })
}
