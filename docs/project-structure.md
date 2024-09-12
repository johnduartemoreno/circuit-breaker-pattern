
# Estructura del Proyecto: Circuit Breaker con Istio

## 1. Introducción a la Estructura del Proyecto

Este documento describe la estructura del proyecto de ejemplo para el patrón **Circuit Breaker**, que utiliza **Istio** en un entorno de microservicios desplegado en **Kubernetes**.

### a) **`services/`**

Este directorio contiene los servicios desarrollados para el proyecto. Cada microservicio está organizado en subdirectorios separados bajo la carpeta `services/`, lo que permite una estructura modular y escalable.

#### Archivos importantes:

- **`my-service/`**:
  Esta carpeta contiene el código fuente del microservicio `my-service`. Está desarrollado con **Node.js** y utiliza Express para exponer una API HTTP.

### b) **`k8s/`**

El directorio **`k8s/`** contiene los archivos de configuración de Kubernetes que definen el despliegue y la exposición de los microservicios.

#### Archivos importantes:

- **`deployment.yaml`**:
  Define el despliegue de `my-service` en el clúster de Kubernetes, especificando las réplicas y la configuración de los contenedores.
  
- **`istio-destination-rule.yaml`**:
  Implementa la regla de destino de Istio para habilitar el patrón **Circuit Breaker** a nivel de red, protegiendo el servicio de fallos continuos.

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

### c) **Estructura del Código**

1. **my-service/index.js**:
   - Define la lógica principal del microservicio `my-service`, manejando solicitudes HTTP en un entorno de Node.js.

2. **k8s/deployment.yaml**:
   - Configura el despliegue del servicio en Kubernetes.

3. **k8s/istio-destination-rule.yaml**:
   - Define la política de destino de Istio para habilitar el patrón de resiliencia **Circuit Breaker**.

---

## 2. Flujo General de la Aplicación

### Paso 1: Despliegue en Kubernetes
El servicio `my-service` se despliega en un clúster de **Kubernetes** utilizando el archivo `deployment.yaml`. La imagen de Docker correspondiente se obtiene del repositorio de Docker Hub.

### Paso 2: Protección con Istio
El patrón **Circuit Breaker** se implementa a través de una configuración de Istio en el archivo `istio-destination-rule.yaml`. Esta configuración define cómo debe comportarse el **Circuit Breaker** cuando detecta fallos en el servicio.

### Paso 3: Monitoreo de Fallos
El servicio está protegido por las reglas de **outlierDetection** de Istio, que monitorean los errores consecutivos y, en caso de alcanzar el umbral definido, activan el **Circuit Breaker**, evitando que el servicio continúe fallando.

---

## 3. Conclusión

Esta estructura modular permite una clara separación de responsabilidades en la aplicación:
- El código fuente de los servicios está organizado de manera que facilita la escalabilidad y el mantenimiento.
- La configuración de Istio y Kubernetes permite un control eficiente del despliegue y la resiliencia de los servicios.
