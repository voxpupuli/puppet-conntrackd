# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'conntrackd' do
  context 'with default parameters' do
    let(:manifest) do
      <<~END
        class { 'conntrackd':
          interface      => $facts['networking']['primary'],
          ipv4_interface => $facts['networking']['ip'],
        }
      END
    end

    it 'applies without errors' do
      apply_manifest(manifest, catch_failures: true)
      # We expect a change on the second run.
      # The first run will use default settings for
      # HashLimit since the nf_conntrack_max fact
      # won't return a value if the nf_conntrack
      # kernel module isn't loaded.
      apply_manifest(manifest, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(manifest, catch_changes: true)
    end
  end
end
