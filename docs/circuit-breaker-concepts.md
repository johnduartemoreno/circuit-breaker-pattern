
## Probar el Servicio con `kubectl port-forward`

Para probar el servicio **my-service** implementado en Kubernetes, usar el comando `kubectl port-forward` para redirigir el tráfico de un puerto local hacia el servicio en el clúster de Kubernetes.

### Pasos:

1. **Aplicar los archivos de configuración de Kubernetes**:
   Los archivos YAML que crean el deployment, el service y las configuraciones de Istio. Ejecuntando el comando:

   ```bash
   kubectl apply -f k8s/
   ```

   Esto creará el servicio y desplegará el microservicio.

2. **Revisar que el pod y el servicio estén en estado 'Running'**:
   Para asegurar que el servicio esté funcionando correctamente, verificar que los pods estén corriendo:

   ```bash
   kubectl get pods
   ```

   verificar que el servicio está activo:

   ```bash
   kubectl get services
   ```

3. **Usar `port-forward` para acceder al servicio**:
   Como estamos utilizando un servicio de tipo **ClusterIP**, no tenemos acceso directo desde fuera del clúster. Para probarlo localmente, utilizamos `kubectl port-forward` para redirigir un puerto local al puerto del servicio:

   ```bash
   kubectl port-forward service/my-service 8080:80
   ```

   Esto hará que cualquier solicitud enviada a `http://localhost:8080` sea redirigida al servicio **my-service** en el clúster.

4. **Probar el servicio usando `curl`**:
   Una vez que `port-forward` esté funcionando, se podrá realizar solicitudes HTTP al servicio con:

   ```bash
   curl http://localhost:8080
   ```

   Si todo está funcionando correctamente, se debería obtener la respuesta del servicio **my-service**.

---

Este enfoque permite probar y depurar el microservicio sin necesidad de exponerlo públicamente o usar herramientas de gestión de clústeres externas.
