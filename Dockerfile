FROM cptactionhank/atlassian-jira:7.13.1

# 切换到root用户进行文件操作
USER root

# 注入破解包
COPY ./jira/crack/atlassian-universal-plugin-manager-plugin-2.22.4.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/atlassian-bundled-plugins/atlassian-universal-plugin-manager-plugin-2.22.4.jar
COPY ./jira/crack/atlassian-extras-3.2.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/atlassian-extras-3.2.jar

# 移除原有MySQL驱动，注入兼容的MySQL 5.1驱动
#RUN rm -f /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/mysql-connector-java-*.jar
COPY ./mysql/driver/mysql-connector-java-5.1.49.jar /opt/atlassian/jira/atlassian-jira/WEB-INF/lib/mysql-connector-java-5.1.49.jar


# 切换回jira用户
USER jira

CMD ["/opt/atlassian/jira/bin/catalina.sh", "run"]
