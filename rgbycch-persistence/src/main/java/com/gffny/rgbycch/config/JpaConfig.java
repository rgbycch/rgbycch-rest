package com.gffny.rgbycch.config;

import java.util.Map;

import javax.sql.DataSource;

import org.hibernate.dialect.Dialect;
import org.opensaml.xml.encryption.EncryptionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.datasource.LazyConnectionDataSourceProxy;
import org.springframework.jdbc.datasource.TransactionAwareDataSourceProxy;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.TransactionManagementConfigurer;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Configuration
@EnableTransactionManagement(proxyTargetClass = true)
@ComponentScan(basePackages = "com.gffny.rgbycch.dao.impl", includeFilters = @Filter({ Repository.class }))
@EnableJpaRepositories(basePackages = "com.gffny.rgbycch.dao.impl")
public class JpaConfig implements TransactionManagementConfigurer {

    /** */
    private static final Logger LOG = LoggerFactory.getLogger(JpaConfig.class);

    @Value("${dataSource.jndiName:}")
    private String jndiName;
    @Value("${dataSource.driverClassName}")
    private String driver;
    @Value("${dataSource.url}")
    private String url;
    @Value("${dataSource.username}")
    private String username;
    @Value("${dataSource.password}")
    private String password;
    @Value("${hibernate.dialect}")
    private String dialect;
    @Value("${hibernate.hbm2ddl.auto}")
    private String hbm2ddlAuto;
    @Value("${hibernate.format_sql:true}")
    private String formatSql;
    @Value("${hibernate.show_sql:true}")
    private String showSql;

    @Bean
    protected DataSource internalDataSource() {

	LOG.info(
		"no connection pool configured so using driver {}, with url {}",
		driver, url);
	DriverManagerDataSource dataSource = new DriverManagerDataSource();
	dataSource.setDriverClassName(driver);
	dataSource.setUrl(url);
	dataSource.setUsername(username);
	dataSource.setPassword(password);

	return dataSource;
    }

    /**
     * use LazyConnectionDataSourceProxy to eliminate unnecessary database
     * connections, improve performance
     * 
     * @return
     */
    @Bean
    protected DataSource lazyConnectionDataSourceProxy() {
	return new LazyConnectionDataSourceProxy(internalDataSource());
    }

    @Bean
    protected DataSource transactionAwareDataSourceProxy() {
	return new TransactionAwareDataSourceProxy(
		lazyConnectionDataSourceProxy());
    }

    @Bean
    public DataSource dataSource() {
	return transactionAwareDataSourceProxy();
    }

    /**
     * 
     * @return
     * @throws DataServiceException
     * @throws EncryptionException
     */
    @Bean(name = "rgbycchEmf")
    public LocalContainerEntityManagerFactoryBean configureEntityManagerFactory() {
	LOG.debug("creating instance of LocalContainerEntityManagerFactoryBean (emf)");
	LocalContainerEntityManagerFactoryBean entityManagerFactoryBean = new LocalContainerEntityManagerFactoryBean();
	entityManagerFactoryBean.setDataSource(dataSource());
	entityManagerFactoryBean.setPackagesToScan("com.gffny.rgbycch.model");

	LOG.debug(
		"creating instance of HibernateJpaVendorAdapter with dialect {}",
		dialect);
	HibernateJpaVendorAdapter hibernateJpaVendorAdapter = new HibernateJpaVendorAdapter();
	hibernateJpaVendorAdapter.setDatabasePlatform(dialect);
	entityManagerFactoryBean.setJpaVendorAdapter(hibernateJpaVendorAdapter);
	entityManagerFactoryBean.setPersistenceUnitName("rgbycchPU");

	Map<String, Object> jpaProperties = entityManagerFactoryBean
		.getJpaPropertyMap();
	jpaProperties.put(org.hibernate.cfg.Environment.DIALECT, dialect);
	jpaProperties.put(org.hibernate.cfg.Environment.HBM2DDL_AUTO,
		hbm2ddlAuto);
	jpaProperties.put(org.hibernate.cfg.Environment.SHOW_SQL, showSql);
	jpaProperties.put(org.hibernate.cfg.Environment.FORMAT_SQL, formatSql);
	jpaProperties.put(
		org.hibernate.cfg.Environment.ENABLE_LAZY_LOAD_NO_TRANS, true);

	// enable ordered and batches inserts and updates to improve performance
	// see
	// http://vladmihalcea.com/2015/03/18/how-to-batch-insert-and-update-statements-with-hibernate/
	jpaProperties.put(org.hibernate.cfg.Environment.ORDER_INSERTS, true);
	jpaProperties.put(org.hibernate.cfg.Environment.ORDER_UPDATES, true);
	jpaProperties.put(org.hibernate.cfg.Environment.STATEMENT_BATCH_SIZE,
		Dialect.DEFAULT_BATCH_SIZE);
	jpaProperties.put(org.hibernate.cfg.Environment.BATCH_VERSIONED_DATA,
		true);

	// 'hibernate.temp.use_jdbc_metadata_defaults' is a temporary magic
	// value. The need for it is intended to be alleviated with future
	// development, thus it is not defined as an Environment constant...
	//
	// it is used to control whether we should consult the JDBC metadata to
	// determine certain Settings default values; it is useful to *not* do
	// this when
	// the database may not be available (mainly in tools usage).
	jpaProperties.put("hibernate.temp.use_jdbc_metadata_defaults", "false");

	LOG.debug("returning instance of entity manager factory bean");
	return entityManagerFactoryBean;
    }

    /**
	 * 
	 */
    @Override
    @Bean
    @Primary
    public PlatformTransactionManager annotationDrivenTransactionManager() {
	JpaTransactionManager tm = new JpaTransactionManager();
	tm.setPersistenceUnitName("rgbycchPU");
	return tm;
    }

}
