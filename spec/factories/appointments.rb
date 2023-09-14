FactoryBot.define do
  factory :appointment do
    start_time { Time.now }
    end_time { Time.now + 1.hour }
    booked { false }

    association :patient, factory: :user, type: 'Doctor'
    association :doctor, factory: :user, type: 'Doctor'
    association :availability, factory: :availability
  end
end
