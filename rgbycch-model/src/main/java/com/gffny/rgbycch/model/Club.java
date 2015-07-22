/**
 * 
 */
package com.gffny.rgbycch.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Entity
@Table(name = "t_club")
public class Club extends BaseEntity {

    /**
     * 
     */
    private static final long serialVersionUID = 5962234299751456450L;
    private String name;

    @Column(name = "nm")
    public String getName() {
	return this.name;
    }

    public void setName(String name) {
	this.name = name;
    }

    @Transient
    @Override
    public String name() {
	return getName();
    }
}
