require File.join( File.dirname(__FILE__), '..', 'spec_helper' )
require 'service_manager'
include ServiceManager

describe CommandLine do

  context '#exec' do
    it 'should return the os process exit status' do
      CommandLine.exec('dir', []).should include($?.exitstatus)
    end

    it 'should return the command output' do
      expected = `dir . 2>&1`
      CommandLine.exec('dir', ['.']).should include(expected)
    end

  end

end

