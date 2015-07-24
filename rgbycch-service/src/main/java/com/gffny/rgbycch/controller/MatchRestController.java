/**
 * 
 */
package com.gffny.rgbycch.controller;

import io.swagger.annotations.Api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gffny.rgbycch.model.Match;
import com.gffny.rgbycch.service.MatchService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Api(value = "match")
// Swagger annotation
@Controller
public class MatchRestController extends V1RestController {

    @Autowired
    private MatchService matchService;

    /**
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "/match/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Match> getMatch(@PathVariable Integer id) {
	LOG.debug("get club with id {}", id);
	return new ResponseEntity<Match>(matchService.findById(id),
		HttpStatus.OK);
    }

    /**
     * 
     * @param id
     * @param club
     * @return
     */
    @RequestMapping(value = "/match/{id}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Match> setMatch(@PathVariable String id,
	    @RequestBody Match match) {
	LOG.debug("update club with id {}", id);
	return new ResponseEntity<Match>(match, HttpStatus.OK);
    }
}
