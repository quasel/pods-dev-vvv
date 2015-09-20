# PhpStorm

There are different ways to set it up





# PHPUnit + PhpStorm with VVV Configuration

1) Configure Vagrant: Settings -> Tools -> Vagrant



2) Setup the deployment configuration: Build, Execution, Deployment -> Deployment
sftp server (127.0.0.1, 2222, vagrant/vagrant)
path mappings for local and deployment
Name it


3) Configure remote PHP: Settings -> Languages & Frameworks -> PHP [TODO: ! This needs an update to use the deployment configuration in step 2]


Click the “...” to the right of the “Interpreter” drop down to open the interpreters dialog
In the “Interpreters” dialog, click the green “+” and select “Remote...”
Select the “Deployment configuration” radio button
Select the deployment config you created earlier
Set the PHP interpreter path to “/usr/bin/php”
Click “OK” on the Remote PHP Interpreter dialog

Name the new remote interpreter, select it, and click “OK” in the interpreters dialog
Select the newly created interpreter in the PHP configuration dialog
Set the appropriate, matching PHP language level and click “OK” or “Apply” in the PHP config dialog




4) Configure PHPUnit: Settings-> Languages & Frameworks -> PHP -> PHPUnit



Click the green “+” to add “by Remote Interpreter”, select the remote PHP interpreter you configured, and click “OK”
Click “Use custom autoloader”
Click “...” to the right of “Path to script” and browse to the composer autoloader (“/usr/local/src/composer/vendor/autoload.php”) and click “OK”
[PGL UPDATE: it is probably best to skip this step and set the configuration file in the run/debug configurations since you can only set one entry per remote PHP interpreter and you may have multiple test suites to configure for your environment] Under the “Test Runner” section, tick the “Default configuration file” checkbox and then click “...” to browse to the remote Pods plugin directory for the project and select the “phpunit.xml.dist” file
If you have issues testing the connection to SFTP at this point (not the deployment settings, but the phpunit settings), there’s an issue with PhpStorm that may be happening, you can ignore that and type in the full path of the phpunit.xml.dist file (like /srv/www/mysite/wp-content/plugins/your-plugin/phpunit.xml.dist)
Click “OK” or “Apply”



5) Create a new Run/Debug Configuration: Run -> Edit Configurations (not in the Settings panel)



Click the green “+”, add a new “PHPUnit” configuration, and name it
Set “Test scope” to “Defined in the configuration file”
[PGL: needs screenshot update for this step] Check ‘Use alternative configuration file’ and enter (or browse to) the path to the phpunit configuration file for this set of tests.
Click “...” to create a new environment variable WP_TESTS_DIR	and set it to “/srv/www/wordpress-develop/tests/phpunit/”
Also add WP_DEVELOP_DIR and set it to “/srv/www/wordpress-develop” (no trailing slash)
Click “OK”
Click “OK” to apply the changes

6) Run your Configuration: Run -> ‘your config name….’

Now you can run tests via Run > ‘your debug configuration name...’ (like “Pods Tests” is above), it’s a context menu or you can get to it through the menu bar.

A window will come up in the bottom of the screen with your test results and it’s useful to pin it, so you can test and fix things as needed. It provides useful information you’ll need to debug issues.

It’s important to remember that line numbers may be one off when you click through on test results, double clicking the result for a failed method will take you to the right place, but often a line or so above it is where the cursor will be set.
7) Debug

You do not need to set the “Listen for Debug Connections” toggle when debugging tests.  “Run” (shift-f10) will run the tests and ignore breakpoints.  “Debug” (shift-f9) will stop at any breakpoints and debug as usual without the “listen” toggle set.  Setting the “listen” toggle might cause it to act weird, so just forget about it for debugging with phpUnit integration.

Fatal errors during tests do not seem to completely terminate without closing the run or debug window via the red ‘X’.  The run/debug session will remain open and will not permit subsequent runs without doing this or restarting phpStorm.
