os=`lsb_release -a | grep Description`
ubunt=="Ubuntu"
centos="Centos"
ubuntu_result=$(echo $os | grep "${ubuntu}")
centos_result=$(echo $os | grep "${centos}")

if [[ "$ubuntu_result" != "" ]]
then
        apt-get install -y curl wget git
elif [[ "$centos_result" != "" ]]
then
        yum install -y curl wget git
else
        echo "error"
fi

dir=`pwd`
curl -O https://artifacts.elastic.co/downloads/logstash/logstash-7.2.0.tar.gz --output arthas
#wget https://artifacts.elastic.co/downloads/logstash/logstash-7.2.0-linux-x86_64.tar.gz
tar -zxvf ${dir}/logstash-7.2.0.tar.gz

export JAVA_HOME=${dir}/logstash-7.13.0/jdk
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PAT
git clone "https://github.com/azmatjan138/guled_conf.git"
mv guled_conf ${dir}/logstash-7.2.0
echo "Install complete"
echo "Please edit your config file , And run : ./logstash-7.13.0/bin/logstash -f ./logstash-7.2.0/guled_conf/conf/mysql.conf"