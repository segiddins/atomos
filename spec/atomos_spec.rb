# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'

RSpec.describe Atomos do
  let(:tmpdir) { Dir.mktmpdir }
  let(:target) { File.join(tmpdir, 'target') }

  after { FileUtils.remove_entry tmpdir }

  it 'has a version number' do
    expect(Atomos::VERSION).not_to be_nil
  end

  describe '#atomic_write' do
    it 'raises when no contents or block is given' do
      expect { described_class.atomic_write('true') }.to raise_error ArgumentError
    end

    it 'raises when both contents and block are given' do
      expect { described_class.atomic_write('true', 'false') { |_f| raise } }
        .to raise_error ArgumentError
    end

    it 'writes' do
      described_class.atomic_write(target, 'true')
      expect(File.read(target)).to eq 'true'
    end
  end
end
