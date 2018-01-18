# frozen_string_literal: true

require 'atomos/version'

module Atomos
  module_function

  def atomic_write(dest, contents = nil, tmpdir: Dir.tmpdir, &block)
    unless contents.nil? ^ block.nil?
      raise ArgumentError, 'must provide either contents or a block'
    end

    require 'tempfile'

    Tempfile.open(".atomos.#{File.basename(dest)}", tmpdir) do |tmpfile|
      if contents
        tmpfile << contents
      else
        retval = yield tmpfile
      end

      File.rename(tmpfile.path, dest)

      retval
    end
  end
end
