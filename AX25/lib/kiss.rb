require 'cosmos/interfaces/protocols/protocol'
module Cosmos
  class KissProtocol < Protocol
    FEND = "\xC0"
    FESC = "\xDB"
    TFEND = "\xDC"
    TFESC = "\xDD"

    def read_data(data)
      return super(data) if (data.length <= 0)

      FEND_1  = data[0]
      COMMAND = data[1]
      FEND_2  = data[-1]

      data = data[2..-2]

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
