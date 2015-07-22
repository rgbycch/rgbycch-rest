/**
 * 
 */
package com.gffny.rgbycch.dao.impl;

import org.springframework.stereotype.Repository;

import com.gffny.rgbycch.dao.ClubDao;
import com.gffny.rgbycch.model.Club;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Repository("clubDao")
public class ClubDaoJpaImpl extends GenericDaoJpaImpl<Club, Integer> implements
	ClubDao {

}
