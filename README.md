# Aplicação para gerenciar os builds hibridos do repósitório sol-supplier-frontend

```
npm -version
6.1.0

node --version
v10.6.0

cordova --version
8.1.2 (cordova-lib@8.1.1)
```

- Criar symlink da pasta `/dist` - `ln -s ../sol-supplier-frontend/dist www`
- Adicionar plataforma iOS `cordova platform add ios@4.5.5`
- Adicionar plataforma Android `cordova platform add android@7.1.2`
- Listar plataformas instaladas `cordova platform ls`
- Listar requisitos `cordova requirements`

```
Android Studio project detected

Requirements check results for android:
Java JDK: installed 1.8.0
Android SDK: installed true
Android target: installed android-28,android-27,android-26,android-23
Gradle: installed /usr/local/Cellar/gradle/5.0/bin/gradle

Requirements check results for ios:
Apple macOS: installed darwin
Xcode: installed 9.4.1
ios-deploy: installed 1.9.4
CocoaPods: installed 1.5.3
```

Cada plataforma necessita de requisitos diferentes que podem ser [listados aqui](https://cordova.apache.org/docs/en/latest/guide/cli/#install-pre-requisites-for-building)

Exemplo de paths adicionado no `~/.bashrc` ou `~/.zshrc`

```
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_191.jdk/Contents/Home
export ANDROID_HOME=/Users/dpedoneze/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$JAVA_HOME/bin
export CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL=https\://services.gradle.org/distributions/gradle-4.6-all.zip
```

Para adicionar `Android target` você precisa fazer isso pela GUI do Android Studio (`Preferences... > Appearance & Behavior > System Settings > Android SDK > aba SDK Platform`).

- Adicionar plugin `cordova plugin add cordova-plugin-firebase`
> Em 06/05/19 uma atualização do firebase causou um erro no plugin, por isso
> informar o git https://github.com/dpa99c/cordova-plugin-firebase
- Outra opção (ao invés do git) é editar o arquivo /platforms/android/project.properties com as opções:
```
cordova.system.library.2=com.google.firebase:firebase-core:16.0.8
cordova.system.library.3=com.google.firebase:firebase-messaging:17.5.0
cordova.system.library.4=com.google.firebase:firebase-config:16.4.1
cordova.system.library.5=com.google.firebase:firebase-perf:16.2.4
```

- Atualizar `platforms/androd/cordova-plugin-firebase/supplier-build.gradle

`compile 'com.google.firebase:firebase-auth:16.2.1'`

- Em alguns casos é necessário execurar `cordova clean android` para atualizar o processo de build

# Passo a passo para criar builds android/ios
- Buildar a aplicação do repositório `sol-supplier-frontend` com `yarn run build`
- Criar build android `cordova build android`
- Criar build iOS `cordova build ios` (`cordova run ios` para rodar o build no simulador do xcode)


# Passo para gerar o apk para release
- Gerar chave para assinar o apk (uma única vez)
`keytool -genkey -v -keystore android.keystore -alias br.gov.ba.car.supplier -keyalg RSA -keysize 2048 -validity 10000`

- Gerar apk
`cordova build android --release`

- Assinar apk (acessar local onde o apk foi gerado)
`jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore android.keystore app-release-unsigned.apk br.gov.ba.car.supplier`

- Otimizar apk
`zipalign -v 4 app-release-unsigned.apk app-release.apk`

- Atualizar play store com o apk gerado `app-release.apk`
