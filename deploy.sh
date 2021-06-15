docker build -t davisdavis27french/multi-client:latest -t davisdavis27french/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t davisdavis27french/multi-server:latest -t davisdavis27french/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t davisdavis27french/multi-worker:latest -t davisdavis27french/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push davisdavis27french/multi-client:latest
docker push davisdavis27french/multi-server:latest
docker push davisdavis27french/multi-worker:latest

docker push davisdavis27french/multi-client:$SHA
docker push davisdavis27french/multi-server:$SHA
docker push davisdavis27french/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=davisdavis27french/multi-server:$SHA
kubectl set image deployments/client-deployment client=davisdavis27french/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=davisdavis27french/multi-worker:$SHA
