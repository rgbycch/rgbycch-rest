/**
 * 
 */
package com.gffny.rgbycch.dao;

import static org.junit.Assert.fail;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.transaction.TransactionConfiguration;

import com.gffny.rgbycch.config.ApplicationConfig;
import com.gffny.rgbycch.model.Club;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@TransactionConfiguration(defaultRollback = false)
@ContextConfiguration(classes = { ApplicationConfig.class })
public class GenericDaoJpaImplTest extends
	AbstractTransactionalJUnit4SpringContextTests {

    @Autowired
    private ClubDao clubDao;

    @Autowired
    private TeamDao teamDao;

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#countAll()}.
     */
    @Ignore
    @Test
    public void testCountAll() {
	long count = clubDao.countAll();
	System.out.println(count);
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#getAll()}.
     */
    @Ignore
    @Test
    public void testGetAll() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#findById(java.io.Serializable)}
     * .
     */
    @Ignore
    @Test
    public void testFindById() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#findNewInstanceById(java.io.Serializable)}
     * .
     */
    @Ignore
    @Test
    public void testFindNewInstanceById() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#persist(java.lang.Object)}
     * .
     */
    @Ignore
    @Test
    public void testPersist() {
	Club mitRugby = new Club();
	mitRugby.setName("MIT Rugby");
	Club persisted = clubDao.persist(mitRugby);
	System.out.println(persisted.getId());
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#merge(java.lang.Object)}
     * .
     */
    @Ignore
    @Test
    public void testMerge() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#delete(java.io.Serializable)}
     * .
     */
    @Ignore
    @Test
    public void testDelete() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#findByNamedQuery(java.lang.String, java.util.Map, int, int)}
     * .
     */
    @Ignore
    @Test
    public void testFindByNamedQueryStringMapOfStringQIntInt() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#findByNamedQuery(java.lang.String, java.util.Map, int)}
     * .
     */
    @Ignore
    @Test
    public void testFindByNamedQueryStringMapOfStringQInt() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#findByNamedQuery(java.lang.String, java.util.Map)}
     * .
     */
    @Ignore
    @Test
    public void testFindByNamedQueryStringMapOfStringQ() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#findSingleByNamedQuery(java.lang.String, java.util.Map)}
     * .
     */
    @Ignore
    @Test
    public void testFindSingleByNamedQuery() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#countNamedQuery(java.lang.String, java.util.Map)}
     * .
     */
    @Ignore
    @Test
    public void testCountNamedQuery() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#findStringValueByNamedQuery(java.lang.String, java.util.Map)}
     * .
     */
    @Ignore
    @Test
    public void testFindStringValueByNamedQuery() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#getPrimaryKey(java.lang.Object)}
     * .
     */
    @Ignore
    @Test
    public void testGetPrimaryKey() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#findLongValueByNamedQuery(java.lang.String, java.util.Map)}
     * .
     */
    @Ignore
    @Test
    public void testFindLongValueByNamedQuery() {
	fail("Not yet implemented");
    }

    /**
     * Test method for
     * {@link com.gffny.rgbycch.dao.impl.GenericDaoJpaImpl#findIntValueByNamedQuery(java.lang.String, java.util.Map)}
     * .
     */
    @Ignore
    @Test
    public void testFindIntValueByNamedQuery() {
	fail("Not yet implemented");
    }

}
