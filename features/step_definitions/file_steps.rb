Then /^"([^"]*)" should exists$/ do |file_name|
  File.exists?("tmp/aruba/#{file_name}").should be true
end
