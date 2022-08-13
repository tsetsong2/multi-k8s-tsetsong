docker build -t tsetsongdevops/multi-client:latest -t tsetsongdevops/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tsetsongdevops/multi-server:latest -t tsetsongdevops/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tsetsongdevops/multi-worker:latest -t tsetsongdevops/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tsetsongdevops/multi-client:latest
docker push tsetsongdevops/multi-server:latest
docker push tsetsongdevops/multi-worker:latest
docker push tsetsongdevops/multi-client:$SHA
docker push tsetsongdevops/multi-server:$SHA
docker push tsetsongdevops/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tsetsongdevops/multi-server:$SHA
kubectl set image deployments/client-deployment client=tsetsongdevops/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tsetsongdevops/multi-worker:$SHA
