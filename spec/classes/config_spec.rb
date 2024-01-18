# frozen_string_literal: true

require 'spec_helper'

describe 'conntrackd::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default facts and parameters' do
        let(:pre_condition) { 'include conntrackd' }

        it { is_expected.to compile }
        
        it do
          is_expected.to contain_file('conntrackd-confdir')
            .with_ensure('directory')
        end

        it do
          is_expected.to contain_file('conntrackd-config')
            .with_ensure('present')
            .that_requires('File[conntrackd-confdir]')
            .that_notifies('Service[conntrackd]')
        end
      end
    end
  end
end
