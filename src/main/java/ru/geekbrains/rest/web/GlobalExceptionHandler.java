package ru.geekbrains.rest.web;

import org.springframework.core.NestedRuntimeException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestControllerAdvice
public class GlobalExceptionHandler {

//    @ResponseStatus(value= HttpStatus.CONFLICT)
    @ResponseBody
    @ExceptionHandler(NestedRuntimeException.class)
    public ResponseEntity handleIOException(NestedRuntimeException ex){
        return  ResponseEntity.status(HttpStatus.CONFLICT).contentType(MediaType.APPLICATION_JSON_UTF8)
                .body(ex.getRootCause().getMessage());
    }
}
