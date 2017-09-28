library(ggplot2)

########################### Histogram ###########################
hist(titanic$age)

ggplot(titanic,aes(age))+
  geom_histogram()

ggplot(titanic,aes(age))+
  geom_histogram(binwidth = 5)

ggplot(titanic,aes(age))+
  geom_histogram(binwidth = 5, color="navyblue", fill="royalblue3", alpha=0.5)+
  labs(title="Titanic Data", y="Absolute Frequency", x="Passenger Age")+
  theme(plot.title = element_text(hjust = 0.5, size=20))

ggplot(titanic,aes(age))+
  geom_histogram(aes(y=..density..), binwidth = 5, color="navyblue", fill="royalblue3", alpha=0.5)+
  labs(title="Titanic Data", y="Density", x="Passenger Age")+
  theme(plot.title = element_text(hjust = 0.5, size=20))

########################### Density Plot ###########################

ggplot(titanic,aes(age,colour=sex, fill=sex))+
  geom_density(alpha=0.8)+
  labs(title="Titanic Data", y="Density", x="Passenger Age")+
  theme(plot.title = element_text(hjust = 0.5, size=20))
                 

########################### Bar Plot ###########################

counts <- table(titanic$pclass)
barplot(counts)


ggplot(titanic,aes(pclass))+
  geom_bar()

titanic$survived=as.factor(titanic$survived)
ggplot(titanic,aes(pclass))+
  geom_bar(aes(fill = survived))

ggplot(titanic,aes(pclass))+
  geom_bar(aes(fill = survived))+
  scale_fill_discrete(breaks=c("0","1"), labels=c("No","Yes"))

ggplot(titanic,aes(pclass))+
  geom_bar(aes(fill = survived))+
  scale_fill_discrete(breaks=c("0","1"), labels=c("No","Yes"))+
  coord_flip() +
  labs(title="Titanic Data", y="Absolute Frequency", x="Class Type",fill="Survived Flag")+
  theme(plot.title = element_text(hjust = 0.5, size=20))

ggplot(titanic,aes(pclass))+
  geom_bar(aes(fill = survived))+
  scale_fill_discrete(breaks=c("0","1"), labels=c("No","Yes"))+
  coord_flip() +
  labs(title="Titanic Data", y="Absolute Frequency", x="Class Type",fill="Survived Flag")+
  theme(plot.title = element_text(hjust = 0.5, size=20),legend.position = "bottom")


########################### Scatter Plot ###########################
plot(titanic$age, titanic$fare)

ggplot(titanic,aes(age,fare, sex))+
  geom_point()

ggplot(titanic,aes(age,fare, sex))+
  geom_point(aes(color=sex))

ggplot(titanic,aes(age,fare, sex,pclass))+
  geom_point(aes(color=sex, shape=pclass))

ggplot(titanic,aes(age,fare, sex,pclass))+
  geom_point(aes(color=sex, shape=pclass))+
  labs(title="Titanic Data", y="Fare ($)", x="Passenger Age")

ggplot(titanic,aes(age,fare, sex,pclass))+
  geom_point(aes(color=sex, shape=pclass))+
  labs(title="Titanic Data", y="Fare ($)", x="Passenger Age",shape="Class", color="Gender")

ggplot(titanic,aes(age,fare, sex,pclass))+
  geom_point(aes(color=sex, shape=pclass))+
  labs(title="Titanic Data", y="Fare ($)", x="Passenger Age",shape="Class", color="Gender")+
  theme(plot.title = element_text(hjust = 0.5, size=20))

ggplot(titanic,aes(age,fare, sex,pclass))+
  geom_point(aes(color=sex, shape=pclass))+
  labs(title="Titanic Data", y="Fare ($)", x="Passenger Age",shape="Class", color="Gender")+
  theme(plot.title = element_text(hjust = 0.5, size=20))+
  ylim(0,300)+xlim(0,60)

########################### BoxPlot ###########################

boxplot(age~sex+pclass,data=titanic)

ggplot(titanic,aes(y=age, x=sex,fill=pclass))+
  geom_boxplot()

ggplot(titanic,aes(y=age, x=sex,fill=pclass))+
  geom_boxplot()+
  labs(title="Titanic Data", y="Passenger Age",fill="Class")+
  theme(plot.title = element_text(hjust = 0.5, size=20))

ggplot(titanic,aes(y=age, x=sex,fill=pclass))+
  geom_boxplot()+
  labs(title="Titanic Data", y="Passenger Age",fill="Class")+
  theme(plot.title = element_text(hjust = 0.5, size=20))+
  scale_y_continuous(breaks = seq(0, 80, 10)) 

titanic$survived <- factor(titanic$survived, labels = c("No", "Yes"))
ggplot(titanic,aes(y=age, x=sex,fill=pclass))+
  geom_boxplot()+
  labs(title="Titanic Data", y="Passenger Age",fill="Class")+
  theme(plot.title = element_text(hjust = 0.5, size=20))+
  scale_y_continuous(breaks = seq(0, 80, 10)) +
  facet_grid(. ~ survived, labeller= label_value)

########################### HeatMap ###########################


titanic_agg1=sqldf('select pclass,sex,count(1) tot,sum(case when survived="Yes" then 1 else 0 end) tot_sur  
      from titanic group by 1,2')
titanic_agg1$survival_ratio=titanic_agg1$tot_sur/titanic_agg1$tot

ggplot(titanic_agg1,aes(as.numeric(pclass),as.numeric(sex) ))+
  geom_tile(aes(fill=survival_ratio))

ggplot(titanic_agg1,aes(as.numeric(pclass),as.numeric(sex) ))+
  geom_tile(aes(fill=survival_ratio))+
  scale_y_continuous(breaks = c(1,2), labels=c("Female","Male"))+
  scale_x_continuous(breaks = c(1,2,3), labels=c("1st Class","2nd Class","3rd Class"))+
  labs(title="Titanic Data", y="Passenger Gender",x="", fill="Survival Ratio")+
  theme(plot.title = element_text(hjust = 0.5, size=20))


