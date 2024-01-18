# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/nf_conntrack_max'

describe :nf_conntrack_max, type: :fact do
  subject(:fact) { Facter.fact(:nf_conntrack_max) }

  before :each do
    Facter.clear
  end

  context 'on Linux' do
    before :each do
      allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
    end

    context 'when /proc/sys/net/netfilter/nf_conntrack_max exists' do
      let(:value) { 262144 }

      before :each do
        allow(File).to receive(:exist?).with('/proc/sys/net/netfilter/nf_conntrack_max').and_return(true)
        allow(File).to receive(:exist?).with('/proc/sys/net/ipv4/ip_conntrack_max').and_return(false)
        allow(File).to receive(:read).with('/proc/sys/net/netfilter/nf_conntrack_max').and_return("#{value}\n")
      end

      it 'returns a value' do
        expect(fact.value).to eq(value)
      end
    end

    context 'when /proc/sys/net/ipv4/ip_conntrack_max exists' do
      let(:value) { 131072 }

      before :each do
        allow(File).to receive(:exist?).with('/proc/sys/net/netfilter/nf_conntrack_max').and_return(false)
        allow(File).to receive(:exist?).with('/proc/sys/net/ipv4/ip_conntrack_max').and_return(true)
        allow(File).to receive(:read).with('/proc/sys/net/ipv4/ip_conntrack_max').and_return("#{value}\n")
      end

      it 'returns a value' do
        expect(fact.value).to eq(value)
      end
    end

    context 'when neither exists' do
      before :each do
        allow(File).to receive(:exist?).with('/proc/sys/net/netfilter/nf_conntrack_max').and_return(false)
        allow(File).to receive(:exist?).with('/proc/sys/net/ipv4/ip_conntrack_max').and_return(false)
      end

      it 'returns nil' do
        expect(fact.value).to be_nil
      end
    end
  end

  context 'on a non-Linux host' do
    before :each do
      allow(Facter.fact(:kernel)).to receive(:value).and_return('Darwin')
    end

    it 'returns nil' do
      expect(fact.value).to be_nil
    end
  end
end
