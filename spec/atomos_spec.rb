# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'

# rubocop:disable Metrics/BlockLength
RSpec.describe Atomos do
  let(:test_file) { 'test_output.txt' }
  let(:tmpdir) { Dir.mktmpdir }
  after { FileUtils.remove_entry tmpdir }
  let(:target) { File.join(tmpdir, test_file) }

  it 'has a version number' do
    expect(described_class::VERSION).not_to be_nil
  end

  describe '#atomic_write' do
    it 'raises when no contents or block is given' do
      expect { described_class.atomic_write('true') }.to raise_error ArgumentError
    end

    it 'raises when both contents and block are given' do
      expect { described_class.atomic_write('true', 'false') { |_f| } }
        .to raise_error ArgumentError
    end

    it 'writes' do
      described_class.atomic_write(target, 'true')
      expect(File.read(target)).to eq 'true'
    end

    it 'creates a temporary file during writing' do
      temp_file = nil

      described_class.atomic_write(target) do |file|
        temp_file = file.path
        file.write('Temporary content')
      end

      expect(File.exist?(temp_file)).to be false
      expect(File.exist?(target)).to be true
    end

    it 'preserves original permissions if file exists' do
      File.write(target, 'Existing content')
      File.chmod(0o644, target)
      original_mode = File.stat(target).mode & 0o777

      described_class.atomic_write(target) { |file| file.write('New content') }

      new_mode = File.stat(target).mode & 0o777
      expect(new_mode).to eq(original_mode)
    end
  end
end
# rubocop:enable Metrics/BlockLength
