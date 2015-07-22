package com.gffny.rgbycch.config;

import javax.servlet.Filter;
import javax.servlet.ServletRegistration;

import org.springframework.core.annotation.Order;
import org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.ShallowEtagHeaderFilter;
import org.springframework.web.servlet.resource.ResourceUrlEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

@Order(2)
public class WebAppInitializer extends
	AbstractAnnotationConfigDispatcherServletInitializer implements
	WebApplicationInitializer {

    /**
     * (non-Javadoc)
     * 
     * @see org.springframework.web.servlet.support.AbstractDispatcherServletInitializer#getServletMappings()
     */
    @Override
    protected String[] getServletMappings() {
	return new String[] { "/" };
    }

    /**
     * (non-Javadoc)
     * 
     * @see org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer#getRootConfigClasses()
     */
    @Override
    protected Class<?>[] getRootConfigClasses() {
	return new Class<?>[] { ApplicationConfig.class, WebMvcConfig.class };
    }

    /**
     * (non-Javadoc)
     * 
     * @see org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer#getServletConfigClasses()
     */
    @Override
    protected Class<?>[] getServletConfigClasses() {
	return null;
    }

    /**
     * (non-Javadoc)
     * 
     * @see org.springframework.web.servlet.support.AbstractDispatcherServletInitializer#getServletFilters()
     */
    @Override
    protected Filter[] getServletFilters() {
	CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
	characterEncodingFilter.setEncoding("UTF-8");
	characterEncodingFilter.setForceEncoding(true);
	return new Filter[] { characterEncodingFilter,
		new ResourceUrlEncodingFilter(), new ShallowEtagHeaderFilter(),
		new OpenEntityManagerInViewFilter() };
    }

    /**
     * (non-Javadoc)
     * 
     * @see org.springframework.web.servlet.support.AbstractDispatcherServletInitializer#customizeRegistration(javax.servlet.ServletRegistration.Dynamic)
     */
    @Override
    protected void customizeRegistration(
	    ServletRegistration.Dynamic registration) {
	registration.setInitParameter("defaultHtmlEscape", "true");
	registration.setInitParameter("spring.profiles.active", "default");
    }
}