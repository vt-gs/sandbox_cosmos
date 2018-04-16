require 'cosmos/interfaces/protocols/protocol'
module Cosmos
  class AX25Protocol < Protocol
    FEND = "\xC0"

    def read_data(data)
      return super(data) if (data.length <= 0)
      <decode TFEND and TFESC>
      return data
    end

    def write_data(data)
      index = data.index(FEND)
      if index
        data = data[0..(index-1)] + TFEND + FEND + data[index..-1]
      end
      index = data.index(FESC)
      if index
        data = data[0..(index-1)] + TFESC + FESC + data[index..-1]
      end
      data
    end
  end
end