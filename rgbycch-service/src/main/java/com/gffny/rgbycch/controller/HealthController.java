/**
 * 
 */
package com.gffny.rgbycch.controller;

import java.util.Collections;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Controller
public class HealthController extends V1RestController {

    @RequestMapping(value = "/health", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, String> getRugbyClub() {
	return Collections.singletonMap("health", "ok");
    }
}
