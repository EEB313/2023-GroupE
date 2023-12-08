# 2023-GroupE
# Abstract
Freshwater aquaculture is a growing industry, but has potential negative impacts on the surrounding environment due to increased nutrient input into a system. These nutrients include phosphorus and nitrogen which have been shown to cause eutrophication when added to lakes in  excess. Chlorophyll-a is often a measure of primary productivity which is greatly increased during eutrophication. Based on data collected from IISD-Experimental Lakes Area, this project explores the impact of aquaculture on phosphorus, nitrogen, and chlorophyll-a. These data were explored and ANOVAs, GLMs, and Linear Mixed Models were run for model selection. To determine if there was a difference in variable concentrations before and during the aquaculture treatment, statistical analysis was done on the Linear Mixed Models along with permutation analysis. ARIMAs were run to forecast each variable with data before treatment and during treatment. We observed a statistically significant increase in phosphorus, nitrogen, and chlorophyll-a levels from before the aquaculture treatment to during the aquaculture treatment. However the lakes were not eutrophic as could be expected with an increase in nutrients and primary productivity. Other factors beyond just water chemistry must be taken into account as the impacts of aquaculture on a whole lake ecosystem is being explored.

# Description of Data
The data used in this project was a subset of a larger Lake 375 dataset graciously provided by the researchers at the International Institute for Sustainable Development Experimental Lakes Area. The following describes the variables used:

- `monitoring_location_name` -> identifies the location of the observations
- `year` -> identifies the year of the data observations
- `characteristic_name` -> name of parameter variables
- `method_speciation` -> specifies the measure of characteristic_name
- `result_value` -> value of data point measured
- `result_unit` -> unit of result_value

# Author Contributions
### Elli
- Background research on Lake 375, lake ecology, and freshwater system dynamics. Retrieved dataset from IISD-ELA. Provided relevant photos of the ELA lakes used in the presentation. Wrote introduction and abstract for final report. 
### Jaden
- Performed literature review on Lake 375, lake ecology, and freshwater system dynamics. Interpreted the results in the context of this background and conveyed the findings in the presentation and discussion of the final report.
### Karen
- Created figures and figure legends, and wrote the results section in final report. Conducted background research on lake ecology and freshwater system dynamics, annotating and revising final R code. 
### Kumal
- Researched relevant statistical models to interpret dependent time series data. Wrote all of the R code which was used to generate our graphs and interpret our data. Wrote methods for the final report. 


All group members believe work was shared fairly and are satisfied by the contributions of the other members. 
