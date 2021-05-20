/*
 * Copyright 2018 datagear.tech
 *
 * Licensed under the LGPLv3 license:
 * http://www.gnu.org/licenses/lgpl-3.0.html
 */

package org.datagear.analysis;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 图表定义。
 * 
 * @author datagear@163.com
 *
 */
public class ChartDefinition extends AbstractIdentifiable
{
	public static final String PROPERTY_ID = "id";
	public static final String PROPERTY_NAME = "name";
	public static final String PROPERTY_CHART_DATASETS = "chartDataSets";
	public static final String PROPERTY_CHART_ATTRIBUTES = "attributes";
	public static final String PROPERTY_UPDATE_INTERVAL = "updateInterval";

	public static final ChartDataSet[] EMPTY_CHART_DATA_SET = new ChartDataSet[0];

	/** 图表名称 */
	private String name;

	/** 图表数据集 */
	private ChartDataSet[] chartDataSets = EMPTY_CHART_DATA_SET;

	/** 图表属性映射表 */
	@SuppressWarnings("unchecked")
	private Map<String, Object> attributes = Collections.EMPTY_MAP;

	/** 图表更新间隔毫秒数 */
	private int updateInterval = -1;

	/**结果数据格式*/
	private ResultDataFormat resultDataFormat = null;
	
	public ChartDefinition()
	{
		super();
	}

	public ChartDefinition(String id, String name, ChartDataSet[] chartDataSets)
	{
		super(id);
		this.name = name;
		this.chartDataSets = chartDataSets;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public ChartDataSet[] getChartDataSets()
	{
		return chartDataSets;
	}

	public void setChartDataSets(ChartDataSet[] chartDataSets)
	{
		this.chartDataSets = chartDataSets;
	}

	/**
	 * 获取图表属性映射表。
	 * 
	 * @return
	 */
	public Map<String, Object> getAttributes()
	{
		return attributes;
	}

	/**
	 * 设置图表属性映射表。
	 * 
	 * @param attributes
	 */
	public void setAttributes(Map<String, Object> attributes)
	{
		this.attributes = attributes;
	}

	/**
	 * 设置属性。
	 * 
	 * @param name
	 * @param value
	 */
	public void setAttribute(String name, Object value)
	{
		if (this.attributes == null || this.attributes == Collections.EMPTY_MAP)
			this.attributes = new HashMap<>();

		this.attributes.put(name, value);
	}

	/**
	 * 获取属性。
	 * 
	 * @param name
	 * @return 返回{@code null}表示没有。
	 */
	public Object getAttribute(String name)
	{
		if (this.attributes == null)
			return null;

		return this.attributes.get(name);
	}

	/**
	 * 获取图表更新间隔毫秒数。
	 * 
	 * @return {@code <0}：不更新；0 ：实时更新；{@code >0}：间隔更新毫秒数
	 */
	public int getUpdateInterval()
	{
		return updateInterval;
	}

	public void setUpdateInterval(int updateInterval)
	{
		this.updateInterval = updateInterval;
	}

	/**
	 * 获取图表数据集结果数据格式。
	 * 
	 * @return 返回{@code null}表示未设置
	 */
	public ResultDataFormat getResultDataFormat()
	{
		return resultDataFormat;
	}

	/**
	 * 设置图表数据集结果数据格式。
	 * 
	 * @param dataFormat
	 */
	public void setResultDataFormat(ResultDataFormat resultDataFormat)
	{
		this.resultDataFormat = resultDataFormat;
	}
	
	/**
	 * 获取指定索引的默认{@linkplain DataSetResult}。
	 * 
	 * @param index
	 * @return 如果{@linkplain ChartDataSet#isResultReady()}为{@code false}，将返回{@code null}。
	 * @throws DataSetException
	 */
	public DataSetResult getDataSetResult(int index) throws DataSetException
	{
		ChartDataSet chartDataSet = this.chartDataSets[index];
		
		if (!chartDataSet.isResultReady())
			return null;
		
		if(this.resultDataFormat == null)
		{
			return chartDataSet.getResult();
		}
		else
		{
			DataSetQuery query = chartDataSet.getQuery();
			if(query == null)
				query = DataSetQuery.valueOf();
			else
				query = query.copy();
			
			query.setResultDataFormat(this.resultDataFormat);
			
			return chartDataSet.getResult(query);
		}
	}

	/**
	 * 获取所有默认{@linkplain DataSetResult}数组。
	 * 
	 * @return 如果{@linkplain #getChartDataSets()}指定索引的{@linkplain ChartDataSet#isResultReady()}为{@code false}，
	 *         返回数组对应元素将为{@code null}。
	 * @throws DataSetException
	 */
	public DataSetResult[] getDataSetResults() throws DataSetException
	{
		if (this.chartDataSets == null || this.chartDataSets.length == 0)
			return new DataSetResult[0];

		DataSetResult[] results = new DataSetResult[this.chartDataSets.length];

		for (int i = 0; i < this.chartDataSets.length; i++)
			results[i] = getDataSetResult(i);

		return results;
	}

	/**
	 * 获取指定索引的{@linkplain DataSetResult}。
	 * 
	 * @param index
	 * @param query
	 *            允许为{@code null}
	 * @return 如果{@code query}为{@code null}，或者{@linkplain ChartDataSet#isResultReady(DataSetQuery)}为{@code false}，将返回{@code null}。
	 * @throws DataSetException
	 */
	public DataSetResult getDataSetResult(int index, DataSetQuery query) throws DataSetException
	{
		if (query == null)
			return null;
		
		if(query.getResultDataFormat() == null && this.resultDataFormat != null)
		{
			query = query.copy();
			query.setResultDataFormat(this.resultDataFormat);
		}
		
		ChartDataSet chartDataSet = this.chartDataSets[index];
		
		if (!chartDataSet.isResultReady(query))
			return null;
		
		return chartDataSet.getResult(query);
	}

	/**
	 * 获取所有{@linkplain DataSetResult}数组。
	 * 
	 * @param queries
	 *            允许为{@code null}
	 * @return 如果{@code queries}指定元素为{@code null}，
	 *         或者{@linkplain #getChartDataSets()}指定索引的{@linkplain ChartDataSet#isResultReady(DataSetQuery)}为{@code false}，返回数组对应元素将为{@code null}。
	 * @throws DataSetException
	 */
	public DataSetResult[] getDataSetResults(List<? extends DataSetQuery> queries) throws DataSetException
	{
		if (this.chartDataSets == null || this.chartDataSets.length == 0)
			return new DataSetResult[0];

		DataSetResult[] results = new DataSetResult[this.chartDataSets.length];

		int pvSize = (queries == null ? 0 : queries.size());

		for (int i = 0; i < this.chartDataSets.length; i++)
		{
			DataSetQuery query = (i >= pvSize ? null : queries.get(i));
			results[i] = getDataSetResult(i, query);
		}

		return results;
	}

	@Override
	public String toString()
	{
		return getClass().getSimpleName() + " [id=" + getId() + ", name=" + name + "]";
	}

	/**
	 * 拷贝属性。
	 * 
	 * @param from
	 * @param to
	 */
	public static void copy(ChartDefinition from, ChartDefinition to)
	{
		to.setId(from.getId());
		to.setName(from.name);
		to.setChartDataSets(from.chartDataSets);
		to.setAttributes(from.attributes);
		to.setUpdateInterval(from.updateInterval);
		to.setResultDataFormat(from.resultDataFormat);
	}
}
