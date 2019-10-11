docker stop crohdad
docker rm crohdad
docker image build -t crohdad-test . --network=host
sudo docker run -itd --name crohdad --privileged --net=host -v /var/run/docker.sock:/var/run/docker.sock -v /etc/iproute2/rt_tables:/etc/iproute2/rt_tables -v /dev/log:/dev/log -v /root/.kube:/root/.kube crohdad-test --expose-all-services --expose-pods
