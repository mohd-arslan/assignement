#e an official tomcat image as a parent image

FROM tomcat:7.0-alpine

 

#giving the working directory

WORKDIR /assignment .

 

#Clean the base directory of tomcat

RUN rm -rf /usr/local/tomcat/webapps/*

 

#copy war file of project created to the root for tomcat deployement

COPY ./target/*.war  /usr/local/tomcat/webapps/ROOT.war

 

#running the command to start tomcat

CMD ["catalina.sh", "run"]