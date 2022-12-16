package com.yy.common.redis.configure.cache;

import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import java.util.Objects;

/**
 * @author yeyang
 */
@EnableCaching
@Configuration
public class EhCacheConfig {

    @Bean
    public EhCacheManagerFactoryBean ehCacheManagerFactoryBean() {
        EhCacheManagerFactoryBean cacheManagerFactoryBean = new EhCacheManagerFactoryBean();
        cacheManagerFactoryBean.setConfigLocation(new ClassPathResource("ehcache.xml"));
        cacheManagerFactoryBean.setShared(true);
        return cacheManagerFactoryBean;
    }


    @Bean(CacheDef.EHCACHE_MANAGER)
    @ConditionalOnBean(value = EhCacheManagerFactoryBean.class)
    public EhCacheCacheManager eCacheCacheManager(EhCacheManagerFactoryBean bean) {
        return new EhCacheCacheManager(Objects.requireNonNull(bean.getObject()));
    }
}
