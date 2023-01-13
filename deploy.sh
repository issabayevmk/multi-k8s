docker build -t issabayevmk/multi-client:latest -t issabayevmk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t issabayevmk/multi-server:latest -t issabayevmk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t issabayevmk/multi-worker:latest -t issabayevmk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push issabayevmk/multi-client:latest
docker push issabayevmk/multi-server:latest
docker push issabayevmk/multi-worker:latest

docker push issabayevmk/multi-client:$SHA
docker push issabayevmk/multi-server:$SHA
docker push issabayevmk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=issabayevmk/multi-server:$SHA
kubectl set image deployments/client-deployment client=issabayevmk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=issabayevmk/multi-worker:$SHA
