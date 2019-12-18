docker build -t iamvvms/multi-client:latest -t iamvvms/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t iamvvms/multi-server:latest -t iamvvms/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t iamvvms/multi-worker:latest -t iamvvms/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push iamvvms/multi-client:latest
docker push iamvvms/multi-server:latest
docker push iamvvms/multi-worker:latest

docker push iamvvms/multi-client:$SHA
docker push iamvvms/multi-server:$SHA
docker push iamvvms/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=iamvvms/multi-server:$SHA
kubectl set image deployments/client-deployment client=iamvvms/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=iamvvms/multi-worker:$SHA
