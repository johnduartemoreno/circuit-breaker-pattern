
# Conceptos del Patrón Circuit Breaker

El **patrón Circuit Breaker** ayuda a manejar fallos en cascada en sistemas distribuidos. Se basa en tres estados:

1. **Cerrado (Closed)**: Las solicitudes fluyen normalmente hacia el servicio.
2. **Abierto (Open)**: Las solicitudes no son enviadas al servicio cuando se detectan múltiples fallos consecutivos.
3. **Semi-abierto (Half-Open)**: Después de un tiempo de espera, se permite que algunas solicitudes lleguen al servicio para probar si ha vuelto a la normalidad.

## Ejemplo de Configuración con Hystrix

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

- **timeoutInMilliseconds**: Tiempo máximo que permitimos para que el servicio responda.
- **requestVolumeThreshold**: Número de solicitudes fallidas antes de abrir el circuito.
- **sleepWindowInMilliseconds**: Tiempo de espera antes de probar el servicio nuevamente.
- **errorThresholdPercentage**: Porcentaje de fallos para abrir el circuito.
