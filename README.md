# Radio-station
これはRadikoから、プライベートPodcastを作成します。(著作物を扱うため、個人利用の範囲にとどめてください。自己責任で!)
1. `/infrastructure/main.tf`に番組情報を登録します
2. AWS SSMにRadikoのEmail/パスワードを登録します。
  a. /radio-station/email
  b. /radio-station/password
3. インフラを構築します(remote stateをterraform cloudで管理するので、Projectを作ってください)<br>
`$ cd infrastructure && terraform apply`
4. ECRが作成されるので、コンテナをビルドしてアップロードします<br>
`$ sh push_container.sh`
5. 2.のoutputで出力されたURLにApplePodcast等Basic認証に対応しているクライアントに登録する。
