/**
 * 
 */
package com.gffny.rgbycch.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@RequestMapping("/rest/v1")
abstract class V1RestController {

    protected final Logger LOG = LoggerFactory.getLogger(this.getClass());

}
