# Base image sử dụng OpenJDK 17
FROM openjdk:17-jdk-slim

# Biến môi trường cho Tomcat
ENV TOMCAT_VERSION=10.1.28
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Cài curl và tạo thư mục tomcat
RUN apt-get update && \
    apt-get install -y curl && \
    mkdir -p $CATALINA_HOME

# Tải Tomcat 10.1.28 từ Maven Repo và giải nén
RUN curl -fsSL https://repo.maven.apache.org/maven2/org/apache/tomcat/tomcat/${TOMCAT_VERSION}/tomcat-${TOMCAT_VERSION}.tar.gz | \
    tar -xz --strip-components=1 -C $CATALINA_HOME

# Xoá các webapps mặc định
RUN rm -rf $CATALINA_HOME/webapps/*

# Copy WAR file vào Tomcat (giả định bạn đã build và có sẵn ở target/*.war)
COPY target/*.war $CATALINA_HOME/webapps/ROOT.war

# Mở cổng HTTP
EXPOSE 8080

# Lệnh khởi động Tomcat
CMD ["catalina.sh", "run"]
