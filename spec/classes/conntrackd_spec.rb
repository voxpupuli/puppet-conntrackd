# frozen_string_literal: true

require 'spec_helper'

describe 'conntrackd' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default facts and parameters' do
        it { is_expected.to compile }

        it { is_expected.to contain_class('conntrackd') }
        it { is_expected.to contain_class('conntrackd::package') }
        it { is_expected.to contain_class('conntrackd::service') }
        it { is_expected.to contain_class('conntrackd::config') }
      end

      context 'with ensure absent' do
        let(:params) { { 'ensure' => 'absent' } }

        it { is_expected.to compile }

        it { is_expected.to contain_class('conntrackd') }
        it { is_expected.to contain_class('conntrackd::package') }
        it { is_expected.to contain_class('conntrackd::service') }
        it { is_expected.not_to contain_class('conntrackd::config') }
      end
    end
  end
end
