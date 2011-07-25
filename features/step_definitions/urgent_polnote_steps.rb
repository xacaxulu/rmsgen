Given /^I am ready to do polnotes/ do
  Given %{a directory named "polnotes"}

  config = ""
  config << "email_dir: polnotes"
  write_file("config.yml", config)
end

Given /^an urgent polnote exists$/ do
  polnote = fixture("urgent_note")  
  write_file("urgent", polnote)
  cd '..'
end

Given /^I use rmsgen$/ do
  Given %{I run `rmsgen -c config.yml` interactively}
end

Then /^the output shows the polnote section$/ do
end

Then /^the output shows the urgent section$/ do
  
end
