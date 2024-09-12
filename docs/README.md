# Circuit Breaker Pattern

El patrón **Circuit Breaker** es utilizado para evitar fallos en cascada en arquitecturas distribuidas, especialmente en microservicios. Cuando un servicio falla o su rendimiento es bajo, el **Circuit Breaker** impide que las solicitudes lleguen a ese servicio, protegiendo el sistema de fallos adicionales.

## Objetivo del Patrón

- Proteger servicios que dependen de otros servicios externos.
- Aumentar la resiliencia del sistema.
- Evitar sobrecargas por servicios que ya están fallando.

## Ejercicio

En este repositorio, implementaremos un **Circuit Breaker** utilizando **Istio** en un microservicio desplegado en **Kubernetes**.

Consulta la carpeta `src/` para el código fuente y la carpeta `k8s/` para los archivos de configuración de Kubernetes e Istio.

Para más detalles sobre el patrón y la configuración con **Istio**, revisa el archivo [circuit-breaker-concepts.md](./circuit-breaker-concepts.md).
