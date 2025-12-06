clc
clear
close all

% 1. Load The Titanic Data
data = readtable('titanic - titanic.csv');
head(data);
summary(data);

%%
% 2. Missing Data Heatmap in a Plot
MissingData = sum(ismissing(data));

% Creating the heatmap plot
figure('Name', 'Missing Data Heatmap');
h = heatmap(MissingData);

h.XDisplayLabels = data.Properties.VariableNames;
ylabel('Observations (Rows)');
title('Missing Data Pattern by Variable and Observation');
xlabel(''); 

h.Colormap = flipud(gray);
h.ColorbarVisible = 'off'; 

%%

% 3. Remove unnecessary columns with too many missing values
data = removevars(data, {'Ticket', 'Cabin', 'Embarked','Fare','Parch','SibSp'});

% Remove rows where Age is missing
RowsToKeep = ~ismissing(data.Age);
data = data(RowsToKeep, :);
fprintf('Number of rows after removing missing Age values: %d\n', size(data, 1));
summary(data);

%%
% 4. Variation Measures (Range, Variance, StdDev)
numericVars = varfun(@isnumeric, data, 'OutputFormat', 'uniform');
numericData = data{:, numericVars};
vars = data.Properties.VariableNames(numericVars);

numCols = numel(vars);

Ranges = zeros(numCols,1);
Variances = zeros(numCols,1);
StdDevs = zeros(numCols,1);

for i = 1:numCols
    col = numericData(:, i);
    Ranges(i)    = range(col);
    Variances(i) = var(col);
    StdDevs(i)   = std(col);
end

VariationTable = table(vars', Ranges, Variances, StdDevs);
disp(VariationTable);

%%
% 5. Boxplots for Numeric Columns
figure('Name', 'Outlier Boxplot');
boxplot(numericData);
set(gca, 'XTickLabel', vars);
title('Boxplots for Numeric Columns');

%%
% 6. Calculate the mean survival rate by sex and display the results
survivalBySex = groupsummary(data, "Sex", "mean", "Survived");
disp(survivalBySex);

% A graph for the mean survival rate by sex
figure('Name', 'Survival Rate by Sex');
bar(survivalBySex.mean_Survived);
set(gca, 'XTickLabel', survivalBySex.Sex);
ylabel('Survival Rate');
title('Survival Rate by Sex');

%%
% 7. The mean survival rate by class
figure('Name','Survival Rate by Class');

survivalByClass = groupsummary(data, "Pclass", "mean", "Survived");

bar(survivalByClass.mean_Survived * 100);
set(gca, 'XTickLabel', {'1st Class', '2nd Class', '3rd Class'});
ylabel('Survival Rate (%)');
title('Survival Rate by Passenger Class');

%%

% Categorize the age groups
ageBins = [0 12 18 30 45 60 Inf];
ageLabels = {'Child (0-12)','Teen (13-18)','Young (19-30)','Adult (31-45)','Mature (46-60)', 'Senior (60+)'};
data.AgeGroup = categorical(discretize(data.Age, ageBins, 'categorical', ageLabels));

head(data)

% 8. The mean survival rate by age group
meanSurvivalByAgeGroup = groupsummary(data, "AgeGroup", "mean", "Survived");
disp(meanSurvivalByAgeGroup);

% A graph for the mean survival rate by age group
figure('Name', 'Survival Rate by Age Group');
bar(meanSurvivalByAgeGroup.mean_Survived);
set(gca, 'XTickLabel', meanSurvivalByAgeGroup.AgeGroup);
ylabel('Survival Rate');
title('Survival Rate by Age Group');

%%

% 9. Bar Survival Rate by Sex, and PClass
survivalBySexClass = groupsummary(data, ["Sex", "Pclass"], "mean", "Survived");

% Separate the data for each Pclass
pclass1_data = survivalBySexClass(survivalBySexClass.Pclass == 1, :);
pclass2_data = survivalBySexClass(survivalBySexClass.Pclass == 2, :);
pclass3_data = survivalBySexClass(survivalBySexClass.Pclass == 3, :);

% Get the survival rates for each class
y1 = pclass1_data.mean_Survived;
y2 = pclass2_data.mean_Survived;
y3 = pclass3_data.mean_Survived;

% Create the grouped bar chart by plotting each Pclass individually
figure('Name', 'Survival Rate by Sex & Pclass (Individual Bars)');
hold on;
colors = get(groot, 'defaultAxesColorOrder'); 

% Define the X-axis positions for the groups ('female' is 1, 'male' is 2)
groupPositions = 1:numel(pclass1_data.Sex); 
barWidth = 0.25; 

class1 = bar(groupPositions - barWidth, y1, barWidth, 'FaceColor', colors(1,:), 'DisplayName', 'Pclass 1'); 
class2 = bar(groupPositions, y2, barWidth, 'FaceColor', colors(2,:), 'DisplayName', 'Pclass 2');  
class3 = bar(groupPositions + barWidth, y3, barWidth, 'FaceColor', colors(3,:), 'DisplayName', 'Pclass 3'); 

hold off; 

% Set X-axis labels to 'female' and 'male'
set(gca, 'XTick', groupPositions, 'XTickLabel', pclass1_data.Sex); 
ylabel('Mean Survived');
title('Survival Rate by Sex & Pclass');
ylim([0 1.05]); 
legend show;
grid on;

%% 

% 11. Survival Rate by Age Group & Pclass

% Categorize the age groups
ageBins = [0 12 18 30 45 60 Inf];
ageLabels = {'Child (0-12)','Teen (13-18)','Young (19-30)','Adult (31-45)','Mature (46-60)', 'Senior (60+)'};

data.AgeGroup = categorical(discretize(data.Age, ageBins,'categorical', ageLabels));

% Compute mean survival grouped by AgeGroup and Pclass
survivalAgeClass = groupsummary(data, ["AgeGroup","Pclass"], "mean", "Survived");

% Split data for each Pclass
p1 = survivalAgeClass(survivalAgeClass.Pclass == 1, :);
p2 = survivalAgeClass(survivalAgeClass.Pclass == 2, :);
p3 = survivalAgeClass(survivalAgeClass.Pclass == 3, :);

% Registered MATLAB colors
colors = get(groot, 'defaultAxesColorOrder'); 

% Plot grouped bars
figure('Name', 'Survival Rate by Age Group & Pclass');
hold on;

groupPositions = 1:numel(p1.AgeGroup);
barWidth = 0.25;

bar(groupPositions - barWidth, p1.mean_Survived, barWidth,'FaceColor', colors(1,:), 'DisplayName', 'Pclass 1');
bar(groupPositions, p2.mean_Survived, barWidth, 'FaceColor', colors(2,:), 'DisplayName', 'Pclass 2');
bar(groupPositions + barWidth, p3.mean_Survived, barWidth, 'FaceColor', colors(3,:), 'DisplayName', 'Pclass 3');

hold off;

% Axis & labels
set(gca, 'XTick', groupPositions, 'XTickLabel', p1.AgeGroup);
ylabel('Mean Survived');
title('Survival Rate by Age Group & Pclass');
legend show;
grid on;
ylim([0 1.05]);
