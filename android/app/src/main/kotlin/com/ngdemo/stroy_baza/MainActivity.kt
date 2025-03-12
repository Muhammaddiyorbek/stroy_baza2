package com.ngdemo.stroy_baza

import io.flutter.embedding.android.FlutterActivity
import com.yandex.mapkit.MapKitFactory
import android.os.Bundle

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        MapKitFactory.setApiKey("15320949-8167-4543-91af-b53f6444490a")
        super.onCreate(savedInstanceState)
    }
}
