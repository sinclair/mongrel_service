require File.join( File.dirname(__FILE__), '..', 'spec_helper' )
require 'service_manager'
include ServiceManager

describe CommandLine do

  context '#exec' do
    it 'should return the os process exit status' do
      CommandLine.exec('dir', []).should include(0)
    end

    it 'should return the command output' do
      expected = 'The command output.'
      CommandLine.stub!(:`).and_return(expected)
      CommandLine.exec('dir', ['.']).should include(expected)
    end

    it 'should invoke the command line with the command and arguments' do
      CommandLine.should_receive(:`).once.with('dir foo.txt todo.txt 2>&1')
      CommandLine.exec('dir', 'foo.txt', 'todo.txt')
    end

    it 'should support #net commands' do
      CommandLine.exec('net', 'start')
      $?.success?.should == true
    end

    it 'should support #sc commands' do
      CommandLine.exec('sc', 'query')
      $?.success?.should == true
    end

  end

  context '#exec could return "$?.success?" value for querying the command`s success' do

    it 'will indicate an invalid command' do
      CommandLine.exec('no-such-command-surely', '')
      $?.success?.should == false
    end

    it 'will indicate an invalid `net` command' do
      CommandLine.exec('net', 'glasgow', 'banana')
      $?.success?.should == false
    end

    it 'will indicate an invalid `net start` command parameters' do
      CommandLine.exec('net', 'start', 'banana')
      $?.success?.should == false
    end

    it 'will indicate an invalid `net stop` command' do
      CommandLine.exec('net', 'stop', 'banana')
      $?.success?.should == false
    end

  end

end
