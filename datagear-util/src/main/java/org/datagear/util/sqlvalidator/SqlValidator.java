/*
 * Copyright 2018 datagear.tech
 *
 * Licensed under the LGPLv3 license:
 * http://www.gnu.org/licenses/lgpl-3.0.html
 */

package org.datagear.util.sqlvalidator;

/**
 * SQL校验器。
 * <p>
 * 校验SQL语句是否合法，比如是否包含不允许出现的关键字。
 * </p>
 * 
 * @author datagear@163.com
 *
 */
public interface SqlValidator
{
	/**
	 * 校验。
	 * 
	 * @param sql
	 * @param profile
	 * @return {@code true} 合法；{@code false} 非法
	 */
	boolean validate(String sql, DatabaseProfile profile);
}
