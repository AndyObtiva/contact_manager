require 'active_record'
require 'jdbc/sqlite3'
Jdbc::SQLite3.load_driver
require 'activerecord-jdbcsqlite3-adapter' if defined? JRUBY_VERSION
@connection = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/database.sqlite3')
require 'db/migrate'
