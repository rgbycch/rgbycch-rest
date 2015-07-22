/**
 * 
 */
package com.gffny.rgbycch.service.impl;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gffny.rgbycch.dao.GenericDao;
import com.gffny.rgbycch.model.Club;
import com.gffny.rgbycch.service.ClubService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Service
public class ClubServiceImpl implements ClubService {

    @Autowired
    private GenericDao<Club, Integer> clubRepository;

    /**
     * (non-Javadoc)
     * 
     * @see com.gffny.rgbycch.service.EntityManagmentService#findById(java.lang.String)
     */
    @Override
    public Club findById(Integer id) {
	return clubRepository.findById(id);
    }

    /**
     * (non-Javadoc)
     * 
     * @see com.gffny.rgbycch.service.EntityManagmentService#insert(com.gffny.rgbycch.model.BaseEntity)
     */
    @Override
    public Club insert(Club club) {
	throw new NotImplementedException(
		"clubs should not be createable through service methods");
    }

}
