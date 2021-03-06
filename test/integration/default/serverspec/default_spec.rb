require 'serverspec'

#################################################
## New Version of Serverspec -- This is broken ##
#include SpecInfra::Helper::Exec
#include SpecInfra::Helper::DetectOS
#################################################

set :backend, :exec

if ['Debian', 'Ubuntu'].include?(os[:family])

    describe package('php5-fpm') do
        it { should be_installed }
    end

    describe service('php5-fpm') do
        it { should be_enabled }
    end

    describe service('php5-fpm') do
        it { should be_running }
    end

elsif ['RedHat', 'CentOS', 'Fedora'].include?(os[:family])

    describe package('php-fpm') do
        it { should be_installed }
    end

    describe service('php-fpm') do
        it { should be_enabled }
    end

    describe service('php-fpm') do
        it { should be_running }
    end

end