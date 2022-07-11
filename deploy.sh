# Build Images
docker build -t rahulpargi/client:latest rahulpargi/client:$SHA -f ./client/Dockerfile ./client
docker build -t rahulpargi/server:latest rahulpargi/server:$SHA -f ./server/Dockerfile ./server
docker build -t rahulpargi/worker:latest rahulpargi/worker:$SHA -f ./worker/Dockerfile ./worker

# Push images to dockerhub
docker push rahulpargi/client:latest
docker push rahulpargi/server:latest
docker push rahulpargi/worker:latest

docker push rahulpargi/client:$SHA
docker push rahulpargi/server:$SHA
docker push rahulpargi/worker:$SHA

# Apply config
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rahulpargi/server:$SHA
kubectl set image deployments/client-deployment server=rahulpargi/client:$SHA
kubectl set image deployments/worker-deployment server=rahulpargi/worker:$SHA