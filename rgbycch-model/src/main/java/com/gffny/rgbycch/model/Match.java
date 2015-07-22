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
@Table(name = "t_match")
public class Match extends BaseEntity {

    private static final long serialVersionUID = 3347742352229388847L;

    /*
     * (non-Javadoc)
     * 
     * @see com.gffny.rgbycch.model.BaseEntity#name()
     */
    @Override
    public String name() {
	// TODO Auto-generated method stub
	return null;
    }

}
