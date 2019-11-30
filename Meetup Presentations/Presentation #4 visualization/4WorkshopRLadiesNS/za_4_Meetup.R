# komentari u RStudio se čine stavljanjem simbola # na početak svakog reda
# definisanje data frame-a (tip podatka koji je najsličniji tabelama) kojem je dodeljen IRIS skup podataka
# na ovaj način se omogućava pristup i manipulacija podacima koji se nalaze u skupu
# df je samo naziv data frame-a i može biti potpuno proizvoljan, npr. skupIris
# pri imenovanju se moraju poštovati pravila da se nazivi varijabli, objekata i drugog ne pišu odvojeno
df<-iris

# prikaz osnovnih statistika o skupu
summary(df)

# R jezik poseduje bogate opcije biblioteka. 
# Biblioteke predstavljaju kolekcije ugrađenih funkcionalnosti.
# Svaka biblioteka je namenjena drugačijim zadacima, a ggplot2 je namenjen kreiranju grafikona.
# Formalniji opis: Biblioteka je zbir unapred kompajliranih i pripremljenih rutina koje program može da koristi. Ove rutine se nazivaju još i modulima i čuvaju se u formatu objekta.
# Da biste pristupili funkcionalnostima poput generisanja i definisanja grafova potrebno je pozvati biblioteku
# Vremenom ćemo uvesti i druge biblioteke. Svaki put se pozivaju pre upotrebe željene funkcionalnosti.


library(ggplot2)

# tri različita tipa vizualizacija na primeru Sepal length atributa
ggplot(df,aes(x=Sepal.Length)) +
  geom_histogram(bins = 10, color="red", fill="blue")+
  facet_grid(~Species)

#varijanta B - v1
ggplot(df,aes(x=Sepal.Length,group=Species,fill=Species))+
  geom_histogram(position="dodge", binwidth=0.25)+
  theme_bw()

#varijanta B - v2
ggplot(df,aes(x=Sepal.Length,group=Species,fill=Species))+
  geom_histogram(position="dodge", bins = 10)+
  theme_bw()

#varijanta C - v1
ggplot(df,aes(x=Sepal.Length,group=Species,fill=Species))+
  geom_histogram(position="identity", alpha=0.5, binwidth=0.25)+
  theme_bw()
#varijanta C - V2
ggplot(df,aes(x=Sepal.Length,group=Species,fill=Species))+
  geom_histogram(position="identity", alpha=0.5, bins=10)+
  theme_bw()

# distribucija vrednosti Sepal width atributa prema klasnom atributu
ggplot(df,aes(x=Sepal.Width,group=Species,fill=Species))+
  geom_histogram(position="identity", alpha=0.5, binwidth=0.25)+
  theme_bw()
#v2
ggplot(df,aes(x=Sepal.Width,group=Species,fill=Species))+
  geom_histogram(position="identity", alpha=0.5, bins = 10)+
  theme_bw()


# distribucija vrednosti Petal length atributa prema klasnom atributu
ggplot(df,aes(x=Petal.Length,group=Species,fill=Species))+
  geom_histogram(position="identity", alpha=0.5, binwidth=0.25)+
  theme_bw()

# distribucija vrednosti Petal width atributa prema klasnom atributu
ggplot(df,aes(x=Petal.Width,group=Species,fill=Species))+
  geom_histogram(position="identity", alpha=0.5, binwidth=0.25)+
  theme_bw()


#scatter plot grafikon
#geom point se koristi da kreira scatter plot grafikon
#scatter plot je najkorisniji za iskazivanje odnosa dve varijable
ggplot(df, aes(Sepal.Length, Sepal.Width, color = Species, shape=Species)) +
  geom_point() 

# geom_jitter je skraceno od geom_point(position=jitter)
# dodaje pomalo random varijacije lokacijama svake tačke 
# korisno je u situacijama kada su vrednosti približne i uvođenje jitter-a 
# dovodi do toga da se vrednosti ne plotuju jedna preko druge, nego ih blago razdvaja
# i dobija se fin graficki prikaz
# posebno korisno kod scatter plot grafikona, box plots i slicnih
ggplot(df, aes(Sepal.Length, Sepal.Width, color = Species, shape=Species)) +
  geom_jitter()

ggplot(df, aes(Petal.Length, Petal.Width, color = Species, shape=Species)) +
  geom_jitter()  

#analiza distinc i unique vrednosti
#učitavamo dplyr biblioteku
library(dplyr)
#analiza strukture skupa podataka
str(df)
distinct(df, Sepal.Length)
unique(df$Sepal.Length)

#prikaz broja distinct vrednosti
length(unique(df$Sepal.Length))
aggregate(Sepal.Length ~ Sepal.Length, df, function(x) length(unique(x)))


#prikaz konkretnih distinct vrednosti
df %>%
  group_by(Sepal.Length) %>%
  summarise(n_distinct(Sepal.Length))

# prikaz distinct vrednosti po att
sapply(df, function(x) length(unique(x)))

# malo naprednijih grafova
library( rgl )
library(magick)
colors <- c("royalblue1", "darkcyan", "oldlace")
iris$color <- colors[ as.numeric( as.factor(iris$Species) ) ]
plot3d( iris[,1], iris[,2], iris[,3], xlab = "Setosa", yxlab = "Versicolor", zlab = "Virginica", col = iris$color, type = "s", radius = .2)
# malo rotacije
play3d( spin3d( axis = c(0, 0, 1), rpm = 5), duration = 10 )

