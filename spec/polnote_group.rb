require 'rmsgen'

describe Rmsgen::PolnoteGroup do
  context '.fetch' do
    context 'from a file system' do
      it 'collects file contents' do
        file_system_polnote_group = mock
        file_system_polnote_group.should_receive(:all)
        Rmsgen::PolnoteGroup.should_receive(:group).and_return(file_system_polnote_group)
        Rmsgen::PolnoteGroup.fetch('/some/path')
      end
    end

    context 'from an imap server' do
      it 'collects email contents' do
        imap_polnote_group = mock
        imap_polnote_group.should_receive(:all)
        Rmsgen::PolnoteGroup.should_receive(:group).and_return(imap_polnote_group)
        imap_options = { 'imap_server' => 'foo.test.com', 'imap_login' => 'login', 'imap_password' => 'password' }
        Rmsgen::PolnoteGroup.fetch(imap_options)
      end
    end
  end
end
