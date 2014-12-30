function pub_nwt_dev --description 'Publish NWT into all found Tomcat instances.'
	set TOMCAT_INSTANCES_FOLDER "/opt/dev/apache/tomcat/instances"
	set tomcat_versions (ls $TOMCAT_INSTANCES_FOLDER)

	echo 'Publishing NWT...'

	for tomcat_version in $tomcat_versions

		set tomcat_home "$TOMCAT_INSTANCES_FOLDER/$tomcat_version"
		echo
		echo "	tomcat_home=\"$tomcat_home\""
		echo

		#
		# Deploy Application WAR Files
		#

		echo 'Deploying application WAR files...'
		lspf "{}" -name '*.war'|parallel cp -v "{}" "$tomcat_home/webapps/."
		echo 'Deploying application WAR files Complete.'

		#
		# Configure JMX Remote
		#

		echo
		echo 'Configuring JMX Remote...'
		cp -v "NWT_Core_Processes/NWT_Core_GridController/src/main/resourcesDir/jmxremote.access.dev"	"$tomcat_home/conf/jmxremote.access"
		cp -v "NWT_Core_Processes/NWT_Core_GridController/src/main/resourcesDir/jmxremote.password.dev"	"$tomcat_home/conf/jmxremote.password"
		chmod og-rwx "$tomcat_home/conf/jmxremote.password"
		echo 'Configuring JMX Remote Complete.'

		#
		# Enable Cross Context
		#

		echo
		echo 'Enabling Cross Context...'
		replace '<Context>' '<Context crossContext="true">' -- "$tomcat_home/conf/context.xml"
		echo 'Enabling Cross Context Complete.'

	end

	echo
	echo 'Publishing NWT Complete.'
end
