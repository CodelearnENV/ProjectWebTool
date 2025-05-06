# Sử dụng JDK 17 làm base image
FROM openjdk:17-jdk-slim

# Cài đặt Tomcat 10.1.24
ENV TOMCAT_VERSION 10.1.24
ENV CATALINA_HOME /usr/local/tomcat

# Kiểm tra URL và tải Tomcat
RUN echo "https://downloads.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" && \
    curl -fsSL https://downloads.apache.org/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz | \
    tar -xz -C /usr/local && \
    mv /usr/local/apache-tomcat-${TOMCAT_VERSION} $CATALINA_HOME && \
    rm -rf $CATALINA_HOME/webapps/*

# Copy WAR file vào thư mục ứng dụng của Tomcat
COPY target/*.war $CATALINA_HOME/webapps/ROOT.war

# Mở port 8080 để ứng dụng có thể truy cập
EXPOSE 8080

# Chạy Tomcat khi container bắt đầu
CMD ["catalina.sh", "run"]
