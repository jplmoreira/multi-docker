docker build -t jplmoreira/multi-client:latest -t jplmoreira/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jplmoreira/multi-server:latest -t jplmoreira/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jplmoreira/multi-worker:latest -t jplmoreira/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jplmoreira/multi-client:latest
docker push jplmoreira/multi-client:$SHA
docker push jplmoreira/multi-server:latest
docker push jplmoreira/multi-server:$SHA
docker push jplmoreira/multi-worker:latest
docker push jplmoreira/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jplmoreira/multi-client:$SHA
kubectl set image deployments/server-deployment server=jplmoreira/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jplmoreira/multi-worker:$SHA
