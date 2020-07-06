EC2にSSH接続という誰もが通る道をTerraformでもやってみる
## 1.鍵生成
```
ssh-keygen -t rsa -b 4096 -f test.pem
```
## 2.いつもの
```
terraform init
terraform plan
terraform apply
```
applyしたらパブリックIPが出てくるのでそれを活用
## 3.SSH接続
ここのやり方は各々違うかと。
## 4.後始末
```
terraform destroy
```
間違ってもtest.pemをgithubにあげてはいけない...