
import android.content.Context
import com.google.android.gms.ads.identifier.AdvertisingIdClient

class AndroidPlatform(context: Context) : Platform {
    override val deviceId: String = AdvertisingIdClient.getAdvertisingIdInfo(context).id
}