# Sử dụng Tomcat chính thức làm base image
FROM tomcat:10.1.27-jdk22-temurin

# Cài đặt các biến môi trường nếu cần thiết
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Copy WAR file từ thư mục target vào thư mục webapps của Tomcat
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Mở port 8080 để ứng dụng có thể truy cập
EXPOSE 8080

# Chạy Tomcat khi container bắt đầu
CMD ["catalina.sh", "run"]
