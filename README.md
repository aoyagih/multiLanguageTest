# multiLanguageTest
This app changes languages(Japanese⇔English) depending on language setting of your iOS device.

### テスト項目
以下の4つの切り替えをテストした。
- ローカル上のテキスト
- サーバー上のテキスト(Firebase/Firestore)
- ローカル上の画像
- サーバー上の画像(Firebase/Storage)

### 切り替え方法  
- ローカル上のテキスト  
(1)を参考に、"Localizable.strings"ファイルを作成し、切り替えたいテキストに対してそれぞれ辞書`"key" = "value";`を定義する。  (注意: Localizable.stringsの各行末にはセミコロンが必要！)  
そして、`ViewController.swift`で`(UILabelの変数名).text = NSLocalizedString("Localizable.stringsのkey", comment: "")`を書き込む。   
- それ以外の3つ  
(2)を参考に、端末の言語設定を取得し、各言語に対して`if-else`文を書く。  
その中でFirebaseの参照先を変えたり、`(UIImageViewの変数名).image = UIImage("Assetsなどの画像名")`で切り替える。

### 参考URL
(1)"Localizable.strings"を用いたローカル上のテキストの切り替え  
https://youtu.be/IV1x9FgQ5v0  
(2)端末の言語設定を取得する方法  
https://program-life.com/592  
