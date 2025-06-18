# frozen_string_literal: true

require 'spec_helper'

describe 'Conntrackd::Exp_sync' do
  describe 'valid types' do
    context 'with valid types' do
      [
        'on',
        %w[ftp ras],
      ].each do |value|
        describe value.inspect do
          it { is_expected.to allow_value(value) }
        end
      end
    end
  end

  describe 'invalid types' do
    context 'with garbage inputs' do
      [
        nil,
        { 'foo' => 'bar' },
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end
