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
cd /opt/hivemq/tools/hivemq-swarm/config

echo "<swarm xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
       xsi:noNamespaceSchemaLocation=\"config.xsd\">
    <commander>
        <agents>
            <agent>
                <host>localhost</host>
                <port>3881</port>
            </agent>
        </agents>
    </commander>

    <agent>
        <bindAddress>localhost</bindAddress>
        <bindPort>3881</bindPort>
    </agent>

    <rest>
        <enabled>true</enabled>
        <listeners>
            <http>
                <enabled>true</enabled>
                <bindAddress>0.0.0.0</bindAddress>
                <bindPort>8081</bindPort>
            </http>
        </listeners>
    </rest>

</swarm>" | sudo tee /opt/hivemq/tools/hivemq-swarm/config/config.xml

cd /opt/hivemq/tools/hivemq-swarm/bin

sudo ./hivemq-swarm &

