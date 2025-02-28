import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("15320949-8167-4543-91af-b53f6444490a")
    }
}