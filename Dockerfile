FROM maven as builder
WORKDIR /opt/server
COPY pom.xml /opt/server
COPY src /opt/server/src
RUN maven clean package && ls -ltr target

FROM eclipse-temurin:17-jre-alpine
EXPOSE 8080
WORKDIR /opt/server
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop && \
    mkdir /opt/server && \
    chown -R roboshop:roboshop /opt/server
USER roboshop
COPY --from=builder /opt/server/target/shipping-1.0.jar /opt/server/shipping.jar
CMD ['java', '-jar', "shipping.jar"]

