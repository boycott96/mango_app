package com.mango.common.core.constant;

/**
 * @author sunruiguang
 * @date 2022-11-14
 */
public class ExceptionConstants {

    /**
     * 字段验证
     */
    public final static String PARAM_INVALID = "参数异常";
    public final static String PARAM_LENGTH_INVALID = "参数长度超出限制";
    public final static String EMAIL_NO_EXIST = "邮箱不存在";
    public final static String PWD_ERROR = "账号/密码错误";
    public final static String EMAIL_NOT_UNIQUE = "邮箱已被使用,请更换";
    public final static String USERNAME_NOT_UNIQUE = "用户名已被使用,请更换";
    public final static String AUTH_CODE_INVALID = "验证码无效";
    public final static String REGISTER_INFO_INVALID = "注册信息失效,请重新注册";

    /**
     * 数据不存在
     */
    public final static String NOT_FOUND_DATA = "数据不存在";
    public final static String NOT_DATA_EMPTY = "数据不能为空";

    /**
     * 无权限
     */
    public final static String NOT_DATA_AUTH = "无权限";
}
