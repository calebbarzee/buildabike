import Foundation

extension BikeParts {
    func isFrameForkCompatible(frame: Frame, fork: Fork) -> Bool {
        return frame.headTubeDiameter == fork.steeringTubeDiameter
    }
    
    func isFrameWheelCompatible(frame: Frame, wheel: Wheel) -> Bool {
        return frame.rearWheelSize == wheel.type
    }
    
    func isFrameBottomBracketCompatible(frame: Frame, bottomBracket: BottomBracket) -> Bool {
        return frame.bottomBracketDiameter == bottomBracket.diameter && frame.bottomBracketType == bottomBracket.type
    }
    
    func isFrameSeatpostCompatible(frame: Frame, seatpost: Seatpost) -> Bool {
        return frame.seatpostDiameter == seatpost.diameter
    }
    
    func areWheelTireInnerTubeCompatible(wheel: Wheel, tire: Tire, innerTube: InnerTube) -> Bool {
        return wheel.width == tire.width && tire.width == innerTube.width && wheel.diameter == tire.diameter && tire.diameter == innerTube.diameter
    }
    
    func isHeadsetForkCompatible(headset: Headset, fork: Fork) -> Bool {
        return headset.steeringTubeDiameter == fork.steeringTubeDiameter
    }
    
    func isHeadsetHandlebarCompatible(headset: Headset, handlebar: Handlebar) -> Bool {
        return headset.handlebarDiameterMin <= handlebar.diameter && headset.handlebarDiameterMax >= handlebar.diameter
    }
}
