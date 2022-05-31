# <img src="https://raw.githubusercontent.com/AndyObtiva/contact_manager/master/icons/linux/Contact%20Manager.png" height=85 /> Contact Manager
##  [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer-dsl-swt/master/images/glimmer-logo-hi-res.png" height=40 /> Glimmer Application](https://github.com/AndyObtiva/glimmer-dsl-swt)

Contact Manager is a [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) sample leveraging [SQLite DB](https://www.sqlite.org/index.html) via [ActiveRecord](https://rubygems.org/gems/activerecord).

![Contact Manager Screenshot](/screenshots/contact-manager.png)

## Setup

### Clone Project Locally

Start by setting up [JDK 18](https://www.oracle.com/java/technologies/downloads) & [JRuby 9.3.3.0](https://www.jruby.org/) (+ [RVM](http://rvm.io/) on Mac/Linux) just as per [Glimmer DSL for SWT prerequisites](https://github.com/AndyObtiva/glimmer-dsl-swt#pre-requisites).

Clone:

```
git clone https://github.com/AndyObtiva/contact_manager.git
```

Change directory:

```
cd contact_manager
```

Bundle:

```
bundle
```

Run:

```
glimmer run
```

Or run with the binary script:

```
bin/contact_manager
```

You can [package as a native executable](https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_PACKAGING_AND_DISTRIBUTION.md) (DMG/PKG/APP on Mac, MSI/EXE on Windows, DEB/RPM on Linux) by running this command:

```
glimmer package
```

Or run the following to specify the native package type (e.g. `dmg` on the Mac):

```
glimmer "package[dmg]"
```

## Software Architecture & Design

Contact Manager follows the [MVP](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) flavor of [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller), so the View communicates to the Model via a Presenter, which is an enhanced Controller that enables bidirectional attribute data-binding between the Model and the View.

The View uses `contact_form`, `contact_table`, and `contact_manager_menu_bar` custom widgets (components)

The Model layer includes a `Contact` and `ContactRepository` ([DDD Repository Pattern](https://www.domainlanguage.com/wp-content/uploads/2016/05/DDD_Reference_2015-03.pdf)) in addition to `ContactPresenter` (which is both a Controller and a Model at a higher level).

`Contact` follows the [Active Record Pattern](https://en.wikipedia.org/wiki/Active_record_pattern) for [Object Relational Mapping](https://en.wikipedia.org/wiki/Object%E2%80%93relational_mapping) to store objects in a [SQLite](https://www.sqlite.org/index.html) relational database.

The Contact Manager graphical user interface leverages the [Master-Detail Interface Pattern](https://en.wikipedia.org/wiki/Master%E2%80%93detail_interface).

The database is stored at `~/db/database.sqlite3` (`~` is the User Home directory)

## TODO

[TODO.md](TODO.md)

## Contributing

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## Copyright

[MIT](LICENSE.txt)

Copyright (c) 2022 Andy Maleh. See [LICENSE.txt](LICENSE.txt) for further details.

--

Contact Manager logo was made by [Freepik](https://www.flaticon.com/authors/freepik) from [www.flaticon.com](http://www.flaticon.com)
