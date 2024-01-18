# frozen_string_literal: true

require 'spec_helper'

describe 'conntrackd::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default facts and parameters' do
        let(:pre_condition) { 'include conntrackd' }

        it { is_expected.to compile }
        
        it do
          is_expected.to contain_service('conntrackd')
            .with_ensure('running')
            .with_enable(true)
        end
      end

      context 'with ensure absent' do
        let(:pre_condition) do
          <<~END
            class { 'conntrackd':
              ensure => absent,
            }
          END
        end

        it { is_expected.to compile }
        
        it do
          is_expected.to contain_service('conntrackd')
            .with_ensure('stopped')
            .with_enable(false)
        end
      end
    end
  end
end
