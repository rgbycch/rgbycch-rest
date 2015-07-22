package com.gffny.rgbycch.dao.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.GenericTypeResolver;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.gffny.rgbycch.dao.GenericDao;

/**
 * @author John D. Gaffney | gffny.com
 *
 * @param <T>
 * @param <PK>
 */
@SuppressWarnings("unchecked")
@Repository
@Transactional(noRollbackFor = NoResultException.class)
public abstract class GenericDaoJpaImpl<T, PK extends Serializable> implements
	GenericDao<T, PK> {

    private static final Logger LOG = LoggerFactory
	    .getLogger(GenericDaoJpaImpl.class);

    @PersistenceContext(unitName = "rgbycchPU")
    private EntityManager em;

    private final Class<T> entityClass;
    private final Class<PK> pkClass;

    /**
     * Instantiates a new GenericRepository.
     * 
     * @param entityClass
     *            The class of the entity that this repository is for
     * @param pkClass
     *            The primary key of the class of the entity that this
     *            repository is for Despite having the generics <T> and <PK> for
     *            the entity and the PK, we still need to specify the classes
     *            themselves. The reason for this duplicity is because of type
     *            erasure - there's no way to get the actual classes of <T> and
     *            <PK> at run time.
     */
    public GenericDaoJpaImpl() {
	Class<?>[] typeArguments = GenericTypeResolver.resolveTypeArguments(
		getClass(), GenericDaoJpaImpl.class);
	assert (typeArguments.length == 2);
	this.entityClass = (Class<T>) typeArguments[0];
	this.pkClass = (Class<PK>) typeArguments[1];
    }

    /**
     * 
     * @return
     */
    public Class<T> getEntityClass() {
	return entityClass;
    }

    /**
     * public Class<T> getPkClass() { return entityClass; }
     * 
     * /** Gets the entity manager.
     * 
     * @return the entity manager
     */
    @Override
    public EntityManager getEntityManager() {
	return em;
    }

    /**
     * 
     * @return
     * @throws DataServiceException
     */
    @Override
    public long countAll() {
	CriteriaBuilder builder = em.getCriteriaBuilder();
	CriteriaQuery<Long> criteriaQuery = builder.createQuery(Long.class);
	criteriaQuery
		.select(builder.count(criteriaQuery.from(getEntityClass())));
	return em.createQuery(criteriaQuery).getSingleResult();
    }

    /**
     * 
     * @return
     * @throws DataServiceException
     */
    @Override
    public List<T> getAll() {
	CriteriaQuery<T> criteria = em.getCriteriaBuilder().createQuery(
		getEntityClass());
	criteria.select(criteria.from(getEntityClass()));
	return em.createQuery(criteria).getResultList();
    }

    /**
     * 
     */
    @Override
    public T findById(PK id) throws DataAccessException {
	return this.em.find(getEntityClass(), id);
    }

    /**
     * Does the same thing as findById, but always returns a new instance and
     * never uses the persistence context cache
     */
    @Override
    public T findNewInstanceById(PK id) {
	CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
	CriteriaQuery<T> criteriaQuery = criteriaBuilder
		.createQuery(entityClass);
	Root<T> entityClassRoot = criteriaQuery.from(entityClass);
	criteriaQuery.where(criteriaBuilder.equal(
		entityClassRoot.get(entityClassRoot.getModel().getId(pkClass)),
		id));
	criteriaQuery.select(entityClassRoot);
	try {
	    return em.createQuery(criteriaQuery).getSingleResult();
	} catch (NoResultException e) {
	    return null;
	}
    }

    /**
     * 
     */
    @Override
    public T persist(T entity) throws DataAccessException {
	this.em.persist(entity);
	return entity;
    }

    /**
     * 
     */
    @Override
    public T merge(T entity) throws DataAccessException {
	return this.em.merge(entity);
    }

    /**
     * 
     */
    @Override
    public void delete(PK id) {
	// T obj = findByID(type, id);
	try {
	    T obj = em.getReference(entityClass, id);
	    this.em.remove(obj);
	} catch (Exception e) {
	    throw new RuntimeException(entityClass.toString() + " with id "
		    + id + " not found to delete");
	}
    }

    /**
     * 
     * @param personLimit
     * @param startingRecord
     * @return
     */
    @Override
    public List<T> findByNamedQuery(final String name, Map<String, ?> params,
	    int maxResults, int startingRecord) {

	LOG.debug("executing named query {}", name);
	// create the query
	final Query query = em.createNamedQuery(name);

	// set the start postition
	query.setFirstResult(startingRecord);

	// set the result size
	if (maxResults > -1) {
	    query.setMaxResults(maxResults);
	}

	// check for null params
	if (params != null) {
	    for (final Map.Entry<String, ?> param : params.entrySet()) {
		// if (param.getValue() instanceof String
		// && NumberUtils.isNumber((String) param.getValue())
		// && Integer.parseInt((String) param.getValue()) < 0) {
		// query.setParameter(param.getKey(),
		// Integer.parseInt((String) param.getValue()));
		// } else {
		query.setParameter(param.getKey(), param.getValue());
		// }
	    }
	}
	return query.getResultList();
    }

    /**
     * Find by named query.
     * 
     * @param name
     *            the name
     * @param params
     *            the params
     * @param maxResults
     *            the max results
     * @return the list
     */
    @Override
    public List<T> findByNamedQuery(final String name,
	    final Map<String, ?> params, int maxResults) {
	return findByNamedQuery(name, params, maxResults, 0);
    }

    /**
     * 
     */
    @Override
    public List<T> findByNamedQuery(final String name,
	    final Map<String, ?> params) {

	return findByNamedQuery(name, params, -1);
    }

    /**
     * 
     */
    @Override
    public T findSingleByNamedQuery(String name, Map<String, ?> params)
	    throws NoResultException {
	// create the query
	final Query query = em.createNamedQuery(name);
	query.setMaxResults(1);

	// check for null params
	if (params != null) {
	    for (final Map.Entry<String, ?> param : params.entrySet()) {
		// if (param.getValue() instanceof String
		// && NumberUtils.isNumber((String) param.getValue())
		// && Integer.parseInt((String) param.getValue()) < 0) {
		// query.setParameter(param.getKey(),
		// Integer.parseInt((String) param.getValue()));
		// } else {
		query.setParameter(param.getKey(), param.getValue());
		// }
	    }
	}
	return (T) query.getSingleResult();
    }

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
    @Override
    public int countNamedQuery(final String namedQueryName,
	    final Map<String, ?> params) {

	final Query nameQuery = em.createNamedQuery(namedQueryName);

	String namedQueryString = nameQuery.unwrap(org.hibernate.Query.class)
		.getQueryString();

	Pattern p = Pattern.compile("SELECT .* FROM", Pattern.CASE_INSENSITIVE
		| Pattern.UNICODE_CASE);
	Matcher matcher = p.matcher(namedQueryString);
	String countQueryString = matcher.replaceFirst("select count(*) from");

	final Query countQuery = em.createQuery(countQueryString, Long.class);

	if (params != null) {
	    for (final Map.Entry<String, ?> param : params.entrySet()) {
		countQuery.setParameter(param.getKey(), param.getValue());
	    }
	}
	return ((Long) countQuery.getSingleResult()).intValue();
    }

    /**
     * 
     * @param name
     * @param params
     * @return
     */
    @Override
    public List<String> findStringValueByNamedQuery(final String name,
	    final Map<String, String> params) {
	final Query nameQuery = em.createNamedQuery(name);
	if (params != null) {
	    for (final Map.Entry<String, ?> param : params.entrySet()) {
		nameQuery.setParameter(param.getKey(), param.getValue());
	    }
	}
	return nameQuery.getResultList();
    }

    /**
     * 
     * @param entity
     * @return
     */
    public PK getPrimaryKey(T entity) {
	return (PK) em.getEntityManagerFactory().getPersistenceUnitUtil()
		.getIdentifier(entity);
    }

    /**
     * 
     */
    @Override
    public long findLongValueByNamedQuery(String name, Map<String, ?> params) {
	// create the query
	final Query query = em.createNamedQuery(name);
	query.setMaxResults(1);

	// check for null params
	if (params != null) {
	    for (final Map.Entry<String, ?> param : params.entrySet()) {
		// if (param.getValue() instanceof String
		// && NumberUtils.isNumber((String) param.getValue())
		// && Integer.parseInt((String) param.getValue()) < 0) {
		// query.setParameter(param.getKey(),
		// Integer.parseInt((String) param.getValue()));
		// } else {
		query.setParameter(param.getKey(), param.getValue());
		// }
	    }
	}
	Long ret = (Long) query.getSingleResult();
	if (ret == null) {
	    throw new NoResultException();
	}
	return ret;
    }

    /**
     * 
     */
    @Override
    public int findIntValueByNamedQuery(String name, Map<String, ?> params) {
	// create the query
	final Query query = em.createNamedQuery(name);
	query.setMaxResults(1);

	// check for null params
	if (params != null) {
	    for (final Map.Entry<String, ?> param : params.entrySet()) {
		query.setParameter(param.getKey(), param.getValue());
	    }
	}
	Integer ret = (Integer) query.getSingleResult();
	if (ret == null) {
	    throw new NoResultException();
	}
	return ret;
    }

}
