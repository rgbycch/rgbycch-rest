/**
 * 
 */
package com.gffny.rgbycch.model;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Entity
@Table(name = "t_competition")
public class Competition extends BaseEntity {

    private static final long serialVersionUID = -1349901412076879565L;

    /*
     * (non-Javadoc)
     * 
     * @see com.gffny.rgbycch.model.BaseEntity#name()
     */
    @Override
    public String name() {
	return null;
    }

}
