module Serializable
  extend ActiveSupport::Concern
  module ClassMethods
    def io_attributes *attributes
      @io_attributes ||= attributes.collect(&:to_s)
    end

    def io_key
      @io_attributes.first
    end

    def from_csv file
      CSV.foreach file.path, headers: true do |row|
        instance = find_by(Hash[io_key.to_sym, row[io_key]]) || new
        instance.attributes = row.to_hash.slice(*io_attributes)
        instance.save!
      end
    end

    def to_csv
      CSV.generate do |csv|
        csv << io_attributes
        all.each do |instance|
          csv << io_attributes.map { |attr| instance.send attr }
        end
      end
    end
  end
end
