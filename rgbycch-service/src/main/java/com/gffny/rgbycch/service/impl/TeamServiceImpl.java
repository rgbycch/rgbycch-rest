/**
 * 
 */
package com.gffny.rgbycch.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gffny.rgbycch.dao.GenericDao;
import com.gffny.rgbycch.model.Team;
import com.gffny.rgbycch.service.TeamService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Service
public class TeamServiceImpl implements TeamService {

    @Autowired
    private GenericDao<Team, Integer> teamRepository;

    /*
     * (non-Javadoc)
     * 
     * @see com.gffny.rgbycch.service.EntityManagmentService#findById(java.io.
     * Serializable)
     */
    @Override
    public Team findById(Integer id) {
	Team team = teamRepository.findById(id);
	return team;
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.gffny.rgbycch.service.EntityManagmentService#insert(com.gffny.rgbycch
     * .model.BaseEntity)
     */
    @Override
    public Team insert(Team t) {
	return teamRepository.persist(t);
    }

}
