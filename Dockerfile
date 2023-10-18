FROM tomcat:7.0-alpine

WORKDIR /assignment .

RUN rm -rf /usr/local/tomcat/webapps/*

COPY ./target/*.war  /usr/local/tomcat/webapps/ROOT.war

CMD ["catalina.sh", "run"]
