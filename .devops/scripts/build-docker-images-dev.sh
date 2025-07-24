
./mvnw clean package

docker build -t "petclinic-admin-server:dev" \
  -f ./docker/Dockerfile ./spring-petclinic-admin-server/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-admin-server-3.4.1 \
  --build-arg EXPOSED_PORT=9090

docker build -t "petclinic-api-gateway:dev" \
  -f ./docker/Dockerfile ./spring-petclinic-api-gateway/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-api-gateway-3.4.1 \
  --build-arg EXPOSED_PORT=8080

docker build -t "petclinic-config-server:dev" \
  -f ./docker/Dockerfile ./spring-petclinic-config-server/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-config-server-3.4.1 \
  --build-arg EXPOSED_PORT=8888

docker build -t "petclinic-customers-service:dev" \
  -f ./docker/Dockerfile ./spring-petclinic-customers-service/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-customers-service-3.4.1 \
  --build-arg EXPOSED_PORT=8081

docker build -t "petclinic-discovery-server:dev" \
  -f ./docker/Dockerfile ./spring-petclinic-discovery-server/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-discovery-server-3.4.1 \
  --build-arg EXPOSED_PORT=8761

docker build -t "petclinic-genai-service:dev" \
  -f ./docker/Dockerfile ./spring-petclinic-genai-service/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-genai-service-3.4.1 \
  --build-arg EXPOSED_PORT=9091

docker build -t "petclinic-vets-service:dev" \
  -f ./docker/Dockerfile ./spring-petclinic-vets-service/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-vets-service-3.4.1 \
  --build-arg EXPOSED_PORT=8082

docker build -t "petclinic-visits-service:dev" \
  -f ./docker/Dockerfile ./spring-petclinic-visits-service/target \
  --build-arg ARTIFACT_NAME=spring-petclinic-visits-service-3.4.1 \
  --build-arg EXPOSED_PORT=8083

docker build  -t "petclinic-grafana-server:dev" ./docker/grafana
docker build  -t "petclinic-prometheus-server:dev" ./docker/prometheus

