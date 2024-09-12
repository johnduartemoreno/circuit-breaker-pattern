# Conceptos del patrón Circuit Breaker

## ¿Qué es el Circuit Breaker?

El **Circuit Breaker** es un patrón de diseño utilizado para gestionar fallos en servicios remotos o dependencias externas de manera que el sistema pueda recuperarse y no se sobrecargue. Funciona de manera similar a un interruptor eléctrico: si detecta fallos continuos en un servicio, "abre el circuito" y bloquea las solicitudes hacia dicho servicio por un tiempo determinado. Luego, intenta restablecer las conexiones para ver si el servicio se ha recuperado.

### Ventajas del Circuit Breaker:
- Evita sobrecargar servicios fallidos.
- Proporciona tiempos de recuperación a los servicios dependientes.
- Mejora la resiliencia del sistema al manejar fallos intermitentes.
  
## Componentes Clave del Circuit Breaker:

1. **Estado Cerrado (Closed)**: El circuito está cerrado y las solicitudes pasan normalmente al servicio externo. Si ocurren errores consecutivos, el estado cambia a abierto.
   
2. **Estado Abierto (Open)**: Cuando se detectan fallos consecutivos, el circuito se abre y las solicitudes son rechazadas para evitar sobrecargar el servicio fallido.

3. **Estado Semiabierto (Half-Open)**: Después de un tiempo, el circuito permite el paso de algunas solicitudes para comprobar si el servicio ha vuelto a estar disponible.

4. **Tiempo de Recuperación**: Tiempo que el sistema espera antes de probar nuevamente si el servicio externo está disponible.

### Casos de uso:
- Cuando dependes de servicios externos inestables.
- Para evitar la sobrecarga de recursos del sistema cuando una dependencia externa falla repetidamente.

## Implementación con Istio

En este proyecto, usamos **Istio** para gestionar el Circuit Breaker a nivel de red en Kubernetes. **Istio** es una malla de servicios que permite controlar el tráfico de red entre microservicios, implementar balanceo de carga, y manejar políticas de seguridad y resiliencia, como es el caso del Circuit Breaker.

### ¿Por qué usar Istio en este contexto?
1. **Monitoreo de tráfico**: Istio permite observar el tráfico entre los servicios en tiempo real.
2. **Control de resiliencia**: Podemos gestionar la cantidad de errores permitidos antes de abrir el circuito.
3. **Facilidad de integración**: Istio se integra perfectamente con Kubernetes para gestionar las políticas de red.

### Reglas de destino (DestinationRule) con Istio

En nuestro archivo de configuración `istio-destination-rule.yaml`, especificamos una **DestinationRule** para implementar el patrón Circuit Breaker en `my-service`. Estas reglas indican cómo manejar los fallos y la política de tráfico que se debe aplicar:

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: my-service-circuit-breaker
spec:
  host: my-service
  trafficPolicy:
    outlierDetection:
      consecutiveErrors: 2
      interval: 5s
      baseEjectionTime: 15m
      maxEjectionPercent: 50
```

### Explicación:
- **consecutiveErrors**: El número de errores consecutivos antes de activar el Circuit Breaker.
- **interval**: El tiempo entre intentos de detección de fallos.
- **baseEjectionTime**: Tiempo base durante el cual un servicio fallido será retirado del balanceo de carga.
- **maxEjectionPercent**: El porcentaje máximo de instancias que pueden ser eliminadas cuando se detectan fallos.

---

## Ejercicio práctico

1. **Usar la imagen Docker de `my-service`**:
   La imagen  está disponible en Docker Hub

   ```yaml
   image: jduartem/my-service:latest


2. **Aplicar los despliegues en Kubernetes**:
   ```bash
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml
   ```

3. **Instalar Istio**:
   Ejecuta el script de instalación:
   ```bash
   ./install_istio.sh
   ```

4. **Aplicar las reglas de Circuit Breaker en Istio**:
   ```bash
   kubectl apply -f k8s/istio-destination-rule.yaml
   ```

5. **Verifica el estado de los servicios**:
   ```bash
   kubectl get services
   kubectl get pods
   ```

## Conclusión

El patrón Circuit Breaker es crucial para asegurar la resiliencia en sistemas distribuidos, especialmente en entornos con microservicios. Usando Istio en Kubernetes, logramos una implementación eficiente y fácilmente configurable para controlar los fallos entre servicios.
