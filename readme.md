# A WordPress PODS VVV

This is an [auto-sitesetup](https://github.com/Varying-Vagrant-Vagrants/VVV/wiki/Auto-site-Setup) designed to be used with [Varying Vagrants Vagrant](https://github.com/Varying-Vagrant-Vagrants/VVV) for developing pods or a custom website using pods.

If you use PhpStorm take a look at  [HowTo Configure Debug & PHPUnit](https://github.com/quasel/pods-dev-vvv/blob/master/phpunit.md) for really easy steps to start using debugging (awesome!)


## To get started:

Important: The Database `wordpress_<directory>` gets deleted on install/reset ( any special characters are removed from the Folder Name )

1. Download or clone this repo to your VVV/`www` folder - `git clone https://github.com/quasel/pods-dev-vvv`
2. If your Vagrant is running, from the Vagrant directory run `vagrant halt` followed by `vagrant up --provision`.
3. Known Issue: Sometimes you need to deactivate/activate the query-monitor plugin to get it working ( strange don't know why )

Perhaps a cup of tea or coffee now? The provisioning may take a while.
Then you can visit [http://pods.wordpress.dev](http://pods.wordpress.dev) to start developing or reviewing pods.

### Need more than one? Want a different URL?

1. Download or Copy to a new Folder
2. Search&Replace `pods.wordpress.dev` in `vvv-hosts`, `vvv-init.sh` and `vvv-nginx.conf` with your desired URL
3. -> Get Started ^^

### To start over or update ( reset ):

#### A fresh start:
- You can do it the soft way using `vagrant ssh -c 'cd /srv/www/pods-dev-vvv/ && rm -Rf htdocs/ && sh vvv-init.sh'`.
- Or, you can do it the hard way `vagrant reload --provision` and get a cup of coffee.

#### Just update everything except pods:
`vagrant ssh -c 'cd /srv/www/pods-dev-vvv/ && sh vvv-init.sh'`

## Dependencies

- [Varying Vagrants Vagrant](https://github.com/Varying-Vagrant-Vagrants/VVV) - [Installation guide](https://github.com/Varying-Vagrant-Vagrants/VVV#the-first-vagrant-up)
- [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) - Install with `vagrant plugin install vagrant-hostsupdater`

## What will happen?

- Install WordPress and import "Theme Unit Test Data" ( if you dont want it comment out lines after # Import the unit data. in vvv-init.sh )
- Install a bunch of developer plugins you might need ( especially Query Monitor which replaces Debug Bar but you can still use all the extensions )
- Install any `.zip` themes located in the root

## Credentials and Such

### Theme Review

* Username: `admin`
* Password: `password`
* Login: [login](http://pods.wordpress.dev/wp-admin)

### MySQL Root

* User: `root`
* Pass: `root`
* See: [Connecting to MySQL](https://github.com/varying-vagrant-vagrants/vvv/wiki/Connecting-to-MySQL) from your local machine

# Using Themes

If you drop a theme's `.zip` file into the root folder (not htdocs) provisioning will automatically install the theme ready for activation.
Yes, drop six zip files and all six themes will install automagically.

_________________________

# Changelog

## 0.2
- improve images
- improve text
- improve layout

## 0.1
- based on https://github.com/aubreypwd/wordpress-themereview-vvv adapted for pods


# Contributors

@quasel, @pglewis ( https://docs.google.com/document/d/1WOzgYlU8PnJ99ScRePumfUwg645vmuE4v5MyshOYF4M/edit# )

Forked from https://github.com/aubreypwd/wordpress-themereview-vvv
@aubreypwd @RCowles @grappler

