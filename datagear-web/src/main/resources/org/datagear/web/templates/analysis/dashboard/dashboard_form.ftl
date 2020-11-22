<#include "../../include/import_global.ftl">
<#include "../../include/html_doctype.ftl">
<#--
titleMessageKey 标题标签I18N关键字，不允许null
formAction 表单提交action，允许为null
readonly 是否只读操作，允许为null
-->
<#assign formAction=(formAction!'#')>
<#assign readonly=(readonly!false)>
<#assign isAdd=(formAction == 'saveAdd')>
<html>
<head>
<#include "../../include/html_head.ftl">
<title><#include "../../include/html_title_app_name.ftl"><@spring.message code='${titleMessageKey}' /></title>
</head>
<body>
<#include "../../include/page_js_obj.ftl" >
<div id="${pageId}" class="page-form page-form-dashboard">
	<form id="${pageId}-form" action="${contextPath}/analysis/dashboard/${formAction}" method="POST">
		<div class="form-head"></div>
		<div class="form-content">
			<input type="hidden" name="id" value="${(dashboard.id)!''?html}" />
			<textarea id="${pageId}-initTemplateName" style="display:none;">${templateName?html}</textarea>
			<textarea id="${pageId}-initTemplateContent" style="display:none;">${templateContent!''?html}</textarea>
			<div class="form-item form-item-analysisProjectAware">
				<div class="form-item-label">
					<label><@spring.message code='dashboard.name' /></label>
				</div>
				<div class="form-item-value">
					<input type="text" name="name" value="${(dashboard.name)!''?html}" class="ui-widget ui-widget-content" />
				</div>
				<#include "../include/analysisProjectAware_form_select.ftl" >
			</div>
			<div class="form-item form-item-resources">
				<div class="form-item-label">
					<label><@spring.message code='dashboard.dashboardResource' /></label>
				</div>
				<div class="form-item-value error-newline form-item-value-resources">
					<div class="resources-wrapper">
						<div id="${pageId}-resourceEditorTabs" class="resource-editor-tabs minor-tabs">
							<ul class="resource-editor-tab-nav always-show">
							</ul>
							<div class="tabs-more-operation-menu-wrapper ui-widget ui-front ui-widget-content ui-corner-all ui-widget-shadow" style="position: absolute; left:0px; top:0px; display: none;">
								<ul class="tabs-more-operation-menu">
									<li class="tab-operation-close-left"><div><@spring.message code='main.closeLeft' /></div></li>
									<li class="tab-operation-close-right"><div><@spring.message code='main.closeRight' /></div></li>
									<li class="tab-operation-close-other"><div><@spring.message code='main.closeOther' /></div></li>
									<li class="tab-operation-close-all"><div><@spring.message code='main.closeAll' /></div></li>
								</ul>
							</div>
							<div class="tabs-more-tab-menu-wrapper ui-widget ui-front ui-widget-content ui-corner-all ui-widget-shadow" style="position: absolute; left:0px; top:0px; display: none;">
								<ul class="tabs-more-tab-menu">
								</ul>
							</div>
							<#if !readonly>
							<div class="insert-chart-button-wrapper">
								<button type="button" class="insert-chart-button"><@spring.message code='dashboard.insertChart' /></button>
							</div>
							</#if>
							<div class="resize-editor-wrapper resize-left">
								<button type='button' class='resize-editor-button resize-editor-button-left ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='expandOrCollapse' />"><span class='ui-icon ui-icon-arrowstop-1-w'></span><span class='ui-button-icon-space'></span></button>
							</div>
						</div>
						<div class="resource-list-wrapper ui-widget ui-widget-content ui-corner-all">
							<div class="resource-head ui-widget ui-widget-content">
								<div class="resource-title">
									<@spring.message code='dashboard.dashboardResource' />
								</div>
								<#if !readonly>
								<div class="resource-button-wrapper">
									<button type='button' class='edit-resource-button resource-button ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='dashboard.editTemplateContent' />"><span class='ui-icon ui-icon-pencil'></span><span class='ui-button-icon-space'></span></button>
									<button type='button' class='add-resource-button resource-button ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='dashboard.addResource.desc' />"><span class='ui-icon ui-icon-plus'></span><span class='ui-button-icon-space'></span></button>
									<button type='button' class='upload-resource-button resource-button ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='dashboard.uploadResource' />"><span class='ui-icon ui-icon-arrowstop-1-n'></span><span class='ui-button-icon-space'></span></button>
									<button type='button' class='delete-resource-button resource-button ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='delete' />"><span class='ui-icon ui-icon-close'></span><span class='ui-button-icon-space'></span></button>
									<div class="resource-more-button-wrapper">
										<span class="resource-more-icon ui-icon ui-icon-caret-1-s"></span>
										<div class="resource-more-button-panel ui-widget ui-widget-content ui-corner-all ui-front ui-widget-shadow">
											<button type='button' class='copy-resource-button resource-button ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='dashboard.copyResourceNameToClipboard' />"><span class='ui-icon ui-icon-copy'></span><span class='ui-button-icon-space'></span></button>
											<button type='button' class='as-template-button resource-button ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='dashboard.resourceAsTemplate' />"><span class='ui-icon ui-icon-arrow-1-n'></span><span class='ui-button-icon-space'></span></button>
											<button type='button' class='as-resource-button resource-button ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='dashboard.templateAsNormalResource' />"><span class='ui-icon ui-icon-arrow-1-s'></span><span class='ui-button-icon-space'></span></button>
											<button type='button' class='as-template-first-button resource-button ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='dashboard.asFirstTemplate' />"><span class='ui-icon ui-icon-home'></span><span class='ui-button-icon-space'></span></button>
											<button type='button' class='refresh-resource-button resource-button ui-button ui-corner-all ui-widget ui-button-icon-only' title="<@spring.message code='refresh' />"><span class='ui-icon ui-icon-refresh'></span><span class='ui-button-icon-space'></span></button>
										</div>
									</div>
								</div>
								</#if>
							</div>
							<div class="resource-content"></div>
							<div class='upload-resource-panel ui-widget ui-widget-content ui-corner-all ui-front ui-widget-shadow'>
								<div class="upload-resource-panel-head ui-widget-header ui-corner-all"><@spring.message code='dashboard.uploadResource' /></div>
								<div class="upload-resource-panel-content">
									<div class="content-item">
										<div class="label-wrapper">
											<label><@spring.message code='dashboard.uploadResource.select' /></label>
										</div>
										<div class="fileinput-button ui-button ui-corner-all ui-widget">
											<@spring.message code='select' /><input type="file" class="ignore">
										</div>
										<div class="upload-file-info"></div>
									</div>
									<div class="content-item">
										<div class="label-wrapper">
											<label title="<@spring.message code='dashboard.uploadResource.savePath.desc' />" class="tip-label">
												<@spring.message code='dashboard.uploadResource.savePath' />
											</label>
										</div>
										<input type="text" name="" value="" class="upload-res-name-input ui-widget ui-widget-content" />
										<input type="hidden" value="" class="resource-uploadFilePath" />
									</div>
								</div>
								<div class="upload-resource-panel-foot">
									<button type="button" class="save-resource-button"><@spring.message code='confirm' /></button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="form-foot" style="text-align:center;">
			<#if !readonly>
			<input type="submit" value="<@spring.message code='save' />" class="recommended" />
			&nbsp;&nbsp;
			<button type="button" name="saveAndShow"><@spring.message code='dashboard.saveAndShow' /></button>
			</#if>
		</div>
	</form>
</div>
<#include "../../include/page_obj_form.ftl">
<#include "../../include/page_obj_tabs.ftl" >
<script type="text/javascript">
(function(po)
{
	po.templates = <@writeJson var=templates />;
	
	$.initButtons(po.element());
	po.initAnalysisProject("${(dashboard.analysisProject.id)!''?js_string}", "${(dashboard.analysisProject.name)!''?js_string}");
	po.resourceEditorTabs = po.element("#${pageId}-resourceEditorTabs");
	
	if(po.isInDialog())
		po.element(".form-item-value-resources").height($(window).height()*5/9);
	else
	{
		var th = $(window).height() - po.element(".form-item-analysisProjectAware").outerHeight(true);
		th = th - po.element(".form-foot").outerHeight(true);
		th = th - 50;
		po.element(".form-item-value-resources").height(th);
	}
	
	po.url = function(action)
	{
		return "${contextPath}/analysis/dashboard/" + action;
	};
	
	po.resourceEditorTabTemplate = "<li class='resource-editor-tab' style='vertical-align:middle;'><a href='"+'#'+"{href}'>"+'#'+"{label}</a>"
		+"<div class='tab-operation'>"
		+"<span class='ui-icon ui-icon-close' title='<@spring.message code='close' />'>close</span>"
		+"<div class='tabs-more-operation-button' title='<@spring.message code='moreOperation' />'><span class='ui-icon ui-icon-caret-1-e'></span></div>"
		+"</div>"
		+"</li>";
	
	po.newResourceEditorTab = function(name, content, isTemplate)
	{
		name = $.escapeHtml(name);
		var tabsNav = po.getTabsNav(po.resourceEditorTabs);
		var tabId = $.uid("resourceEditorTabPane");
    	var tab = $(po.resourceEditorTabTemplate.replace( /#\{href\}/g, "#" + tabId).replace(/#\{label\}/g, name))
    		.attr("id", $.uid("resourceEditorTab")).appendTo(tabsNav);
    	$("<input type='hidden' class='resourceNameOrigin' />").val(name).appendTo(tab);
    	
    	var panePrevEle = $(".resource-editor-tab-pane", po.resourceEditorTabs).last();
    	if(panePrevEle.length == 0)
    		panePrevEle = $(".resource-editor-tab-nav", po.resourceEditorTabs);
    	var tabPane = $("<div id='"+tabId+"' class='resource-editor-tab-pane' />").insertAfter(panePrevEle);
    	var pc0 = $("<div class='form-item-value form-item-value-resource-name' />").appendTo(tabPane);
    	$("<label class='name-label'></label>").html("<@spring.message code='name' />").appendTo(pc0);
    	$("<input type='hidden' class='resourceIsTemplate' />").val(isTemplate).appendTo(pc0);
    	$("<input type='text' class='resourceName name-input ui-widget ui-widget-content' />")
    		.val(name).appendTo(pc0);
    	$("<textarea class='resourceContent' style='display: none;' />").val(content).appendTo(pc0);
    	
    	var pc1 = $("<div class='editor-wrapper ui-widget ui-widget-content' />").appendTo(tabPane);
		var pc2 = $("<div class='resource-editor' />").attr("id", $.uid("resourceEditor")).appendTo(pc1);
		
		var editor = ace.edit(pc2.attr("id"));
		editor.setShowPrintMargin(false);
		
		if(isTemplate)
		{
			var languageTools = ace.require("ace/ext/language_tools");
			var HtmlMode = ace.require("ace/mode/html").Mode;
			editor.session.setMode(new HtmlMode());
			editor.setOptions(
			{
				enableBasicAutocompletion: po.templateEditorCompleters,
				enableLiveAutocompletion: po.templateEditorCompleters
			});
		}
		
		var cursor = {row: 0, column: 0};
		editor.session.insert(cursor, content);
		
		if(isTemplate)
		{
			var found = editor.find("</body>",{backwards: true, wrap: false, caseSensitive: false, wholeWord: false, regExp: false});
			if(found && found.start && found.start.row > 0)
			{
				cursor = {row: found.start.row-1, column: 0};
				editor.moveCursorToPosition(cursor);
				var selection = editor.session.getSelection();
				selection.clearSelection();
			}
		}
		
		//滚动到底部
		editor.session.setScrollTop(99999);
		editor.focus();
		<#if readonly>
		editor.setReadOnly(true);
		</#if>
		
		tabPane.data("resourceEditorInstance", editor);
    	
   	    $(".tab-operation .ui-icon-close", tab).click(function()
   	    {
   	    	po.closeTab(po.resourceEditorTabs, tabsNav, $(this).parent().parent());
   	    });
   	    
   	    $(".tab-operation .tabs-more-operation-button", tab).click(function()
   	    {
   	    	var tab = $(this).parent().parent();
   	    	var tabId = po.getTabsTabId(po.resourceEditorTabs, tabsNav, tab);
   	    	
   	    	var menu = po.showTabMoreOperationMenu(po.resourceEditorTabs, tabsNav, tab, $(this));
   	    });
		
	    po.resourceEditorTabs.tabs("refresh");
    	po.resourceEditorTabs.tabs( "option", "active",  tab.index());
    	po.refreshTabsNavForHidden(po.resourceEditorTabs, tabsNav);
	};
	
	po.getCurrentResourceEditor = function()
	{
		var tabsNav = po.getTabsNav(po.resourceEditorTabs);
		var activeTabId = po.getTabsTabId(po.resourceEditorTabs, tabsNav, po.getActiveTab(po.resourceEditorTabs, tabsNav));
		var tabPanel = po.getTabsTabPanelByTabId(po.resourceEditorTabs, activeTabId);
		
		return tabPanel.data("resourceEditorInstance");
	};
	
	po.resourceEditorTabs.tabs(
	{
		event: "click",
		activate: function(event, ui)
		{
			var $this = $(this);
			var newTab = $(ui.newTab);
			var newPanel = $(ui.newPanel);
			var tabsNav = po.getTabsNav($this);
			
			po.refreshTabsNavForHidden($this, tabsNav, newTab);
			
			if($(".resourceIsTemplate", newPanel).val() == "true")
				po.element(".insert-chart-button-wrapper").show();
			else
				po.element(".insert-chart-button-wrapper").hide();
		}
	});
	
	po.getTabsTabMoreOperationMenu(po.resourceEditorTabs).menu(
	{
		select: function(event, ui)
		{
			var $this = $(this);
			var item = ui.item;
			
			po.handleTabMoreOperationMenuSelect($this, item, po.resourceEditorTabs);
			po.getTabsTabMoreOperationMenuWrapper(po.resourceEditorTabs).hide();
		}
	});
	
	po.getTabsMoreTabMenu(po.resourceEditorTabs).menu(
	{
		select: function(event, ui)
		{
			po.handleTabsMoreTabMenuSelect($(this), ui.item, po.resourceEditorTabs);
	    	po.getTabsMoreTabMenuWrapper(po.resourceEditorTabs).hide();
		}
	});
	
	po.bindTabsMenuHiddenEvent(po.resourceEditorTabs);
	
	po.getLastTagText = function(text)
	{
		if(!text)
			return text;
		
		var idx = -1;
		for(var i=text.length-1;i>=0;i--)
		{
			var c = text.charAt(i);
			if(c == '>' || c == '<')
			{
				idx = i;
				break;
			}
		}
		
		return (idx < 0 ? text : text.substr(idx));
	};
	
	po.getTemplatePrevTagText = function(editor, row, column)
	{
		var text = editor.session.getLine(row).substring(0, column);
		
		//反向查找直到'>'或'<'
		var prevRow = row;
		while((!text || !(/[<>]/g.test(text))) && (prevRow--) >= 0)
			text = editor.session.getLine(prevRow) + text;
		
		return po.getLastTagText(text);
	};
	
	po.resolveHtmlTagName = function(text)
	{
		var re = text.match(/<\S*/);
		
		if(re)
			return re[0].substr(1);
		
		return "";
	};
	
	po.templateEditorCompletions = [
		{name: "dg-chart-widget", value: "dg-chart-widget", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-widget' />", tagNames: ["div"]},
		{name: "dg-chart-options", value: "dg-chart-options", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-options' />", tagNames: ["body","div"]},
		{name: "dg-chart-theme", value: "dg-chart-theme", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-theme' />", tagNames: ["body", "div"]},
		{name: "dg-chart-map", value: "dg-chart-map", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-map' />", tagNames: ["div"]},
		{name: "dg-chart-link", value: "dg-chart-link", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-link' />", tagNames: ["div"]},
		{name: "dg-chart-auto-resize", value: "dg-chart-auto-resize=\"true\"", caption: "dg-chart-aut..ize",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-auto-resize' />", tagNames: ["body", "div"]},
		{name: "dg-chart-disable-setting", value: "dg-chart-disable-setting=\"true\"", caption: "dg-chart-dis..ing",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-disable-setting' />", tagNames: ["body", "div"]},
		{name: "dg-chart-on-", value: "dg-chart-on-", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-on-' />", tagNames: ["div"]},
		{name: "dg-chart-map-urls", value: "dg-chart-map-urls", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-map-urls' />", tagNames: ["body"]},
		{name: "dg-chart-listener", value: "dg-chart-listener", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-listener' />", tagNames: ["body", "div"]},
		{name: "dg-chart-renderer", value: "dg-chart-renderer", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-chart-renderer' />", tagNames: ["div"]},
		{name: "dg-echarts-theme", value: "dg-echarts-theme", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-echarts-theme' />", tagNames: ["body", "div"]},
		{name: "dg-dashboard-listener", value: "dg-dashboard-listener", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-dashboard-listener' />", tagNames: ["body"]},
		{name: "dg-dashboard-form", value: "dg-dashboard-form", caption: "",
			meta: "<@spring.message code='dashboard.templateEditor.autoComplete.dg-dashboard-form' />", tagNames: ["form"]}
	];
	
	po.templateEditorCompleters =
	[
		{
			identifierRegexps : [/[a-zA-Z_0-9\-]/],
			getCompletions: function(editor, session, pos, prefix, callback)
			{
				var prevText = po.getTemplatePrevTagText(editor, pos.row, pos.column);
				
				var tagName = po.resolveHtmlTagName(prevText);
				
				if(tagName)
				{
					tagName = tagName.toLowerCase();
					
					var completions = [];
					for(var i=0; i<po.templateEditorCompletions.length; i++)
					{
						var comp = po.templateEditorCompletions[i];
						
						if(prefix && comp.name.indexOf(prefix) != 0)
							continue;
						
						if(!comp.tagNames || $.inArray(tagName, comp.tagNames) > -1)
							completions.push(comp);
					}
					
					callback(null, completions);
				}
				else
					callback(null, []);
			}
		}
	];
	
	po.setTemplateNameAndContent = function(templateName, templateContent, focusEditor)
	{
		po.element("input[name='templateName']").val(templateName);
		po.element("textarea[name='templateContent']").val(templateContent);
		
		po.templateEditor.setValue("");
		if(templateContent)
		{
			var cursor = {row: 0, column: 0};
			po.templateEditor.session.insert(cursor, templateContent);
		}
		
		if(focusEditor)
			po.templateEditor.focus();
	};
	
	po.isTemplateContentModified = function()
	{
		var initContent = po.element("textarea[name='templateContent']").val();
	 	var curContent = po.templateEditor.getValue();
	 	
	 	return (initContent != curContent);
	};
	
	po.isTemplateCurrent = function(templateName)
	{
		return (po.element("input[name='templateName']").val() == templateName);
	};
	
	po.getDashboardId = function()
	{
		return  po.element("input[name='id']").val();
	};
	
	po.getSelectedResourceItem = function()
	{
		var $resources = po.element(".resource-content");
		return $("> .resource-item.ui-state-active", $resources);
	};
	
	po.getSelectedResourceName = function($res)
	{
		if(!$res)
			$res = po.getSelectedResourceItem();
		
		return $res.attr("resource-name");
	};
	
	po.enableResButonStatus = function(status)
	{
		var buttons = [
			po.element(".edit-resource-button"),
			po.element(".copy-resource-button"),
			po.element(".delete-resource-button"),
			po.element(".as-template-button"),
			po.element(".as-resource-button"),
			po.element(".as-template-first-button")
		];
		
		if(!status.length)
			status = [status];
		
		for(var i=0; i<buttons.length; i++)
		{
			var s = (status[i] != undefined ? status[i] : status[0]);
			if(s)
				buttons[i].button("enable");
			else
				buttons[i].button("disable");
		}
	};
	
	po.addDashboardResourceItem = function($parent, resourceName)
	{
		var $res = $("<div class='resource-item'></div>").attr("resource-name", resourceName).text(resourceName);
		$parent.append($res);
	};
	
	po.addDashboardResourceItemTemplate = function($parent, templateName, prepend)
	{
		var $res = $("<div class='resource-item resource-item-template'></div>").attr("resource-name", templateName).text(templateName);
		$res.prepend($("<span class='ui-icon ui-icon-contact'></span>").attr("title", "<@spring.message code='dashboard.dashboardTemplateResource' />"));
		$("<input type='hidden' name='templates' />").attr("value", templateName).appendTo($res);
		
		if(prepend == true)
			$parent.prepend($res);
		else
		{
			var last = $(".resource-item-template", $parent).last();
			if(last.length == 0)
				$parent.prepend($res);
			else
				last.after($res);
		}
	};
	
	po.isResourceItemTemplate = function($res)
	{
		return $res.hasClass("resource-item-template");
	};
	
	po.asTemplateItemAllowed = function($res)
	{
		if(po.isResourceItemTemplate($res))
			return false;
		
		var resName = $res.attr("resource-name");
		
		if(!resName)
			return false;
		
		var htmlReg = /\.(html|htm)$/gi;
		
		if(!htmlReg.test(resName))
			return false;
		
		var $parent = $res.parent();
		var $templates = $(".resource-item-template", $parent);
		for(var i=0; i<$templates.length; i++)
		{
			if($($templates[i]).attr("resource-name") == resName)
				return false;
		}
		
		return true;
	};
	
	po.getTemplateIndex = function(templateName, templates)
	{
		templates = (templates || po.templates);
		
		for(var i=0; i<templates.length; i++)
		{
			if(templates[i] == templateName)
				return i;
		}
		
		return -1;
	};
	
	po.refreshDashboardResources = function()
	{
		var id = po.getDashboardId();
		
		if(!id)
			return;
		
		var $resources = po.element(".resource-content");
		$resources.empty();
		
		$.get(po.url("listResources?id="+id), function(resources)
		{
			po.enableResButonStatus(false);
			
			if(!resources)
				return;
			
			var templateCount = 0;
			for(var i=0; i<po.templates.length; i++)
			{
				for(var j=0; j<resources.length; j++)
				{
					if(po.templates[i] == resources[j])
					{
						po.addDashboardResourceItemTemplate($resources, resources[j]);
						templateCount++;
					}
				}
			}
			
			if(templateCount > 0)
				$resources.append($("<div class='resource-item-divider ui-widget ui-widget-content'></div>"));
			
			for(var i=0; i<resources.length; i++)
				po.addDashboardResourceItem($resources, resources[i]);
			
			$resources.selectable("refresh");
		});
	};
	
	po.element(".resource-content").selectable
	(
		{
			classes: {"ui-selected": "ui-state-active"},
			filter: ".resource-item",
			selected: function(event, ui)
			{
				<#if !readonly>
				var $selected = $(ui.selected);
				var selectedCount = $(".ui-selected", this).length;
				
				var status = [false, false, false, false, false, false];
				
				if(selectedCount == 1)
				{
					status[0] = po.isResourceItemTemplate($selected);
					status[1] = true;
					status[2] = true;
					status[3] = po.asTemplateItemAllowed($selected);
					status[4] = status[0];
					status[5] = status[0];
				}
				
				po.enableResButonStatus(status);
				</#if>
			},
			unselected: function(event, ui)
			{
				<#if !readonly>
				po.enableResButonStatus(false);
				</#if>
			}
		}
	)
	.on("mouseenter", ".resource-item", function()
	{
		var $this = $(this);
		$this.addClass("ui-state-default");
	})
	.on("mouseleave", ".resource-item", function()
	{
		var $this = $(this);
		$this.removeClass("ui-state-default");
	});
	
	po.element(".resize-editor-button-left").click(function()
	{
		var $ele = po.element();
		var $icon = $(".ui-icon", this);
		
		if($ele.hasClass("max-resource-editor-left"))
		{
			$ele.removeClass("max-resource-editor-left");
			$icon.removeClass("ui-icon-arrowstop-1-e").addClass("ui-icon-arrowstop-1-w");
		}
		else
		{
			$ele.addClass("max-resource-editor-left");
			$icon.removeClass("ui-icon-arrowstop-1-w").addClass("ui-icon-arrowstop-1-e");
		}
	});

	<#if !readonly>
	po.resourceNameClipboard = new ClipboardJS(po.element(".copy-resource-button")[0],
	{
		text: function(trigger)
		{
			var text = po.getSelectedResourceName();
			if(!text)
				text = "";
			
			return text;
		}
	});
	po.resourceNameClipboard.on('success', function(e)
	{
		$.tipSuccess("<@spring.message code='copyToClipboardSuccess' />");
	});
	
	po.element(".upload-resource-panel").draggable({ handle : ".upload-resource-panel-head" });

	$(document.body).on("click", function(event)
	{
		var $target = $(event.target);

		var $ssp = po.element(".upload-resource-panel");
		if(!$ssp.is(":hidden"))
		{
			if($target.closest(".upload-resource-panel, .upload-resource-button").length == 0)
				$ssp.hide();
		}
	});
	
	po.element(".resource-more-button-wrapper").hover(
	function()
	{
		po.element(".resource-more-button-panel").show();
	},
	function()
	{
		po.element(".resource-more-button-panel").hide();
	});
	
	po.element(".edit-resource-button").click(function()
	{
		var id = po.getDashboardId();
		
		if(!id)
		{
			$.tipInfo("<@spring.message code='dashboard.pleaseSaveDashboardFirst' />");
			return;
		}
		
		var $parent = po.element(".resource-content");
		var $res = $("> .resource-item.ui-state-active", $parent);
		var templateName = $res.attr("resource-name");
		
	 	if(po.isTemplateContentModified())
	 	{
	 		po.confirm("<@spring.message code='dashboard.confirmDiscardCurrentTemplateContent' />",
			{
				"confirm" : function()
				{
					po.loadTemplateContentForEdit(id, templateName);
				}
			});
	 	}
	 	else
	 		po.loadTemplateContentForEdit(id, templateName);
	});
	
	po.loadTemplateContentForEdit = function(id, templateName)
	{
	 	$.get(po.url("getTemplateContent"), {"id": id, "templateName": templateName}, function(data)
	 	{
	 		po.setTemplateNameAndContent(data.templateName, data.templateContent, true);
	 	});
	};

	po.element(".add-resource-button").click(function()
	{
		var id = po.getDashboardId();
		
		if(!id)
		{
			$.tipInfo("<@spring.message code='dashboard.pleaseSaveDashboardFirst' />");
			return;
		}
		
		po.newResourceEditorTab("ttt.css", "ttt", false);
	});
	
	po.asTemplateItem = function($parent, $res)
	{
		if(!po.asTemplateItemAllowed($res))
			return;
		
		var resName = $res.attr("resource-name");
		
		var templates = po.templates.concat([]);
		templates.push(resName);
		
		po.saveTemplateNames(templates);
	};
	
	po.element(".as-template-button").click(function()
	{
		var id = po.getDashboardId();
		
		if(!id)
		{
			$.tipInfo("<@spring.message code='dashboard.pleaseSaveDashboardFirst' />");
			return;
		}
		
		var $parent = po.element(".resource-content");
		var $res = $("> .resource-item.ui-state-active", $parent);
		
		po.asTemplateItem($parent, $res);
	});

	po.asNormalResourceItem = function($parent, $res)
	{
		if(!po.isResourceItemTemplate($res))
			return;
		
		var resName = $res.attr("resource-name");
		
		var templates = po.templates.concat([]);
		var idx = po.getTemplateIndex(resName, templates);
		if(idx > -1)
			templates.splice(idx, 1);
		
		po.saveTemplateNames(templates, function()
		{
			if(po.isTemplateCurrent(resName))
				po.setTemplateNameAndContent("", "");
		});
	};
	
	po.element(".as-resource-button").click(function()
	{
		var id = po.getDashboardId();
		
		if(!id)
		{
			$.tipInfo("<@spring.message code='dashboard.pleaseSaveDashboardFirst' />");
			return;
		}
		
		var $parent = po.element(".resource-content");
		var $res = $("> .resource-item.ui-state-active", $parent);
		var resName = $res.attr("resource-name");
		var isCurrent = po.isTemplateCurrent(resName);
		
		if(isCurrent && po.isTemplateContentModified())
	 	{
	 		po.confirm("<@spring.message code='dashboard.confirmDiscardCurrentTemplateContent' />",
			{
				"confirm" : function()
				{
					po.asNormalResourceItem($parent, $res);
				}
			});
	 	}
	 	else
	 		po.asNormalResourceItem($parent, $res);
	});
	
	po.asResourceTemplateFirst = function($parent, $res)
	{
		if(!po.isResourceItemTemplate($res))
			return;
		
		var resName = $res.attr("resource-name");
		
		var templates = po.templates.concat([]);
		var idx = po.getTemplateIndex(resName, templates);
		if(idx > -1)
			templates.splice(idx, 1);
		templates.unshift(resName);
		
		po.saveTemplateNames(templates);
	};
	
	po.element(".as-template-first-button").click(function()
	{
		var id = po.getDashboardId();
		
		if(!id)
		{
			$.tipInfo("<@spring.message code='dashboard.pleaseSaveDashboardFirst' />");
			return;
		}
		
		var $parent = po.element(".resource-content");
		var $res = $("> .resource-item.ui-state-active", $parent);
		
		po.asResourceTemplateFirst($parent, $res);
	});
	
	po.saveTemplateNames = function(templateNames, success)
	{
		var id = po.getDashboardId();
		if(!id)
			return;
		
		$.ajaxJson(po.url("saveTemplateNames?id="+id),
		{
			data: templateNames,
			success : function(response)
			{
				po.templates = response.data.templates;
				po.refreshDashboardResources();
				
				if(success)
					success();
			}
		});
	};
	
	po.element(".upload-res-name-input").on("keydown", function(e)
	{
		if(e.keyCode == $.ui.keyCode.ENTER)
		{
			po.element(".save-resource-button").click();
			//防止提交表单
			return false;
		}
	});
	
	po.element(".upload-resource-button").click(function()
	{
		var id = po.getDashboardId();
		
		if(!id)
		{
			$.tipInfo("<@spring.message code='dashboard.pleaseSaveDashboardFirst' />");
			return;
		}
		
		po.element(".upload-res-name-input").val("");
		po.element(".resource-uploadFilePath").val("");
		po.element(".upload-file-info").text("");
		
		var $panel = po.element(".upload-resource-panel");
		$panel.show();
		//$panel.position({ my : "right top", at : "right+20 bottom+3", of : this});
	});
	
	po.element(".save-resource-button").click(function()
	{
		var id = po.getDashboardId();
		var resourceFilePath = po.element(".resource-uploadFilePath").val();
		var resourceName = po.element(".upload-res-name-input").val();
		
		if(!id || !resourceFilePath || !resourceName)
			return;
		
		$.post(po.url("saveResourceFile"), {"id": id, "resourceFilePath": resourceFilePath, "resourceName": resourceName},
		function()
		{
			po.refreshDashboardResources();
			po.element(".upload-resource-panel").hide();
		});
	});
	
	po.element(".refresh-resource-button").click(function()
	{
		var id = po.getDashboardId();
		
		if(!id)
		{
			$.tipInfo("<@spring.message code='dashboard.pleaseSaveDashboardFirst' />");
			return;
		}
		
		po.refreshDashboardResources();
	});
	
	po.element(".delete-resource-button").click(function()
	{
		var id = po.getDashboardId();
		
		if(!id)
		{
			$.tipInfo("<@spring.message code='dashboard.pleaseSaveDashboardFirst' />");
			return;
		}
		
		var $res = po.getSelectedResourceItem();
		var name = po.getSelectedResourceName($res);
		
		if(!name)
			return;
		
		po.confirm("<@spring.message code='dashboard.confirmDeleteSelectedResource' />",
		{
			"confirm" : function()
			{
				$.post(po.url("deleteResource"), {"id": id, "name" : name},
				function(response)
				{
					if(po.isTemplateCurrent(name))
						po.setTemplateNameAndContent("", "");
					
					po.refreshDashboardResources();
				});
			}
		});
	});
	
	po.fileUploadInfo = function(){ return this.element(".upload-file-info"); };
	
	po.element(".fileinput-button").fileupload(
	{
		url : po.url("uploadResourceFile"),
		paramName : "file",
		success : function(uploadResult, textStatus, jqXHR)
		{
			var currentRes = po.getSelectedResourceName();
			if(currentRes)
			{
				var lastChar = currentRes.charAt(currentRes.length - 1);
				if(lastChar == "/")
					;
				else
					currentRes = "";
			}
			else
				currentRes = "";
			
			po.element(".upload-res-name-input").val(currentRes + uploadResult.fileName);
			po.element(".resource-uploadFilePath").val(uploadResult.uploadFilePath);
			
			$.fileuploadsuccessHandlerForUploadInfo(po.fileUploadInfo(), false);
		}
	})
	.bind('fileuploadadd', function (e, data)
	{
		$.fileuploadaddHandlerForUploadInfo(e, data, po.fileUploadInfo());
	})
	.bind('fileuploadprogressall', function (e, data)
	{
		$.fileuploadprogressallHandlerForUploadInfo(e, data, po.fileUploadInfo());
	});
	</#if>

	<#if !readonly>
	po.insertChartCode = function(charts)
	{
		if(!charts || !charts.length)
			return;
		
		var editor = po.getCurrentResourceEditor();
		var cursor = editor.getCursorPosition();
		
		//如果body上没有定义dg-dashboard样式，则图表元素也不必添加dg-chart样式，比如导入的看板
		var setDashboardTheme = true;
		
		var code = "";
		
		if(charts.length == 1)
		{
			var chartId = charts[0].id;
			var chartName = charts[0].name;
			
			var text = po.getTemplatePrevTagText(editor, cursor.row, cursor.column);
			
			// =
			if(/=\s*$/g.test(text))
				code = "\"" + chartId + "\"";
			// =" 或 ='
			else if(/=\s*['"]$/g.test(text))
				code = chartId;
			// <...
			else if(/<[^>]*$/g.test(text))
				code = " dg-chart-widget=\""+chartId+"\"";
			else
			{
				setDashboardTheme = po.isCodeHasDefaultThemeClass(editor, cursor);
				code = "<div "+(setDashboardTheme ? "class=\"dg-chart\" " : "")+"dg-chart-widget=\""+chartId+"\"><!--"+chartName+"--></div>\n";
			}
		}
		else
		{
			setDashboardTheme = po.isCodeHasDefaultThemeClass(editor, cursor);
			for(var i=0; i<charts.length; i++)
				code += "<div "+(setDashboardTheme ? "class=\"dg-chart\" " : "")+"dg-chart-widget=\""+charts[i].id+"\"><!--"+charts[i].name+"--></div>\n";
		}
		
		editor.moveCursorToPosition(cursor);
		editor.session.insert(cursor, code);
		editor.focus();
	};
	
	po.element(".insert-chart-button").click(function()
	{
		var options =
		{
			pageParam :
			{
				select : function(charts)
				{
					if(!$.isArray(charts))
						charts = [charts];
					
					po.insertChartCode(charts);
					return true;
				}
			}
		};
		
		$.setGridPageHeightOption(options);
		
		po.open("${contextPath}/analysis/chart/select?multiple", options);
	});
	
	po.isCodeHasDefaultThemeClass = function(editor, cursor)
	{
		var row = cursor.row;
		var text = "";
		while(row >= 0)
		{
			text = editor.session.getLine(row);
			
			if(text && /["'\s]dg-dashboard["'\s]/g.test(text))
				return true;
			
			if(/<body/gi.test(text))
				break;
			
			row--;
		}
		
		return false;
	};
	
	po.showAfterSave = false;
	
	po.element("button[name=saveAndShow]").click(function()
	{
		po.showAfterSave = true;
		po.element("input[type='submit']").click();
	});
	
	$.validator.addMethod("dashboardTemplateContent", function(value, element)
	{
		var html = po.templateEditor.getValue();
		return html.length > 0;
	});
			
	po.form().validate(
	{
		ignore : "",
		rules :
		{
			"name" : "required",
			"templateName" : "required",
			"templateContent" : "dashboardTemplateContent"
		},
		messages :
		{
			"name" : "<@spring.message code='validation.required' />",
			"templateName" : "<@spring.message code='validation.required' />",
			"templateContent" : "<@spring.message code='validation.required' />"
		},
		submitHandler : function(form)
		{
			po.element("textarea[name='templateContent']").val(po.templateEditor.getValue());
			
			$(form).ajaxSubmit(
			{
				success : function(response)
				{
					var isSaveAdd = !po.getDashboardId();
					
					var dashboard = response.data;
					po.element("input[name='id']").val(dashboard.id);
					po.templates = dashboard.templates;
					
					if(po.showAfterSave)
					{
						var showUrl = po.url("show/"+dashboard.id+"/");
						var templateName = dashboard.templateName;
						if(po.getTemplateIndex(templateName) != 0)
							showUrl += templateName;
						
						window.open(showUrl, showUrl);
					}
					
					var close = po.pageParamCallAfterSave(false);
					if(!close)
						po.refreshDashboardResources();
				},
				complete: function()
				{
					po.showAfterSave = false;
				}
			});
		},
		errorPlacement : function(error, element)
		{
			error.appendTo(element.closest(".form-item-value"));
		}
	});
	</#if>
	
	if(po.getDashboardId())
		po.element(".resize-editor-button-left").click();
	
	po.newResourceEditorTab(po.element("#${pageId}-initTemplateName").val(), po.element("#${pageId}-initTemplateContent").val(), true);
	po.refreshDashboardResources();
})
(${pageId});
</script>
</body>
</html>