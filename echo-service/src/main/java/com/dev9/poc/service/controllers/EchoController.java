package com.dev9.poc.service.controllers;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import static java.lang.String.join;

/**
 *
 */
@Controller
public class EchoController {

    @RequestMapping(path = "/headers", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    Map echo(WebRequest req) {
        Map res = new HashMap();
        res.put("res", "OK");
        Iterator<String> headers = req.getHeaderNames();
        while (headers.hasNext()) {
            String k = headers.next();
            String v = join(",", req.getHeaderValues(k));
            res.put(k, v);
        }

        return res;
    }
}
