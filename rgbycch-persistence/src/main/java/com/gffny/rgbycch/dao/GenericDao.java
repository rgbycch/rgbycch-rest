/**
 * 
 */
package com.gffny.rgbycch.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

/**
 * @author John D. Gaffney | gffny.com
 *
 *
 * @param <T>
 *            The Entity type
 * @param <PK>
 *            The type of the primary key of the Entity
 */
public interface GenericDao<T, PK extends Serializable> {

    /**
     * 
     * @return
     */
    public abstract EntityManager getEntityManager();

    /**
     * 
     * @param entity
     * @return
     */
    public abstract T merge(T entity);

    /**
     * 
     * @param entity
     * @return
     */
    public abstract T persist(T entity);

    /**
     * 
     * @return
     */
    public List<T> getAll();

    /**
     * 
     * @return
     */
    public long countAll();

    /**
     * 
     * @param id
     * @return
     */
    public abstract T findById(PK id);

    /**
     * 
     * @param id
     * @return
     */
    public abstract T findNewInstanceById(PK id);

    /**
     * 
     * @param id
     */
    public abstract void delete(PK id);

    /**
     * 
     * @param name
     * @param params
     * @return
     */
    public abstract List<T> findByNamedQuery(final String name,
	    final Map<String, ?> params);

    /**
     * 
     * @param name
     * @param params
     * @return
     */
    public abstract T findSingleByNamedQuery(final String name,
	    final Map<String, ?> params) throws NoResultException;

    /**
     * Get the number of records a named query would return.
     * 
     * As a performance enhancement, instead of performing the query and
     * counting the result, we retrieve the query string from a named query and
     * use a regular expression to turn it into a "select count(*) from ..."
     * query. We then run the resulting dynamic query to get the record count.
     * 
     * @param namedQueryName
     * @param params
     * @return
     */
    public abstract int countNamedQuery(final String name,
	    final Map<String, ?> params);

    /**
     * 
     * @param name
     * @param params
     * @param maxResults
     * @return
     */
    public abstract List<T> findByNamedQuery(final String name,
	    final Map<String, ?> params, int maxResults);

    /**
     * 
     * @param name
     * @param params
     * @param personLimit
     * @param startingRecord
     * @return
     */
    public abstract List<T> findByNamedQuery(final String name,
	    final Map<String, ?> params, int personLimit, int startingRecord);

    /**
     * 
     * @param name
     * @param params
     * @return
     */
    public abstract List<String> findStringValueByNamedQuery(String name,
	    Map<String, String> params);

    /**
     * 
     * @param name
     * @param params
     * @return
     */
    public abstract long findLongValueByNamedQuery(String name,
	    Map<String, ?> params);

    /**
     * 
     * @param name
     * @param params
     * @return
     */
    public abstract int findIntValueByNamedQuery(String name,
	    Map<String, ?> params);

}
