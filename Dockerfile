FROM ruby:2.0

RUN apt-get update \
  && apt-get install -y build-essential \
  && apt-get install -y libxml2-dev libxslt1-dev \
  && apt-get install -y libqt4-webkit libqt4-dev xvfb \
  && apt-get install -y nodejs \
  && apt-get install -y libaio1 libaio-dev \
  && apt-get install -y alien

RUN mkdir -p /opt/oracle
COPY vendor/*.rpm /opt/oracle/

# Oracle Client Environment Variables
ENV ORACLE_HOME /usr/lib/oracle/12.1/client64
ENV LD_LIBRARY_PATH $ORACLE_HOME/lib/:$LD_LIBRARY_PATH
ENV NLS_LANG American_America.UTF8
ENV PATH $ORACLE_HOME/bin:$PATH

# Install Oracle Client
RUN alien -i /opt/oracle/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm \
  && alien -i /opt/oracle/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm \
  && alien -i /opt/oracle/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
