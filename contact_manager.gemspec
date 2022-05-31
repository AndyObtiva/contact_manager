# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: contact_manager 1.0.0 ruby vendor lib app

Gem::Specification.new do |s|
  s.name = "contact_manager".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["vendor".freeze, "lib".freeze, "app".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2022-05-31"
  s.description = "Contact Manager".freeze
  s.email = "andy.am@gmail.com".freeze
  s.executables = ["contact_manager".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "LICENSE.txt",
    "VERSION",
    "app/contact_manager.rb",
    "app/contact_manager/launch.rb",
    "app/contact_manager/model/contact.rb",
    "app/contact_manager/model/contact_presenter.rb",
    "app/contact_manager/model/contact_repository.rb",
    "app/contact_manager/view/app_view.rb",
    "app/contact_manager/view/contact_form.rb",
    "app/contact_manager/view/contact_manager_menu_bar.rb",
    "app/contact_manager/view/contact_table.rb",
    "bin/contact_manager",
    "config/warble.rb",
    "db/database.sqlite3",
    "db/db.rb",
    "db/migrate.rb",
    "db/migrate/20220411211513_create_contacts.rb",
    "icons/linux/Contact Manager.png",
    "icons/macosx/Contact Manager.icns",
    "icons/windows/Contact Manager.ico",
    "vendor/jars/org/yaml/snakeyaml/1.28/snakeyaml-1.28.jar"
  ]
  s.homepage = "http://github.com/AndyObtiva/contact_manager".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.29".freeze
  s.summary = "Contact Manager".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 4.23.0.1"])
    s.add_runtime_dependency(%q<activerecord>.freeze, ["~> 6.1.5"])
    s.add_runtime_dependency(%q<activerecord-jdbcsqlite3-adapter>.freeze, ["~> 61.1"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<juwelier>.freeze, ["= 2.4.9"])
    s.add_development_dependency(%q<warbler>.freeze, ["= 2.0.5"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 4.23.0.1"])
    s.add_dependency(%q<activerecord>.freeze, ["~> 6.1.5"])
    s.add_dependency(%q<activerecord-jdbcsqlite3-adapter>.freeze, ["~> 61.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<juwelier>.freeze, ["= 2.4.9"])
    s.add_dependency(%q<warbler>.freeze, ["= 2.0.5"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end

