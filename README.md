# twemproxy-docker
twemproxyのコンテナイメージを作成する。

## twemproxy とは
memcachedおよびredisプロトコル用のプロクシソフトウェア。
Twitter社が作成。
[twemproxy](https://github.com/twitter/twemproxy)

- [Recommendation for production environment](https://github.com/twitter/twemproxy/blob/master/notes/recommendation.md)
- [Memcache Command Support](https://github.com/twitter/twemproxy/blob/master/notes/memcache.md)
- [Redis Command Support](https://github.com/twitter/twemproxy/blob/master/notes/redis.md)

## ビルド
```
REPOSITORY_NAME=test/twemproxy
IMAGE_TAG=0.5.0
docker build -t ${REPOSITORY_NAME}:${IMAGE_TAG} .
```

## 設定変更
`nutcracker.yml` を `/usr/local/twemproxy/etc/nutcracker.yml` に配置することで設定変更を行うことが可能。

## 起動オプション変更
デフォルトでは `CMD` にて `nutcracker -v6 -c /usr/local/twemproxy/etc/nutcracker.yml` を実施するよう設定している。
`CMD` にて任意オプションを含めた実行コマンドを設定する事で起動オプションの変更が可能。