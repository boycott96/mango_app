package com.yy.common.redis.configure.cache;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 缓存前缀名称
 *
 * @author yemingxing
 * @date 2022-04-06
 */
public interface CacheDef {

    String REDIS_CACHE_MANAGER = "redisCacheManager";
    String EHCACHE_MANAGER = "ehcacheManager";

    String EHCACHE_NAME_30s = "gd:ehcache:30s";
    String EHCACHE_NAME_300s = "gd:ehcache:300s";
    String EHCACHE_NAME_600s = "gd:ehcache:600s";
    String R_CACHE_NAME_10MIN = "gd:redis:cache:10min";
    String R_CACHE_NAME_30MIN = "gd:redis:cache:30min";
    String R_CACHE_NAME_60MIN = "gd:redis:cache:60min";
    String R_CACHE_NAME_120MIN = "gd:redis:cache:120min";

    @AllArgsConstructor
    @Getter
    enum CacheEnums {
        CACHE_10MIN(R_CACHE_NAME_10MIN, 10 * 60 * 1000),
        CACHE_30MIN(R_CACHE_NAME_30MIN, 30 * 60 * 1000),
        CACHE_60MIN(R_CACHE_NAME_60MIN, 60 * 60 * 1000),
        CACHE_120MIN(R_CACHE_NAME_120MIN, 120 * 60 * 1000),
        ;

        private final String prefix;
        private final long millis;
    }
}
