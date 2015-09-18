
/home/vagrant/bin/xdebug_off

# If we delete htdocs, let's just start over.
if [ ! -d htdocs ]
then

	mkdir htdocs
	cd htdocs

	# **
	# Database
	# **

	# Create the database over again.
	mysql -u root --password=root -e "DROP DATABASE IF EXISTS wordpress_pods"
	mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS wordpress_pods"
	mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON wordpress_pods.* TO wp@localhost IDENTIFIED BY 'wp';"

	# **
	# WordPress
	# **

	# Download WordPress
	wp core download

	# Install WordPress.
	wp core config --dbname="wordpress_pods" --dbuser=wp --dbpass=wp --dbhost="localhost" --extra-php <<PHP
define( 'WP_DEBUG', true );

// Enable Pods Developer Preview features
define( "PODS_DEVELOPER", true );

// Enable Pods GitHub updates
define( "PODS_GITHUB_UPDATE", true );
define( 'GITHUB_UPDATER_EXTENDED_NAMING', true );

// Enable Pods debugging and strict debugging (mu plugin)
define( "PODS_DEBUG", true );

// Disable Debug logging to the /wp-content/debug.log file
define( "WP_DEBUG_LOG", false );

// Force display of errors and warnings
define( "WP_DEBUG_DISPLAY", true );
@ini_set( "display_errors", 1 );

// Enable Save Queries
define( "SAVEQUERIES", true );

// Use dev versions of core JS and CSS files (only needed if you are modifying these core files)
define( "SCRIPT_DEBUG", true );

// Set Jetpack to Debug
define( "JETPACK_DEV_DEBUG", true );
PHP

	# Install into DB
	wp core install --url=pods.wordpress.dev --title="Pods Dev VVV" --admin_user=admin --admin_password=password --admin_email=changme@changeme.com

	# **
	# Your themes
	# **
	for i in `ls ../*.zip`
	do
		wp theme install $i
	done

	# **
	# # Plugins
	# **

	wp plugin install wordpress-importer --activate
	wp plugin install developer
	wp plugin install what-the-file --activate
	wp plugin install wordpress-database-reset --activate
	wp plugin install query-monitor  --activate
	wp plugin install debug-bar-console  --activate
	wp plugin install debug-bar-cron  --activate
	wp plugin install debug-bar-extender  --activate
	wp plugin install debug-bar-constants
	wp plugin install debug-bar-post-types  --activate
	wp plugin install debug-bar-shortcodes
	wp plugin install tdd-debug-bar-post-meta --activate
	wp plugin install rewrite-rules-inspector  --activate
	wp plugin install log-deprecated-notices  --activate
	wp plugin install log-viewer  --activate
	wp plugin install monster-widget
	wp plugin install user-switching
	wp plugin install simply-show-ids  --activate
	wp plugin install wordpress-beta-tester
	wp plugin install https://github.com/afragen/github-updater/archive/5.1.1.zip --activate
	wp plugin install pods
	wp plugin install pods -version=2.5.4
	wp plugin install pods -version=2.5.3
	wp plugin install https://github.com/pods-framework/pods/archive/2.x.zip
	wp plugin install https://github.com/pods-framework/pods/archive/release/3.0.zip


	# **
	# Unit Data
	# **

	# Import the unit data.
	curl -O https://wpcom-themes.svn.automattic.com/demo/theme-unit-test-data.xml
	wp import theme-unit-test-data.xml --authors=create
	rm theme-unit-test-data.xml

	# Replace url from unit data
	wp search-replace 'wpthemetestdata.wordpress.com' 'pods.wordpress.dev' --skip-columns=guid

	cd ..

else

	cd htdocs/

	# Updates
	if $(wp core is-installed); then

		# Update WordPress.
		wp core update
		wp core update-db

		# Update Plugins
		wp plugin update --all --skip-plugins[=pods]

		# **
		# Your themes
		# **
		for i in `ls ../*.zip`
		do
			wp theme install $i
		done

	fi

	cd ..

fi

# Enable debugging per default
/home/vagrant/bin/xdebug_on