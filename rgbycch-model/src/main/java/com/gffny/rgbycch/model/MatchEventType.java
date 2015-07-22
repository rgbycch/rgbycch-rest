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
@Table(name = "t_match_event_type")
public class MatchEventType extends BaseEntity {

    private static final long serialVersionUID = 2937698166885582782L;

    @Override
    public String name() {
	return null;
    }

}
