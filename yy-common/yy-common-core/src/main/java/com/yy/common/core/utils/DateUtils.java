package com.yy.common.core.utils;

import org.apache.commons.lang3.time.DateFormatUtils;

import java.util.Date;
import java.util.Objects;

/**
 * 时间工具类
 *
 * @author sunruiguang
 * @date 2023-05-16
 */
public class DateUtils {

    public static final String VIRGULE_YYYY_MM_DD = "yyyy/MM/dd";

    /**
     * 获取当前时间
     *
     * @return java.util.Date
     * @author sunruiguang
     * @since 2023/5/16
     */
    public static Date nowDate() {
        return new Date();
    }

    /**
     * 获取当前格式的时间字符串
     *
     * @param pattern 格式化字符
     * @return java.lang.String
     * @author sunruiguang
     * @since 2023/5/16
     */
    public static String nowDateTimeStr(final String pattern) {
        return parseDateToStr(pattern, nowDate());
    }

    /**
     * 获取日期转字符串格式
     *
     * @param pattern 日期格式
     * @param date    日期
     * @return java.lang.String
     * @author sunruiguang
     * @since 2023/5/16
     */
    public static String parseDateToStr(final String pattern, final Date date) {
        if (Objects.isNull(date)) {
            return "";
        }
        return DateFormatUtils.format(date, pattern);
    }
}
