docker build -t aleksgorbenko/multi-client:latest -t aleksgorbenko/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aleksgorbenko/multi-server:latest -t aleksgorbenko/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aleksgorbenko/multi-worker:latest -t aleksgorbenko/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aleksgorbenko/multi-client:latest
docker push aleksgorbenko/multi-server:latest
docker push aleksgorbenko/multi-worker:latest

docker push aleksgorbenko/multi-client:$SHA
docker push aleksgorbenko/multi-server:$SHA
docker push aleksgorbenko/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=aleksgorbenko/multi-client:$SHA
kubectl set image deployments/server-deployment server=aleksgorbenko/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=aleksgorbenko/multi-worker:$SHA