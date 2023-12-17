ETCD_VER:=v3.5.6
build:
	curl -O https://storage.googleapis.com/etcd/$(ETCD_VER)/etcd-$(ETCD_VER)-linux-amd64.tar.gz
	mkdir -p tmp
	tar xzvf ./etcd-$(ETCD_VER)-linux-amd64.tar.gz -C ./tmp --strip-components=1
	docker build . -t xhpolaris/etcd-backup