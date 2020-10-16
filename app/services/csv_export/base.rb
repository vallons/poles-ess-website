module CsvExport
  class Base

    def initialize(relation)
      @relation = relation
    end

    def call
      ::CSV.generate do |csv|
        csv << headers
        @relation.each do |item|
          csv << attributes(item)
        end
      end
    end

    private

    def headers
      %w["a" "générer"]
    end

    def attributes(item)
      %w["a" "générer"]
    end
  end
end