module Dhelp
  module Exporter
    class Base
      def initialize(doc_pool)
        @doc_pool = doc_pool
      end

      def export(options)
        raise NotImplementedError
      end
    end
  end
end
