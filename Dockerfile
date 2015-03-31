from debian 
run apt-get update && \
    apt-get dist-upgrade -y 
run apt-get update && apt-get install -y ruby unicorn && apt-get clean
run apt-get update && apt-get install -y sudo && apt-get clean
run apt-get update && apt-get install -y maven2 openjdk-7-jdk && apt-get clean
run apt-get update && apt-get install -y git && apt-get clean
run apt-get update && apt-get install -y openjdk-7-jre-lib && apt-get clean
add . /opt/classroom/
run apt-get update && \
    apt-get install -y ruby bundler sudo libsqlite3-dev && \
    cd /opt/classroom && bundle install --without development test && \
    apt-get remove --purge -y libsqlite3-dev && \
    apt-get autoremove -y &&\
    apt-get clean
run update-alternatives --set java /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java
expose 8080
workdir /opt/classroom
cmd unicorn
