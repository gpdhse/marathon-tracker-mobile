import platform.UIKit.UIDevice

class IOSPlatform: Platform {
    override val deviceId: String = UIDevice.currentDevice.identifierForVendor?.UUIDString ?: "ios"
}