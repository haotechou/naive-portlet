<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ page import="com.liferay.alloy.mvc.AlloyController" %><%@
page import="com.liferay.portal.util.PortalUtil" %>

<%@ page import="java.io.InputStream" %>

<%@ page import="java.util.ArrayList" %><%@
page import="java.util.Arrays" %><%@
page import="java.util.Collection" %><%@
page import="java.util.Comparator" %><%@
page import="java.util.Dictionary" %><%@
page import="java.util.Enumeration" %><%@
page import="java.util.Hashtable" %><%@
page import="java.util.LinkedList" %><%@
page import="java.util.List" %><%@
page import="java.util.Queue" %><%@
page import="java.util.Set" %><%@
page import="java.util.SortedSet" %><%@
page import="java.util.TreeSet" %>

<%@ page import="javax.portlet.PortletMode" %><%@
page import="javax.portlet.PortletURL" %><%@
page import="javax.portlet.WindowState" %>

<%@ page import="org.apache.commons.csv.CSVFormat" %><%@
page import="org.apache.commons.csv.CSVParser" %><%@
page import="org.apache.commons.csv.CSVRecord" %><%@
page import="org.apache.commons.io.IOUtils" %>

<%@ include file="/WEB-INF/jsp/util/bayes_classifier.jspf" %>
<%@ include file="/WEB-INF/jsp/util/classification.jspf" %>
<%@ include file="/WEB-INF/jsp/util/classifier.jspf" %>
<%@ include file="/WEB-INF/jsp/util/csv_entry.jspf" %>
<%@ include file="/WEB-INF/jsp/util/i_feature_probability.jspf" %>
<%@ include file="/WEB-INF/jsp/util/portlet_keys.jspf" %>
<%@ include file="/WEB-INF/jsp/util/naive_constants.jspf" %>
<%@ include file="/WEB-INF/jsp/util/naive_parser.jspf" %>