Before('@setup_polnote_directory') do
  Given %{a directory named "polnotes"}
  Given %{I cd to "polnotes"}
end

Before('@urgent_note') do
  Given %{an urgent polnote exists}
end
