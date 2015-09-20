# PhpStorm

There are different ways to set it up
Basics:

Create New Project:
I choose to point PhpStorm to the plugin directory itself:

![New Project](/screenshots/new_project.jpeg)

Now Take a look at the Event Log (normally at lower right corner):
- WordPress Support: Looks like it's WordPress plugin. Enable WordPress support? Or do not ask again? -> Yes
- WordPress Support: WordPress code style can be set for this project. Set it?  -> Yes
- WordPress Support: For WordPress containing plugins inside it's better to add whole WordPress to project. Fix? Or ignore? -> Klick on fix ( settings -> project -> directories ) this way PhpStorm uses the full WordPress but the .idea Folder is in the pods directory - this can be usefull if you want e.g a separate Project for your theme but use the same vvv-site

if you did Clone pods-dev-vvv:
- Unregistered VCS root detected
         The directory /Users/quasel/vagrant-vvv/www/pods-dev-vvv is under Git, but is not registered in the Settings.
         Add root  Configure  Ignore

You can ignore it because we only care about Git in our Plugin Folder ( e.g. pods )

#### Optional - Vagrant
Configure Vagrant: Settings -> Tools -> Vagrant
PphStorm has Vagrant support but it's not needed


### Debugging in PhpStorm

Setup the deployment configuration: Build, Execution, Deployment -> Deployment
![Deployment Config](/screenshots/deployment.jpeg)
Name it
sftp server (127.0.0.1, 2222, vagrant/vagrant)
Web server root URL
path mappings for local and deployment

![Path Mappings](/screenshots/deploy_path.jpeg)

Notice: i did Use the `htdocs Folder! (this way everything else just works out of the box)


Test Debugging:

Set Breakpoint
Start Listening for incoming connections  ( top right corner or Run -> Start Lis... almost at the end )
Open your Browser http://pods.wordpress.dev

The First Time PhpStorm should Pop UP with
![Debug](/screenshots/debug_incoming.jpeg)


Press Accept
Be Happy



### Setup&Run PHPUnit

#### Configure remote PHP: Settings -> Languages & Frameworks -> PHP

- Click the “...” to the right of the “Interpreter” drop down to open the interpreters dialog
- In the “Interpreters” dialog, click the green “+” and select “Remote...”
- Select the “Deployment configuration” radio button
- Select the deployment config you created earlier
- Set the PHP interpreter path to “/usr/bin/php”
- Click “OK” on the Remote PHP Interpreter dialog

![Remote PHP Setup](/screenshots/php.jpeg)

- Name the new remote interpreter, select it, and click “OK” in the interpreters dialog
- Select the newly created interpreter in the PHP configuration dialog
- Set the appropriate, matching PHP language level and click “OK” or “Apply” in the PHP config dialog


#### Configure PHPUnit: Settings-> Languages & Frameworks -> PHP -> PHPUnit

- Click the green “+” to add “by Remote Interpreter”, select the remote PHP interpreter you configured, and click “OK”
- Click “Use custom autoloader”
- Click “...” to the right of “Path to script” and browse to the composer autoloader (“/usr/local/src/composer/vendor/autoload.php”) or copy&paste the path and click “OK”

![PHPUnit Setup](/screenshots/phpunit.jpeg)

Default Configuration can be left empty we add the Configuration later
Click “OK” or “Apply”

#### Create a new Run/Debug Configuration: Run -> Edit Configurations (not in the Settings panel)

Click the green “+”, add a new “PHPUnit” configuration, and name it
Set “Test scope” to “Defined in the configuration file”
Check ‘Use alternative configuration file’ and enter (or browse to) the path to the phpunit configuration file for this set of tests. In this case /srv/www/pods-dev-vvv/wp-content/plugins/pods/phpunit.xml.dist

![PHPUnit Run Setup](/screenshots/phpunit_run_config.jpeg)

Click “...” to create a new environment variable
WP_TESTS_DIR and set it to “/srv/www/wordpress-develop/tests/phpunit/”
WP_DEVELOP_DIR and set it to “/srv/www/wordpress-develop” (no trailing slash)

![PHPUnit Environment](/screenshots/environment.jpeg)

Click “OK”
Click “OK” to apply the changes

#### Run Tests
- Run your Configuration: Run -> ‘your config name….’
- Now you can run tests via Run > ‘your debug configuration name...’ (like “Pods Tests” is above), it’s a context menu or you can get to it through the menu bar.
    A window will come up in the bottom of the screen with your test results and it’s useful to pin it, so you can test and fix things as needed. It provides useful information you’ll need to debug issues.
    It’s important to remember that line numbers may be one off when you click through on test results, double clicking the result for a failed method will take you to the right place, but often a line or so above it is where the cursor will be set.

- Debug
    You do not need to set the “Listen for Debug Connections” toggle when debugging tests.  “Run” (shift-f10) will run the tests and ignore breakpoints.  “Debug” (shift-f9) will stop at any breakpoints and debug as usual without the “listen” toggle set.  Setting the “listen” toggle might cause it to act weird, so just forget about it for debugging with phpUnit integration.
    Fatal errors during tests do not seem to completely terminate without closing the run or debug window via the red ‘X’.  The run/debug session will remain open and will not permit subsequent runs without doing this or restarting phpStorm.