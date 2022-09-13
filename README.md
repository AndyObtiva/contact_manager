# <img src="https://raw.githubusercontent.com/AndyObtiva/contact_manager/master/icons/linux/Contact%20Manager.png" height=85 /> Contact Manager 1.0.2
##  [<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer-dsl-swt/master/images/glimmer-logo-hi-res.png" height=40 /> Glimmer Application](https://github.com/AndyObtiva/glimmer-dsl-swt)
[![Gem Version](https://badge.fury.io/rb/contact_manager.svg)](http://badge.fury.io/rb/contact_manager)

Contact Manager is a [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) sample leveraging [SQLite DB](https://www.sqlite.org/index.html) via [ActiveRecord](https://rubygems.org/gems/activerecord).

Learn more in the blog post: [Using ActiveRecord with SQLite DB in a JRuby Desktop App](https://andymaleh.blogspot.com/2022/06/using-activerecord-with-sqlite-db-in.html?m=0).

![Contact Manager Screenshot](/screenshots/contact-manager.gif)

## Requirements

1. Store contacts having the following attributes:
    - First Name
    - Last Name
    - Email
    - Phone
    - Street
    - City
    - State/Province
    - Zip/Postal Code
    - Country
2. List stored contacts
3. Search stored contacts by any of the contact attributes.
4. Sort contacts by First Name, Last Name, Email, Phone, or Full Address
5. Edit a stored contact
6. Delete a stored contact
7. Delete all stored contacts

## Setup

### Option 1: Install Native Executable Package

[<img src="https://raw.githubusercontent.com/AndyObtiva/contact_manager/master/icons/linux/Contact%20Manager.png" height=40 /> Contact Manager 1.0.1 (Mac Catalina 10.15.7 x86_64 DMG)](https://www.dropbox.com/s/fh0nhbf9gg755kc/Contact%20Manager-1.0.1-x86_64-catalina-10.15.7.dmg?dl=1)

[<img src="https://raw.githubusercontent.com/AndyObtiva/contact_manager/master/icons/linux/Contact%20Manager.png" height=40 /> Contact Manager 1.0.1 (Windows 10.0.19043 x86_64 MSI)](https://www.dropbox.com/s/nnknffe77iyiat8/Contact%20Manager-1.0.1-x86_64-windows-10.0.19043.msi?dl=1)

[<img src="https://raw.githubusercontent.com/AndyObtiva/contact_manager/master/icons/linux/Contact%20Manager.png" height=40 /> Contact Manager 1.0.1 (Linux x86_64 DEB)](https://www.dropbox.com/s/mpr0wl9re7l30uq/contact-manager_1.0.1-1_amd64.deb?dl=1)

[<img src="https://raw.githubusercontent.com/AndyObtiva/contact_manager/master/icons/linux/Contact%20Manager.png" height=40 /> Contact Manager 1.0.1 (Linux x86_64 RPM)](https://www.dropbox.com/s/7lw9ktnikx3m5es/contact-manager-1.0.1-1.x86_64.rpm?dl=1)

### Option 2: Install Ruby Gem

Start by setting up [JDK 18](https://www.oracle.com/java/technologies/downloads) & [JRuby 9.3.7.0](https://www.jruby.org/) (+ [RVM](http://rvm.io/) on Mac/Linux) just as per [Glimmer DSL for SWT prerequisites](https://github.com/AndyObtiva/glimmer-dsl-swt#pre-requisites).

Install Ruby gem:

```
gem install contact_manager -v1.0.2
```

Run:

```
contact_manager
```

### Option 3: Clone Project Locally

Start by setting up [JDK 18](https://www.oracle.com/java/technologies/downloads) & [JRuby 9.3.7.0](https://www.jruby.org/) (+ [RVM](http://rvm.io/) on Mac/Linux) just as per [Glimmer DSL for SWT prerequisites](https://github.com/AndyObtiva/glimmer-dsl-swt#pre-requisites).

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

You can [package a native executable](https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_PACKAGING_AND_DISTRIBUTION.md) DMG on Mac:

```
glimmer "package[dmg]"
```

You can [package a native executable](https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_PACKAGING_AND_DISTRIBUTION.md) MSI on Windows (assuming you followed [MSI related setup instructions](https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_PACKAGING_AND_DISTRIBUTION.md)):

```
glimmer "package[msi]"
```

You can [package a native executable](https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_PACKAGING_AND_DISTRIBUTION.md) DEB on debian-based Linux distros:

```
glimmer "package[deb]"
```

You can [package a native executable](https://github.com/AndyObtiva/glimmer-dsl-swt/blob/master/docs/reference/GLIMMER_PACKAGING_AND_DISTRIBUTION.md) RPM on redhat-based Linux distros:

```
glimmer "package[rpm]"
```

## Software Architecture & Design

Contact Manager follows the [Model-View-Presenter](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) flavor of [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller), so the View communicates to the Model via a Presenter, which is an enhanced Controller that enables bidirectional attribute data-binding between the Model and the View.

The View uses `contact_form`, `contact_table`, and `contact_manager_menu_bar` custom widgets (components).

The Contact Manager graphical user interface leverages the [Master-Detail Interface Pattern](https://en.wikipedia.org/wiki/Master%E2%80%93detail_interface) by displaying a master list via `contact_table` and allowing navigation by selecting a `Contact` and displaying its details for editing in `contact_form`.

`contact_table` leverages the `table` widget, which has automatic in-memory sort support. `contact_table` also comes with a 'Delete...' right-click menu item (aka contextual pop up menu item) for deleting a selected `Contact` row.

`contact_manager_menu_bar` provides top menu bar actions like 'New', 'Save', 'Delete...', and 'Delete All...'

The Model layer includes a `Contact` and `ContactRepository` ([DDD Repository Pattern](https://www.domainlanguage.com/wp-content/uploads/2016/05/DDD_Reference_2015-03.pdf)) in addition to `ContactPresenter` (which is both a Controller and a Model at a higher level).

`Contact` follows the [Active Record Pattern](https://en.wikipedia.org/wiki/Active_record_pattern) for [Object Relational Mapping](https://en.wikipedia.org/wiki/Object%E2%80%93relational_mapping) to store objects in a [SQLite](https://www.sqlite.org/index.html) relational database table called `contacts` via a [migration](/db/migrate/20220411211513_create_contacts.rb). It also implements [ActiveRecord Validations](https://guides.rubyonrails.org/active_record_validations.html) for `first_name`, `last_name`, `email`, `phone`, and `zip_or_postal_code` fields.

`ContactRepository` provides the ability to search through all `Contact`s using the [ActiveRecord Query Interface](https://guides.rubyonrails.org/active_record_querying.html), triggered indirectly by `ContactPresenter` when typing into a `text` field that is on top of the `contact_table` .

The database is stored at `File.join(Dir.home, 'db/contact_manager.sqlite3')`

## TODO

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

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

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built with [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) (JRuby Desktop Development GUI Library)

Contact Manager logo was made by [Freepik](https://www.flaticon.com/authors/freepik) from [www.flaticon.com](http://www.flaticon.com)
