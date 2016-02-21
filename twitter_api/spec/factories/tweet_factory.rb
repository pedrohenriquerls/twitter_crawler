FactoryGirl.define do
  factory :ipsum, class: 'Tweet' do
    username 'test'
    key 'ipsum'
    content 'lorem ipsum'
    date DateTime.new(2016, 02, 01)
  end
end