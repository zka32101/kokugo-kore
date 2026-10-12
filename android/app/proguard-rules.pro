# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Play Core (for Flutter deferred components)
-dontwarn com.google.android.play.core.**

# 方針メモ:
# Firebase / Google Play services / Billing / Kotlin / kotlinx は各ライブラリが
# consumer-rules を同梱しているため、ここで `-keep ... { *; }` を書かない。
# 丸ごと保持すると R8 の難読化・縮小が効かず、Play Console の「難読化」割合が
# 25% を下回る（過去に 22% を警告された）。
