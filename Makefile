item = Small sshd container
package = container-alpine-sshd
container = $(package)-container
version = 0.1

install: clean
	rm -f rsa-2048*
	ssh-keygen -t rsa -b 2048 -N "" -f rsa-2048
	docker build -t $(package) .

run:
	docker run -d --rm --name $(container) -p=2222:22 $(package)
#	ssh-keygen -R [localhost]:2222

provision:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook playbook.yml -i hosts --key-file rsa-2048

clean:
	docker stop $(container) || true && docker rm $(container) || true
	docker rmi $(package) || true

