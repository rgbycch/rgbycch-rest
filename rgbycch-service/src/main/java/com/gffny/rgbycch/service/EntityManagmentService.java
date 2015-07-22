/**
 * 
 */
package com.gffny.rgbycch.service;

import java.io.Serializable;

import com.gffny.rgbycch.model.BaseEntity;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
public interface EntityManagmentService<T extends BaseEntity, PK extends Serializable> {

    /**
     * 
     * @param id
     * @return
     */
    public abstract T findById(PK id);

    /**
     * 
     * @param t
     * @return
     */
    public abstract T insert(T t);

}
