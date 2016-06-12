require 'ffaker'

FactoryGirl.define do
  sequence :id do
    rand(2..20)
  end

  sequence :name do
    rand(2..5).times.map { FFaker::Lorem.word }.join(' ')
  end

  sequence :address do
    rand(2..5).times.map { FFaker::Lorem.word }.join(' ')
  end

  sequence :star_rating do
    rand(2..5)
  end

  sequence :accomodation_type_id do
    rand(2..100)
  end
end
