docker build -t lokideos/multi-client:latest -t lokideos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lokideos/multi-server:latest -t lokideos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lokideos/multi-worker:latest -t lokideos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lokideos/multi-client:latest
docker push lokideos/multi-server:latest
docker push lokideos/multi-worker:latest

docker push lokideos/multi-client:$SHA
docker push lokideos/multi-server:$SHA
docker push lokideos/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lokideos/multi-server:$SHA
kubectl set image deployments/client-deployment client=lokideos/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lokideos/multi-worker:$SHA