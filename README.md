### Vanilla

Vanilla is a open source social network.

![screen](https://raw.github.com/isqad88/vanilla/master/doc/screen.jpg)

#### Features

* Ruby on Rails framework as backend application;
* Frontend based on [Angular](http://angularjs.org) framework;
  * All user actions occur on the same page;
  * UI based on [Zurb Foundation](http://foundation.zurb.com/) (default theme);
* Postgresql database.

#### Quick Start

##### Requirements

* Installed Postgresql
* Installed Ruby v. 1.9.x, RVM or RubyEnv optional
* Installed Bundler gem

##### Step 1. Git clone and bundle install

``` bash
$ git clone git://github.com/isqad88/vanilla.git project_folder
$ cd project_folder && bundle install --path vendor/bundle
```

##### Step 2. Run application

``` bash
$ bundle exec rails s webrick
```

Open http://localhost:3000 in browser