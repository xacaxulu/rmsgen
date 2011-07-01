require 'aruba/cucumber'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

def fixture(name)
  File.read(File.expand_path(File.dirname(__FILE__) + "/../../spec/fixtures/#{name}"))
end
