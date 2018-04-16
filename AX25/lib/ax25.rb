require 'cosmos/interfaces/protocols/protocol'
module Cosmos
  class AX25Protocol < Protocol

    def read_data(data)
      return super(data) if (data.length <= 0)

      ADDR_DEST = data[0  ..55 ]
      ADDR_SRC  = data[56 ..111]
      CONTROL   = data[111..118]
      PROTOCOL  = data[119..126]
      INFO      = data[127..-1 ]

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
