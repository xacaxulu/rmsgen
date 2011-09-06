Given /^a polnote:$/ do |string|
  Given %{a directory named "polnotes"}
  Given %{I cd to "polnotes"}
  write_file('polnote', string)
  Given %{I cd to ".."}
  write_file('config.yml', 'email_dir: polnotes')
end

Given /^another polnote:$/ do |string|
  Given %{I cd to "polnotes"}
  write_file('another_polnote', string)
end

When /^I type "([^"]*)" for the title$/ do |title|
  Given %{I type "#{title}"}
end

When /^I type "([^"]*)" for the link text$/ do |text|
  Given %{I type "#{text}"}
end

When /^I type "([^"]*)" for the url$/ do |url|
  Given %{I type "#{url}"}
end

