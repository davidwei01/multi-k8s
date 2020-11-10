docker build -t davidwei01/multi-client:latest -t davidwei01/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t davidwei01/multi-server:latest -t davidwei01/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t davidwei01/multi-worker:latest -t davidwei01/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push davidwei01/multi-client:latest
docker push davidwei01/multi-server:latest
docker push davidwei01/multi-worker:latest

docker push davidwei01/multi-client:$SHA
docker push davidwei01/multi-server:$SHA
docker push davidwei01/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=davidwei01/multi-server:$SHA
kubectl set image deployments/client-deployment server=davidwei01/multi-client:$SHA
kubectl set image deployments/worker-deployment server=davidwei01/multi-worker:$SHA