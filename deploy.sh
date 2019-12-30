docker build -t infine/multi-client:latest -t infine/multi-client:$SHA ./client
docker build -t infine/multi-server:latest -t infine/multi-server:$SHA ./server
docker build -t infine/multi-worker:latest -t infine/multi-worker:$SHA ./worker

docker push infine/multi-client:latest
docker push infine/multi-server:latest
docker push infine/multi-worker:latest

docker push infine/multi-client:$SHA
docker push infine/multi-server:$SHA
docker push infine/multi-worker:$SHA


kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=infine/multi-server:$SHA
kubectl set image deployments/client-deployment client=infine/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=infine/multi-worker:$SHA