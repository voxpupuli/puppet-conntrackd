# frozen_string_literal: true

require 'spec_helper'

describe 'conntrackd::package' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with ensure present' do
        let(:pre_condition) do
          <<~END
            class { 'conntrackd':
              ensure  => present,
              package => ['conntrack-package'],
            }
          END
        end

        it { is_expected.to compile }

        it do
          is_expected.to contain_package('conntrack-package').
            with_ensure('present')
        end
      end

      context 'with autoupgrade enabled' do
        let(:pre_condition) do
          <<~END
            class { 'conntrackd':
              ensure      => present,
              package     => ['conntrack-package'],
              autoupgrade => true,
            }
          END
        end

        it { is_expected.to compile }

        it do
          is_expected.to contain_package('conntrack-package').
            with_ensure('latest')
        end
      end

      context 'with ensure absent' do
        let(:pre_condition) do
          <<~END
            class { 'conntrackd':
              ensure  => absent,
              package => ['conntrack-package'],
            }
          END
        end

        it { is_expected.to compile }

        it do
          is_expected.to contain_package('conntrack-package').
            with_ensure('purged')
        end
      end
    end
  end
end
