/**
 * 
 */
package com.gffny.rgbycch.config;

import org.springframework.beans.PropertyEditorRegistrar;
import org.springframework.beans.PropertyEditorRegistry;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.bind.support.ConfigurableWebBindingInitializer;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.gffny.rgbycch.Application;
import com.mangofactory.swagger.plugin.EnableSwagger;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@EnableSwagger
@Configuration
@Import({ ApplicationConfig.class })
@ComponentScan(basePackageClasses = Application.class, includeFilters = @Filter(Controller.class), useDefaultFilters = false)
// @EnableGlobalMethodSecurity(jsr250Enabled = true, securedEnabled = true,
// prePostEnabled = true, proxyTargetClass = true)
public class WebMvcConfig extends WebMvcConfigurationSupport {

    /**
     * 
     */
    @Override
    public RequestMappingHandlerMapping requestMappingHandlerMapping() {
	RequestMappingHandlerMapping requestMappingHandlerMapping = super
		.requestMappingHandlerMapping();
	requestMappingHandlerMapping.setUseRegisteredSuffixPatternMatch(true);
	requestMappingHandlerMapping.setUseTrailingSlashMatch(false);
	return requestMappingHandlerMapping;
    }

    /**
     * 
     */
    @Override
    public Validator getValidator() {
	LocalValidatorFactoryBean validator = new LocalValidatorFactoryBean() {
	    @Override
	    protected void postProcessConfiguration(
		    javax.validation.Configuration<?> configuration) {

		super.postProcessConfiguration(configuration);
	    }
	};
	return validator;
    }

    /**
     * 
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

    }

    /**
     * 
     * @return
     */
    @Bean
    public CommonsMultipartResolver multipartResolver() {
	CommonsMultipartResolver resolver = new CommonsMultipartResolver();
	resolver.setDefaultEncoding("utf-8");
	// TODO make this configurable
	resolver.setMaxUploadSize(10000000); // 10mb
	return resolver;
    }

    @Override
    protected void configureContentNegotiation(
	    ContentNegotiationConfigurer configurer) {
	super.configureContentNegotiation(configurer);
	configurer.defaultContentType(MediaType.TEXT_HTML).favorParameter(true)
		.favorPathExtension(true)
		.mediaType("json", MediaType.APPLICATION_JSON)
		.mediaType("html", MediaType.TEXT_HTML)
		.mediaType("xml", MediaType.TEXT_XML);
    }

    @Override
    protected void configureViewResolvers(ViewResolverRegistry registry) {
	registry.enableContentNegotiation(true, new MappingJackson2JsonView() {
	    // @Override
	    // protected Object filterModel(Map<String, Object> model) {
	    // // do not include Throwable's in the model when rendering using
	    // // Jackson
	    // // Jackson can't render StackTraceElements, when it tries to do
	    // // so, the result is a StackOverflowError
	    // // see https://jira.codehaus.org/browse/JACKSON-888 and
	    // // https://github.com/FasterXML/jackson-databind/issues/429
	    // Map<String, Object> result = new HashMap<String, Object>(model
	    // .size());
	    // for (Map.Entry<String, Object> entry : model.entrySet()) {
	    // if (!(entry.getValue() instanceof Throwable)) {
	    // result.put(entry.getKey(), entry.getValue());
	    // }
	    // }
	    // return super.filterModel(result);
	    // }
	});
	// registry.viewResolver(viewResolver());
    }

    // @Bean
    // protected IdToEntityConverter idToEntityConverter() {
    // return new IdToEntityConverter();
    // }
    //
    // @Bean
    // protected EntityToIdConverter entityToIdConverter() {
    // return new EntityToIdConverter();
    // }
    //
    // @PostConstruct
    // public void addConverters() {
    // mvcConversionService().addConverter(idToEntityConverter());
    // mvcConversionService().addConverter(entityToIdConverter());
    // }

    @Override
    protected ConfigurableWebBindingInitializer getConfigurableWebBindingInitializer() {
	ConfigurableWebBindingInitializer configurableWebBindingInitializer = super
		.getConfigurableWebBindingInitializer();

	// By default, when an empty string is submitted and processed by the
	// data binder (ex, when using a pojo as a parameter to a
	// @RequestMapping method, as commonly done with @ModelAttribute), the
	// string is left as an empty string. However, we would like for empty
	// string to become null.
	configurableWebBindingInitializer
		.setPropertyEditorRegistrar(new PropertyEditorRegistrar() {
		    @Override
		    public void registerCustomEditors(
			    PropertyEditorRegistry registry) {
			registry.registerCustomEditor(String.class,
				new StringTrimmerEditor(true));
		    }
		});

	return configurableWebBindingInitializer;
    }
}
