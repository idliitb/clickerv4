#!/bin/bash


	echo "----------------------------------------------------------------------------------"
	echo "------------------> Installing Clicker Software on your system <------------------"
	echo "----------------------------------------------------------------------------------"

sudo apt-get update

	echo "----------------------------------------------------------------------------------"
	echo "-------------------------------> Checking for MYSQL <-----------------------------"
	echo "----------------------------------------------------------------------------------"


if dpkg -l | grep -E '^ii' | grep mysql

then
	echo "----------------------------------------------------------------------------------"
	echo "----------------------> MySql is already Installed <------------------------------"
	echo "----------------------------------------------------------------------------------"

	passwd=$(zenity --entry --text="Please type the MySQL password")
	
	user=`mysql -s -u root -p$passwd -e "(select count(user) from mysql.user where user = 'clicker_ui')"` 


	if [ $user -gt 0 ];
	then
		
		echo "----------------------------------------------------------------------------------"
		echo "------------------------------>  User already exists <----------------------------"
		echo "----------------------------------------------------------------------------------"
		
		
		mysql -u clicker_ui -pclicker_ui -e "drop database aakashclicker";

		mysql -u clicker_ui -pclicker_ui -e "CREATE database aakashclicker";

		echo "----------------------------------------------------------------------------------"
		echo "-----------------------------> Restoring Database <-------------------------------"
		echo "----------------------------------------------------------------------------------"

		mysql -u clicker_ui -pclicker_ui < clickerv4.sql

		mysql -u clicker_ui -pclicker_ui -e "flush privileges";

table=`mysql -s -u clicker_ui -pclicker_ui -e "(select count(table_schema) from information_schema.tables WHERE table_schema = 'aakashclicker')"`

table1=`mysql -s -u clicker_ui -pclicker_ui -e "(select count(table_schema) from information_schema.tables WHERE table_schema = 'remoteaakashclicker')"`

NOW=$(date +"%m-%d-%Y")
	
	echo "Number of tables in AakashClicker is :" $table

	echo "Number of tables in RemoteAakashClicker is :" $table1

	
		sudo mysqldump -u clicker_ui -pclicker_ui aakashclicker > aakashclicker_dump"$NOW".sql

		sudo mysqldump -u clicker_ui -pclicker_ui remoteaakashclicker > remoteaakashclicker_dump"$NOW".sql

		mysql -u clicker_ui -pclicker_ui -e "drop database aakashclicker";

		mysql -u clicker_ui -pclicker_ui -e "drop database remoteaakashclicker";

		mysql -u clicker_ui -pclicker_ui -e "CREATE database aakashclicker";

		mysql -u clicker_ui -pclicker_ui -e "CREATE database remoteaakashclicker";

		mysql -u clicker_ui -pclicker_ui < clickerv4.sql

		mysql -u clicker_ui -pclicker_ui -e "flush privileges";

	
		echo "Every thing is working fine !!!!"
	
	
	else
	
		echo "----------------------------------------------------------------------------------"
		echo "--------------------------> Creating clicker_ui user <----------------------------"
		echo "----------------------------------------------------------------------------------"

		mysql -u root -p$passwd -e "CREATE USER 'clicker_ui'@'localhost' IDENTIFIED BY 'clicker_ui'";

        	mysql -u root -p$passwd -e "GRANT ALL PRIVILEGES ON *.* TO clicker_ui@'localhost'";

		echo "----------------------------------------------------------------------------------"
		echo "---------> User clicker_ui is created now, with all privileges <------------------"
		echo "----------------------------------------------------------------------------------"

		mysql -u root -p$passwd -e "flush privileges";

		echo "----------------------------------------------------------------------------------"
		echo "------------------------------> Database created <--------------------------------"
		echo "----------------------------------------------------------------------------------"

		mysql -u clicker_ui -pclicker_ui -e "CREATE database aakashclicker";

		mysql -u clicker_ui -pclicker_ui -e "CREATE database remoteaakashclicker";

		echo "----------------------------------------------------------------------------------"
		echo "-----------------------------> Restoring Database <-------------------------------"
		echo "----------------------------------------------------------------------------------"

		mysql -u clicker_ui -pclicker_ui < clickerv4.sql

		mysql -u clicker_ui -pclicker_ui -e "flush privileges";

table=`mysql -s -u clicker_ui -pclicker_ui -e "(select count(table_schema) from information_schema.tables WHERE table_schema = 'aakashclicker')"`

table1=`mysql -s -u clicker_ui -pclicker_ui -e "(select count(table_schema) from information_schema.tables WHERE table_schema = 'remoteaakashclicker')"`
	
	

	
	fi

else
	echo " --------------------------------------------------------------------------------------"
	echo " --------------------------> MySql is not Installed <----------------------------------"
	echo " --------------------------------------------------------------------------------------"

	sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
	sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'	
	sudo apt-get install -y mysql-server mysql-client 


	echo " --------------------------------------------------------------------------------------"
	echo " --------------------------> MySql is now Installed <----------------------------------"
	echo " --------------------------------------------------------------------------------------"
	
	echo "---------------------------------------------------------------------------------------"
	echo "-------------------------------> Creating clicker_ui user <----------------------------"
	echo "---------------------------------------------------------------------------------------"

	mysql -u root -proot -e "CREATE USER 'clicker_ui'@'localhost' IDENTIFIED BY 'clicker_ui'";
	
        mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO clicker_ui@'localhost'";

	echo "---------------------------------------------------------------------------------------"
	echo "--------------> User clicker_ui is created now, with all privileges <------------------"
	echo "---------------------------------------------------------------------------------------"

	mysql -u root -proot -e "flush privileges";

	echo "---------------------------------------------------------------------------------------"
	echo "----------------------------------> Database created <---------------------------------"
	echo "---------------------------------------------------------------------------------------"

	mysql -u clicker_ui -pclicker_ui -e "CREATE database aakashclicker";

	mysql -u clicker_ui -pclicker_ui -e "CREATE database remoteaakashclicker";

	echo "---------------------------------------------------------------------------------------"
	echo "---------------------------------> Restoring Database <--------------------------------"
	echo "---------------------------------------------------------------------------------------"
	
	mysql -u clicker_ui -pclicker_ui < clickerv4.sql

	mysql -u clicker_ui -pclicker_ui -e "flush privileges";

table=`mysql -s -u clicker_ui -pclicker_ui -e "(select count(table_schema) from information_schema.tables WHERE table_schema = 'aakashclicker')"`

table1=`mysql -s -u clicker_ui -pclicker_ui -e "(select count(table_schema) from information_schema.tables WHERE table_schema = 'remoteaakashclicker')"`
	
	echo "Number of tables in AakashClicker is :" $table

	echo "Number of tables in RemoteAakashClicker is :" $table1

	
fi

	
	echo "---------------------------------------------------------------------------------------"
	echo "---------------------------------> Checking for TOMCAT <-------------------------------"
	echo "---------------------------------------------------------------------------------------"

if dpkg -l | grep -E '^ii' | grep tomcat7

then
	echo "---------------------------------------------------------------------------------------"
	echo "----------------------------> Tomcat7 is already Installed <---------------------------"
	echo "---------------------------------------------------------------------------------------"

	sudo apt-get remove -y tomcat7 libtomcat7-java tomcat7-common libservlet3.0-java

	sudo rm -rf /var/lib/tomcat7

	echo "---------------------------------------------------------------------------------------"
	echo "-----------------------------> Tomcat 7 removed successfully <-------------------------"
	echo "---------------------------------------------------------------------------------------"

else
	echo "---------------------------------------------------------------------------------------"
	echo "--------------------------------> Tomcat 7 not present <-------------------------------"
	echo "---------------------------------------------------------------------------------------"
	
fi
	
if dpkg -l | grep -E '^ii' | grep tomcat6

then	echo "---------------------------------------------------------------------------------------"
	echo "---------------------------> Tomcat6 is already Installed <----------------------------"
	echo "---------------------------------------------------------------------------------------"

	sudo rm -rf /var/lib/tomcat6/webapps/clickerv4*

	sudo cp clickerv4.war /var/lib/tomcat6/webapps

	echo "---------------------------------------------------------------------------------------"
	echo "------------------> Clickerv4 war replaced with new war <--------------------"
	echo "---------------------------------------------------------------------------------------"
else
	echo "---------------------------------------------------------------------------------------"
	echo "-------------------------------> Tomcat6 is not Installed <----------------------------"
	echo "---------------------------------------------------------------------------------------"

	sudo apt-get install -y tomcat6 tomcat6-common

	sudo cp clickerv4.war /var/lib/tomcat6/webapps/

	echo "---------------------------------------------------------------------------------------"
	echo "---------------------> Tomcat6 and Clickerv4 war installed <-----------------"
	echo "---------------------------------------------------------------------------------------"
	
fi

	echo "---------------------------------------------------------------------------------------"
	echo "------------------------------------> Checking for JAVA <------------------------------"
	echo "---------------------------------------------------------------------------------------"

if ( dpkg -l | grep -E '^ii' | grep java ) && ( dpkg -l | grep -E '^ii' | grep jdk )

then
	echo "---------------------------------------------------------------------------------------"
	echo "--------------------------------> Java is already Installed <--------------------------"
	echo "---------------------------------------------------------------------------------------"

else
        echo "---------------------------------------------------------------------------------------"
	echo "--------------------> Java is not Installed, Hence Installing JAVA <-------------------"
	echo "---------------------------------------------------------------------------------------"

        sudo apt-get install -y openjdk-6-jre libcommons-dbcp-java libtomcat6-java gcj-4.4-jre

	echo "---------------------------------------------------------------------------------------"
	echo "--------------------------> Java is successfully installed now <-----------------------"
	echo "---------------------------------------------------------------------------------------"

fi



table=`mysql -s -u clicker_ui -pclicker_ui -e "(select count(table_schema) from information_schema.tables WHERE table_schema = 'aakashclicker')"`

table1=`mysql -s -u clicker_ui -pclicker_ui -e "(select count(table_schema) from information_schema.tables WHERE table_schema = 'remoteaakashclicker')"`

echo "Number of tables in AakashClicker is :" $table

echo "Number of tables in RemoteAakashClicker is :" $table1

if ( dpkg -s tomcat6 ) && ( dpkg -S `which mysql` ) && ( java -version ) && [ $table -eq 23 ] && [ $table1 -eq 18 ]

then


	echo "---------------------------------------------------------------------------------------"
	echo "------------------> Clicker Software properly installed on your system <---------------"
	echo "---------------------------------------------------------------------------------------"

else

	echo "---------------------------------------------------------------------------------------"
	echo "--------------> Error while Installing Clicker Software on your system <---------------"
	echo "---------------------------------------------------------------------------------------"

fi


