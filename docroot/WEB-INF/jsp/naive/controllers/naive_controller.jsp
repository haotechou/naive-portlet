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

<%@ include file="/WEB-INF/jsp/naive/controllers/init.jspf" %>

<%!
public static class AlloyControllerImpl extends BaseAlloyControllerImpl {

	public AlloyControllerImpl() {
		setPermissioned(true);
	}

	public void index() throws Exception {
		NaiveParser naiveParser = new NaiveParser();

		List<CsvEntry> wonTrainingCsvEntries = naiveParser.getTrainingCsvEntries(true);
		List<CsvEntry> loseTrainingCsvEntries = naiveParser.getTrainingCsvEntries(false);
		List<CsvEntry> testCsvEntries = naiveParser.getTestCsvEntries();

		renderRequest.setAttribute("totalTestEntries", testCsvEntries.size());

		Classifier<String, String> companyNameBayes = new BayesClassifier<String, String>();
		Classifier<String, String> countryBayes = new BayesClassifier<String, String>();
		Classifier<String, String> departmentBayes = new BayesClassifier<String, String>();
		Classifier<String, String> industryBayes = new BayesClassifier<String, String>();
		Classifier<String, String> isClosedBayes = new BayesClassifier<String, String>();
		Classifier<String, String> jobTitleBayes = new BayesClassifier<String, String>();
		Classifier<String, String> leadIdBayes = new BayesClassifier<String, String>();

		List<String> wonCompanyNames = new ArrayList<String>();
		List<String> wonCountries = new ArrayList<String>();
		List<String> wonDepartments = new ArrayList<String>();
		List<String> wonIndustries = new ArrayList<String>();
		List<String> wonIsClosed = new ArrayList<String>();
		List<String> wonJobTitles = new ArrayList<String>();
		List<String> wonLeadIds = new ArrayList<String>();

		for (CsvEntry csvEntry : wonTrainingCsvEntries) {
			wonCompanyNames.add(csvEntry.getCompanyName());
			wonCountries.add(csvEntry.getCountry());
			wonDepartments.add(csvEntry.getDepartment());
			wonIndustries.add(csvEntry.getIndustry());
			wonIsClosed.add(csvEntry.getIsClosed());
			wonJobTitles.add(csvEntry.getJobTitle());
			wonLeadIds.add(csvEntry.getLeadId());
		}

		companyNameBayes.learn("wonCompanyNames", wonCompanyNames);
		countryBayes.learn("wonCountries", wonCountries);
		departmentBayes.learn("wonDepartments", wonDepartments);
		industryBayes.learn("wonIndustries", wonIndustries);
		isClosedBayes.learn("wonIsClosed", wonIsClosed);
		jobTitleBayes.learn("wonJobTitles", wonJobTitles);
		leadIdBayes.learn("wonLeadIds", wonLeadIds);

		List<String> loseCompanyNames = new ArrayList<String>();
		List<String> loseCountries = new ArrayList<String>();
		List<String> loseDepartments = new ArrayList<String>();
		List<String> loseIndustries = new ArrayList<String>();
		List<String> loseIsClosed = new ArrayList<String>();
		List<String> loseJobTitles = new ArrayList<String>();
		List<String> loseLeadIds = new ArrayList<String>();

		for (CsvEntry csvEntry : loseTrainingCsvEntries) {
			loseCompanyNames.add(csvEntry.getCompanyName());
			loseCountries.add(csvEntry.getCountry());
			loseDepartments.add(csvEntry.getDepartment());
			loseIndustries.add(csvEntry.getIndustry());
			loseIsClosed.add(csvEntry.getIsClosed());
			loseJobTitles.add(csvEntry.getJobTitle());
			loseLeadIds.add(csvEntry.getLeadId());
		}

		companyNameBayes.learn("loseCompanyNames", loseCompanyNames);
		countryBayes.learn("loseCountries", loseCountries);
		departmentBayes.learn("loseDepartments", loseDepartments);
		industryBayes.learn("loseIndustries", loseIndustries);
		isClosedBayes.learn("loseIsClosed", loseIsClosed);
		jobTitleBayes.learn("loseJobTitles", loseJobTitles);
		leadIdBayes.learn("loseLeadIds", loseLeadIds);

		int rightCount = 0;

		for (CsvEntry csvEntry : testCsvEntries) {
			String[] companyName = csvEntry.getCompanyName().split("\\s");
			String[] country = csvEntry.getCountry().split("\\s");
			String[] department = csvEntry.getDepartment().split("\\s");
			String[] industry = csvEntry.getIndustry().split("\\s");
			String[] isClosed = csvEntry.getIsClosed().split("\\s");
			String[] jobTitle = csvEntry.getJobTitle().split("\\s");
			String[] leadId = csvEntry.getLeadId().split("\\s");

			float possibility1 = companyNameBayes.classify(Arrays.asList(companyName)).getProbability();
			float possibility2 = countryBayes.classify(Arrays.asList(country)).getProbability();
			float possibility3 = departmentBayes.classify(Arrays.asList(department)).getProbability();
			float possibility4 = industryBayes.classify(Arrays.asList(industry)).getProbability();
			float possibility5 = isClosedBayes.classify(Arrays.asList(isClosed)).getProbability();
			float possibility6 = jobTitleBayes.classify(Arrays.asList(jobTitle)).getProbability();
			float possibility7 = leadIdBayes.classify(Arrays.asList(leadId)).getProbability();
			float possibility = (float)(Math.round((possibility1 + possibility2 + possibility3 + possibility4 + possibility5 + possibility6 + possibility7) * 1) / 10000.0);

			String isWon = "FALSE";

			if (possibility >= 0.5) {
				isWon = "TRUE";
			}

			if (csvEntry.getIsWon().equals(isWon)) {
				rightCount++;
			}
		}

		renderRequest.setAttribute("rightCount", rightCount);
	}

}
%>