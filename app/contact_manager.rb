$LOAD_PATH.unshift(File.expand_path('..', __FILE__))
$LOAD_PATH.unshift(File.expand_path('../..', __FILE__))

begin
  require 'bundler/setup'
  Bundler.require(:default)
rescue
  # this runs when packaged as a gem (no bundler)
  require 'glimmer-dsl-swt'
  # add more gems if needed
end

class ContactManager
  APP_ROOT = File.expand_path('../..', __FILE__)
  VERSION = File.read(File.join(APP_ROOT, 'VERSION'))
  LICENSE = File.read(File.join(APP_ROOT, 'LICENSE.txt'))
end

require 'db/db'
require 'contact_manager/model/contact'
require 'contact_manager/view/app_view'
