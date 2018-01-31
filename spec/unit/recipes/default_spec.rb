#
# Cookbook:: tomcat
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'tomcat::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on CentOS 7.4.1708' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.4.1708')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
 describe package('java-1.7.0-openjdk-devel') do
   it { should be_installed }
 end
 describe group('tomcat') do
   it { should exist }
 end

 describe user('tomcat') do
   it { should exist }
   it { should belong_to_group 'tomcat' }
   it { should_have_home_directory '/opt/tomcat' }
 end

 describe file('/opt/tomcat') do
   it { should exist }
   it {should be_directory }
 end
 
 describe file('/opt/tomcat/conf') do
   it { should exist }
   it { should be_mode 50 }
 end

end
