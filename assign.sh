cordova build android --release &&
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore android.keystore platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk br.gov.ba.car.supplier && 
touch app-release.apk && rm app-release.apk &&
zipalign -v 4 platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk app-release.apk
