
package com.example.circuitbreaker;

import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MyService {

    @HystrixCommand(fallbackMethod = "fallbackMethod")
    @GetMapping("/my-api")
    public String callExternalService() {
        // Simulación de llamada a un servicio externo que puede fallar
        if (Math.random() > 0.5) {
            throw new RuntimeException("Servicio externo falló");
        }
        return "Respuesta exitosa del servicio externo";
    }

    // Método que se ejecuta si el circuito se abre
    public String fallbackMethod() {
        return "El servicio no está disponible temporalmente, por favor intente más tarde";
    }
}
