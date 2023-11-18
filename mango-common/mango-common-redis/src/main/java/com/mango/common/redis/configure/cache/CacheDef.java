package com.mango.common.redis.configure.cache;

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
    String R_CACHE_NAME_10MIN = "yy:redis:cache:10min";
    String R_CACHE_NAME_30MIN = "yy:redis:cache:30min";
    String R_CACHE_NAME_60MIN = "yy:redis:cache:60min";
    String R_CACHE_NAME_120MIN = "yy:redis:cache:120min";

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
