package com.gffny.rgbycch.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.stereotype.Controller;

import com.gffny.rgbycch.Application;

/**
 * 
 * @author John D. Gaffney | gffny.com
 *
 */
@Configuration
@ComponentScan(basePackageClasses = Application.class, excludeFilters = @Filter({
	Controller.class, Configuration.class }))
@PropertySources({ @PropertySource(value = "classpath:/application.properties", ignoreResourceNotFound = true) })
@Import({ JpaConfig.class })
public class ApplicationConfig {

    /**
     * 
     * @return
     */
    @Bean
    public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
	return new PropertySourcesPlaceholderConfigurer();
    }

}