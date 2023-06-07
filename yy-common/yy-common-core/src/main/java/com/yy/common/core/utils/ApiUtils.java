package com.yy.common.core.utils;

import com.yy.common.core.domain.R;
import com.yy.common.core.exception.ServiceException;
import org.springframework.util.CollectionUtils;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.function.Supplier;
import java.util.stream.Collectors;

/**
 * @author sunruiguang
 * @date 2023-04-30
 */
public class ApiUtils {

    private static final String ERR_MSG = "API调用失败";

    public static <T> T getData(Supplier<R<T>> supplier) {
        return getData(true, supplier);
    }

    public static <T> T getData(boolean throwE, Supplier<R<T>> supplier) {
        R<T> result = supplier.get();
        if (throwE) {
            ServiceException.isTrue(result.getCode() == R.SUCCESS, ERR_MSG + result.getMessage());
        }
        return result.getData();
    }

    public static <E> List<E> getListData(Supplier<R<List<E>>> supplier) {
        return getListData(true, supplier);
    }

    public static <E> List<E> getListData(boolean throwE, Supplier<R<List<E>>> supplier) {
        R<List<E>> result = supplier.get();
        if (throwE) {
            ServiceException.isTrue(result.getCode() != R.SUCCESS, ERR_MSG + result.getMessage());
        }
        if (CollectionUtils.isEmpty(result.getData())) {
            return Collections.emptyList();
        }
        return result.getData();
    }

    public static <K, E> Map<K, E> getMapData(Supplier<R<List<E>>> supplier, Function<E, K> keyFunction) {
        return getMapData(true, supplier, keyFunction);
    }

    /**
     * 通过stream流转化Map对应值
     *
     * @param throwE      false：不抛异常
     * @param supplier    获取值
     * @param keyFunction map主键
     * @return java.util.Map<K, E>
     * @author sunruiguang
     * @since 2022/7/21
     */
    private static <K, E> Map<K, E> getMapData(boolean throwE, Supplier<R<List<E>>> supplier, Function<E, K> keyFunction) {
        R<List<E>> result = supplier.get();
        if (throwE) {
            ServiceException.isTrue(result.getCode() == R.SUCCESS, ERR_MSG + result.getMessage());
        }
        return listToMap(result.getData(), keyFunction);
    }

    private static <K, E> Map<K, E> listToMap(List<E> list, Function<E, K> keyFunction) {
        if (list == null || list.isEmpty()) {
            return Collections.emptyMap();
        }
        return list.stream().collect(Collectors.toMap(keyFunction, e -> e, (o, n) -> n));
    }

    public static <K, E, V> Map<K, V> getMap(Supplier<R<List<E>>> supplier, Function<E, K> keyFunction, Function<E, V> valueWrapper) {
        R<List<E>> result = supplier.get();
        ServiceException.isTrue(result.getCode() == R.SUCCESS, ERR_MSG + result.getMessage());
        if (result.getData() == null || result.getData().isEmpty()) {
            return Collections.emptyMap();
        }
        return result.getData().stream().collect(Collectors.toMap(keyFunction, valueWrapper));
    }
}
