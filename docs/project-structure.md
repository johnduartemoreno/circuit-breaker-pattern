
# Estructura del Proyecto: Circuit Breaker con Spring Boot

## 1. Introducción a la Estructura de un Proyecto Spring Boot

Este documento describe la estructura del proyecto de ejemplo para el patrón **Circuit Breaker**, que utiliza **Spring Boot** y **Hystrix**. La estructura sigue las mejores prácticas de organización para aplicaciones Java basadas en Spring Boot.

### a) **`src/main/java/com/example/circuitbreaker`**

Este directorio contiene todo el código fuente de la aplicación. Siguiendo la convención de **paquetes Java**, el nombre del paquete refleja el dominio inverso, lo cual es una práctica estándar en el desarrollo de aplicaciones empresariales en Java.

#### Archivos importantes:

- **`MyService.java`**:
  Esta clase implementa la lógica del microservicio. Está anotada con `@RestController`, lo que significa que expone un API HTTP. Además, utiliza la anotación `@HystrixCommand` para aplicar el patrón **Circuit Breaker**, con un método de fallback en caso de fallas continuas.

- **`CircuitBreakerApplication.java`**:
  Esta es la clase principal que inicializa y ejecuta la aplicación Spring Boot. La anotación `@SpringBootApplication` habilita varias características automáticas de Spring, incluyendo la configuración y el escaneo de componentes.

### b) **`src/resources`**

El directorio **`resources`** contiene archivos de configuración y otros recursos que la aplicación necesita en tiempo de ejecución.

#### Archivos importantes:

- **`application.yml`**:
  Este archivo YAML contiene la configuración de **Hystrix**, que define cómo debe comportarse el **Circuit Breaker**. Aquí se especifican el umbral de fallos, el tiempo de espera antes de abrir el circuito, y otras propiedades.

```yaml
hystrix:
  command:
    default:
      execution:
        isolation:
          thread:
            timeoutInMilliseconds: 3000
      circuitBreaker:
        requestVolumeThreshold: 5
        sleepWindowInMilliseconds: 5000
        errorThresholdPercentage: 50
```

### c) **Estructura del Código**

1. **CircuitBreakerApplication.java**:
   - Esta clase arranca la aplicación Spring Boot y crea un servidor web embebido que ejecuta la aplicación.

2. **MyService.java**:
   - Define el microservicio que expone un API HTTP (`/my-api`) y usa **Hystrix** para protegerse de fallos en servicios externos.
   - El método de respaldo (`fallbackMethod`) devuelve una respuesta predeterminada cuando el servicio externo falla repetidamente.

3. **application.yml**:
   - Configura las propiedades relacionadas con el **Circuit Breaker** usando **Hystrix** para manejar la resiliencia en las llamadas a servicios externos.

---

## 2. Flujo General de la Aplicación

### Paso 1: Arranque de la Aplicación
La aplicación se inicia con **SpringApplication.run()** en la clase `CircuitBreakerApplication.java`. Esto activa el servidor web embebido (generalmente Tomcat) y comienza a aceptar solicitudes HTTP.

### Paso 2: Manejo de Solicitudes HTTP
El microservicio definido en `MyService.java` maneja las solicitudes GET en el endpoint `/my-api`. Este servicio intenta realizar una operación con un servicio externo que puede fallar. En caso de fallo repetido, Hystrix abre el Circuit Breaker y llama al método de respaldo `fallbackMethod()`.

### Paso 3: Configuración del Circuit Breaker
El archivo `application.yml` define cómo Hystrix debe comportarse cuando detecta fallos. Esto incluye la cantidad de fallos permitidos antes de abrir el Circuit Breaker, el tiempo de espera antes de reintentar, y otros parámetros.

---

## 3. Conclusión

Esta estructura modular permite una clara separación de responsabilidades en la aplicación:
- El código fuente (Java) está organizado en paquetes para facilitar la escalabilidad.
- La configuración de Hystrix y otros parámetros están separados en archivos YAML, lo que facilita su modificación sin necesidad de cambiar el código fuente.
