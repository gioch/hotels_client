RSpec::Matchers.define :have_status do |type, message = nil|
  match do |_response|
    assert_response type, message
  end
end

RSpec::Matchers.define :serialize_object do |object|
  match do |response|
    @serializer_klass.new(object, root: false).to_json == response.body
  end

  chain :with do |serializer_klass|
    @serializer_klass = serializer_klass
  end
end

RSpec::Matchers.define :serialize_array do |object|
  match do |response|
    response.body == ActiveModel::ArraySerializer.new(
      object,
      each_serializer: @serializer_klass
    ).to_json
  end

  chain :with do |serializer_klass|
    @serializer_klass = serializer_klass
  end
end
