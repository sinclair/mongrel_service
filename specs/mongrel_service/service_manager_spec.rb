require File.join( File.dirname(__FILE__), '..', 'spec_helper' )
require 'service_manager'
require 'sc_query_output_helper'

describe ServiceManager do
  include SCQueryOutputHelper

  context '#exist?' do
    it 'should return true when the service_name is an installed service' do
      ServiceManager::CommandLine.should_receive(:exec).once.and_return( [0, existing_service_output('installed-service')] )
      ServiceManager.exist?('installed-service').should be_true
    end

    it 'should not return true when the service_name is not an installed service' do
      ServiceManager::CommandLine.should_receive(:exec).once.and_return( [0, non_existant_service_output()] )
      ServiceManager.exist?('non-existant-service').should_not be_true
    end

  end
end
