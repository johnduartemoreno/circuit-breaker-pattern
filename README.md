
# Circuit Breaker Pattern con Hystrix y Kubernetes

Este repositorio contiene la implementación del patrón **Circuit Breaker** usando **Hystrix** y desplegado en **Kubernetes** con **Istio**.

## Estructura

- **docs/**: Explicaciones detalladas del patrón y conceptos clave.
- **src/**: Código fuente del microservicio con Hystrix.
- **k8s/**: Archivos de configuración para desplegar en Kubernetes e implementar el Circuit Breaker con Istio.

## Cómo usar este repositorio

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/johnduartemoreno/circuit-breaker-pattern.git
   cd circuit-breaker-pattern
   ```

2. **Despliega el servicio en Kubernetes**:
   ```bash
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   ```

3. **Configura Istio**:
   ```bash
   kubectl apply -f k8s/istio-destination-rule.yaml
   ```

4. **Prueba el Circuit Breaker** usando `curl` o Postman:
   ```bash
   curl http://localhost:8080/my-api
   ```

Para más información sobre el patrón, revisa los archivos en la carpeta `docs/`.
