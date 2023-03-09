HIVEMQ_VERSION=$1

HIVEMQ_DOWNLOAD_LINK="https://www.hivemq.com/releases/hivemq-${HIVEMQ_VERSION}.zip"

sudo apt-get update -y
sudo apt-get install -y openjdk-11-jdk
sudo apt-get -y install unzip

# Install HiveMQ 
cd /opt 
sudo wget --content-disposition $HIVEMQ_DOWNLOAD_LINK
sudo unzip "hivemq-${HIVEMQ_VERSION}.zip"
sudo ln -s "/opt/hivemq-${HIVEMQ_VERSION}" /opt/hivemq
sudo useradd -d /opt/hivemq hivemq
sudo chown -R hivemq:hivemq "/opt/hivemq-${HIVEMQ_VERSION}"
sudo chown -R hivemq:hivemq /opt/hivemq
cd /opt/hivemq
