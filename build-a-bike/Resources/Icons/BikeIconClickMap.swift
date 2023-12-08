import SwiftUI

struct SeatSelector: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.54731*width, y: 0.11729*height))
        path.addLine(to: CGPoint(x: 0.73503*width, y: 0.11729*height))
        path.addLine(to: CGPoint(x: 0.73503*width, y: 0.26294*height))
        path.addLine(to: CGPoint(x: 0.54731*width, y: 0.26294*height))
        path.addLine(to: CGPoint(x: 0.54731*width, y: 0.11729*height))
        path.closeSubpath()
        return path
    }
}
struct DrivetrainSelector: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.55063*width, y: 0.47635*height))
        path.addLine(to: CGPoint(x: 0.48375*width, y: 0.49086*height))
        path.addLine(to: CGPoint(x: 0.48594*width, y: 0.51241*height))
        path.addLine(to: CGPoint(x: 0.51844*width, y: 0.55948*height))
        path.addLine(to: CGPoint(x: 0.51062*width, y: 0.56036*height))
        path.addLine(to: CGPoint(x: 0.49125*width, y: 0.56211*height))
        path.addLine(to: CGPoint(x: 0.46219*width, y: 0.56519*height))
        path.addLine(to: CGPoint(x: 0.47*width, y: 0.72046*height))
        path.addLine(to: CGPoint(x: 0.50781*width, y: 0.7165*height))
        path.addLine(to: CGPoint(x: 0.51438*width, y: 0.77632*height))
        path.addLine(to: CGPoint(x: 0.58219*width, y: 0.76224*height))
        path.addLine(to: CGPoint(x: 0.57656*width, y: 0.7099*height))
        path.addLine(to: CGPoint(x: 0.7925*width, y: 0.68791*height))
        path.addLine(to: CGPoint(x: 0.78438*width, y: 0.53221*height))
        path.addLine(to: CGPoint(x: 0.56*width, y: 0.55508*height))
        path.addLine(to: CGPoint(x: 0.55*width, y: 0.5564*height))
        path.addLine(to: CGPoint(x: 0.52875*width, y: 0.55816*height))
        path.addLine(to: CGPoint(x: 0.55063*width, y: 0.47635*height))
        path.closeSubpath()
        return path
    }
}
struct WheelsSelector: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.22094*width, y: 0.33516*height))
        path.addCurve(to: CGPoint(x: 0.025*width, y: 0.61138*height), control1: CGPoint(x: 0.11258*width, y: 0.33516*height), control2: CGPoint(x: 0.025*width, y: 0.45887*height))
        path.addCurve(to: CGPoint(x: 0.22094*width, y: 0.88715*height), control1: CGPoint(x: 0.025*width, y: 0.76389*height), control2: CGPoint(x: 0.11258*width, y: 0.88715*height))
        path.addCurve(to: CGPoint(x: 0.41719*width, y: 0.61138*height), control1: CGPoint(x: 0.32929*width, y: 0.88715*height), control2: CGPoint(x: 0.41719*width, y: 0.76389*height))
        path.addCurve(to: CGPoint(x: 0.35063*width, y: 0.40553*height), control1: CGPoint(x: 0.41719*width, y: 0.52918*height), control2: CGPoint(x: 0.39115*width, y: 0.45616*height))
        path.addLine(to: CGPoint(x: 0.32062*width, y: 0.47635*height))
        path.addCurve(to: CGPoint(x: 0.35938*width, y: 0.61138*height), control1: CGPoint(x: 0.34454*width, y: 0.51141*height), control2: CGPoint(x: 0.35938*width, y: 0.55901*height))
        path.addCurve(to: CGPoint(x: 0.22094*width, y: 0.80579*height), control1: CGPoint(x: 0.35938*width, y: 0.71899*height), control2: CGPoint(x: 0.29739*width, y: 0.80579*height))
        path.addCurve(to: CGPoint(x: 0.0825*width, y: 0.61138*height), control1: CGPoint(x: 0.14448*width, y: 0.80579*height), control2: CGPoint(x: 0.0825*width, y: 0.71899*height))
        path.addCurve(to: CGPoint(x: 0.22094*width, y: 0.41609*height), control1: CGPoint(x: 0.0825*width, y: 0.50376*height), control2: CGPoint(x: 0.14448*width, y: 0.41609*height))
        path.addCurve(to: CGPoint(x: 0.24938*width, y: 0.42049*height), control1: CGPoint(x: 0.23074*width, y: 0.41609*height), control2: CGPoint(x: 0.24015*width, y: 0.41775*height))
        path.addLine(to: CGPoint(x: 0.28*width, y: 0.34923*height))
        path.addCurve(to: CGPoint(x: 0.22094*width, y: 0.33516*height), control1: CGPoint(x: 0.2612*width, y: 0.34079*height), control2: CGPoint(x: 0.24172*width, y: 0.33516*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.76938*width, y: 0.33516*height))
        path.addCurve(to: CGPoint(x: 0.68063*width, y: 0.36639*height), control1: CGPoint(x: 0.73721*width, y: 0.33516*height), control2: CGPoint(x: 0.70739*width, y: 0.34705*height))
        path.addLine(to: CGPoint(x: 0.71344*width, y: 0.43324*height))
        path.addCurve(to: CGPoint(x: 0.76938*width, y: 0.41609*height), control1: CGPoint(x: 0.7306*width, y: 0.42247*height), control2: CGPoint(x: 0.74937*width, y: 0.41609*height))
        path.addCurve(to: CGPoint(x: 0.90781*width, y: 0.61138*height), control1: CGPoint(x: 0.84583*width, y: 0.41609*height), control2: CGPoint(x: 0.90781*width, y: 0.50376*height))
        path.addCurve(to: CGPoint(x: 0.76938*width, y: 0.80622*height), control1: CGPoint(x: 0.90781*width, y: 0.71899*height), control2: CGPoint(x: 0.84583*width, y: 0.80623*height))
        path.addCurve(to: CGPoint(x: 0.64781*width, y: 0.70242*height), control1: CGPoint(x: 0.71644*width, y: 0.80622*height), control2: CGPoint(x: 0.6711*width, y: 0.76387*height))
        path.addLine(to: CGPoint(x: 0.58656*width, y: 0.70902*height))
        path.addCurve(to: CGPoint(x: 0.76938*width, y: 0.88715*height), control1: CGPoint(x: 0.61461*width, y: 0.81299*height), control2: CGPoint(x: 0.68557*width, y: 0.88716*height))
        path.addCurve(to: CGPoint(x: 0.96562*width, y: 0.61138*height), control1: CGPoint(x: 0.87773*width, y: 0.88715*height), control2: CGPoint(x: 0.96562*width, y: 0.76389*height))
        path.addCurve(to: CGPoint(x: 0.76938*width, y: 0.33516*height), control1: CGPoint(x: 0.96562*width, y: 0.45887*height), control2: CGPoint(x: 0.87773*width, y: 0.33516*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.65031*width, y: 0.39542*height))
        path.addCurve(to: CGPoint(x: 0.60281*width, y: 0.46711*height), control1: CGPoint(x: 0.6319*width, y: 0.4157*height), control2: CGPoint(x: 0.61515*width, y: 0.43893*height))
        path.addCurve(to: CGPoint(x: 0.6025*width, y: 0.46799*height), control1: CGPoint(x: 0.60269*width, y: 0.46739*height), control2: CGPoint(x: 0.60262*width, y: 0.46771*height))
        path.addCurve(to: CGPoint(x: 0.57937*width, y: 0.55288*height), control1: CGPoint(x: 0.59135*width, y: 0.49371*height), control2: CGPoint(x: 0.58421*width, y: 0.52268*height))
        path.addLine(to: CGPoint(x: 0.63969*width, y: 0.54716*height))
        path.addCurve(to: CGPoint(x: 0.6825*width, y: 0.46051*height), control1: CGPoint(x: 0.64838*width, y: 0.51309*height), control2: CGPoint(x: 0.66293*width, y: 0.48298*height))
        path.addLine(to: CGPoint(x: 0.65031*width, y: 0.39542*height))
        path.closeSubpath()
        return path
    }
}
struct HandlebarSelector: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.21136*width, y: 0.19658*height))
        path.addLine(to: CGPoint(x: 0.3598*width, y: 0.11729*height))
        path.addLine(to: CGPoint(x: 0.39774*width, y: 0.25799*height))
        path.addLine(to: CGPoint(x: 0.2493*width, y: 0.33729*height))
        path.addLine(to: CGPoint(x: 0.21136*width, y: 0.19658*height))
        path.closeSubpath()
        return path
    }
}
struct ForkSelector: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.30594*width, y: 0.30745*height))
        path.addLine(to: CGPoint(x: 0.29594*width, y: 0.31229*height))
        path.addLine(to: CGPoint(x: 0.15625*width, y: 0.63865*height))
        path.addLine(to: CGPoint(x: 0.22531*width, y: 0.69714*height))
        path.addLine(to: CGPoint(x: 0.35063*width, y: 0.40509*height))
        path.addLine(to: CGPoint(x: 0.30688*width, y: 0.34219*height))
        path.addLine(to: CGPoint(x: 0.30594*width, y: 0.30745*height))
        path.closeSubpath()
        return path
    }
}
struct FrameSelector: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.54719*width, y: 0.25643*height))
        path.addLine(to: CGPoint(x: 0.3825*width, y: 0.2661*height))
        path.addLine(to: CGPoint(x: 0.30594*width, y: 0.30745*height))
        path.addLine(to: CGPoint(x: 0.30688*width, y: 0.34219*height))
        path.addLine(to: CGPoint(x: 0.4025*width, y: 0.47987*height))
        path.addLine(to: CGPoint(x: 0.40281*width, y: 0.47987*height))
        path.addLine(to: CGPoint(x: 0.46219*width, y: 0.56607*height))
        path.addLine(to: CGPoint(x: 0.46219*width, y: 0.56519*height))
        path.addLine(to: CGPoint(x: 0.51844*width, y: 0.55948*height))
        path.addLine(to: CGPoint(x: 0.46125*width, y: 0.47635*height))
        path.addLine(to: CGPoint(x: 0.55219*width, y: 0.47107*height))
        path.addLine(to: CGPoint(x: 0.52875*width, y: 0.5586*height))
        path.addLine(to: CGPoint(x: 0.57*width, y: 0.5542*height))
        path.addLine(to: CGPoint(x: 0.59281*width, y: 0.46843*height))
        path.addLine(to: CGPoint(x: 0.6025*width, y: 0.46799*height))
        path.addCurve(to: CGPoint(x: 0.65031*width, y: 0.39542*height), control1: CGPoint(x: 0.61488*width, y: 0.43944*height), control2: CGPoint(x: 0.63172*width, y: 0.4159*height))
        path.addLine(to: CGPoint(x: 0.72094*width, y: 0.5388*height))
        path.addLine(to: CGPoint(x: 0.75656*width, y: 0.53484*height))
        path.addLine(to: CGPoint(x: 0.76125*width, y: 0.53045*height))
        path.addLine(to: CGPoint(x: 0.66469*width, y: 0.33428*height))
        path.addLine(to: CGPoint(x: 0.6625*width, y: 0.26302*height))
        path.addLine(to: CGPoint(x: 0.54719*width, y: 0.26302*height))
        path.addLine(to: CGPoint(x: 0.54719*width, y: 0.25643*height))
        path.closeSubpath()
        return path
    }
}
