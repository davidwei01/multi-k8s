docker build -t davidwei01docker/multi-client:latest -t davidwei01docker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t davidwei01docker/multi-server:latest -t davidwei01docker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t davidwei01docker/multi-worker:latest -t davidwei01docker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push davidwei01docker/multi-client:latest
docker push davidwei01docker/multi-server:latest
docker push davidwei01docker/multi-worker:latest

docker push davidwei01docker/multi-client:$SHA
docker push davidwei01docker/multi-server:$SHA
docker push davidwei01docker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=davidwei01docker/multi-server:$SHA
kubectl set image deployments/client-deployment client=davidwei01docker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=davidwei01docker/multi-worker:$SHA