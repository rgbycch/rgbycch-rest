/**
 * 
 */
package com.gffny.rgbycch.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gffny.rgbycch.model.Club;
import com.gffny.rgbycch.service.ClubService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Controller
public class ClubRestController extends V1RestController {

    @Autowired
    private ClubService clubService;

    /**
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "/club/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Club> getClub(@PathVariable Integer id) {
	LOG.debug("get club with id {}", id);
	return new ResponseEntity<Club>(clubService.findById(id), HttpStatus.OK);
    }

    /**
     * 
     * @param id
     * @param club
     * @return
     */
    @RequestMapping(value = "/club/{id}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Club> setClub(@PathVariable String id,
	    @RequestBody Club club) {
	LOG.debug("update club with id {}", id);
	// clubService.persist
	return new ResponseEntity<Club>(club, HttpStatus.OK);
    }
}
