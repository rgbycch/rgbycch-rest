/**
 * 
 */
package com.gffny.rgbycch.service.impl;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gffny.rgbycch.dao.GenericDao;
import com.gffny.rgbycch.model.Match;
import com.gffny.rgbycch.service.MatchService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Service
public class MatchServiceImpl implements MatchService {

    @Autowired
    private GenericDao<Match, Integer> matchRepository;

    /**
     * (non-Javadoc)
     * 
     * @see com.gffny.rgbycch.service.EntityManagmentService#findById(java.lang.String)
     */
    @Override
    public Match findById(Integer id) {
	return matchRepository.findById(id);
    }

    /**
     * (non-Javadoc)
     * 
     * @see com.gffny.rgbycch.service.EntityManagmentService#insert(com.gffny.rgbycch.model.BaseEntity)
     */
    @Override
    public Match insert(Match match) {
	throw new NotImplementedException(
		"clubs should not be createable through service methods");
    }

}
