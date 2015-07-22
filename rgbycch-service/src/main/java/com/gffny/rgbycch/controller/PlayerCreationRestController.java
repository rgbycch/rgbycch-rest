/**
 * 
 */
package com.gffny.rgbycch.controller;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.gffny.rgbycch.model.Player;
import com.gffny.rgbycch.service.PlayerService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Controller
public class PlayerCreationRestController extends V1RestController {

    @InitBinder
    public void setAllowedFields(WebDataBinder dataBinder) {
	dataBinder.setAllowedFields((String[]) ArrayUtils.addAll(
		PlayerRestController.ALLOWED_FIELDS, new String[] {}));
    }

    @Autowired
    private PlayerService playerService;

    @ModelAttribute("player")
    public Player getPlayer() {
	return new Player();
    }

    @RequestMapping(value = "/player", method = RequestMethod.POST)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.CREATED)
    public Player create(@RequestBody Player player, BindingResult bindingResult)
	    throws BindException {

	// insert validation
	return playerService.insert(player);
    }
}
