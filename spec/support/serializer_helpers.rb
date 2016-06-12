module SerializerExampleGroup
  extend ActiveSupport::Concern

  included do
    metadata[:type] = :serializer

    def serialize(object)
      JSON.parse(described_class.new(object, root: false).to_json)
    end

    def serialize_array(objects)
      JSON.parse(ActiveModel::ArraySerializer.new(objects, each_serializer: described_class).to_json)
    end
  end

  RSpec.configure do |config|
    config.include self, type: :serializer, file_path: %r{ spec/serializers }
  end
end
