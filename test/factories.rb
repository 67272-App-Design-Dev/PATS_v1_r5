FactoryBot.define do
  
  factory :animal do
    name {"Cat"}
    active {true}
  end
  
  factory :medicine do
    name {"Rabies"}
    description {"A potent medicine for vaccinating animals against rabies"}
    stock_amount {10000}
    admin_method {"injection"}
    unit {"milliliters"}
    vaccine {true}
    active {true}
  end

  factory :animal_medicine do
    association :animal     # don't have to put the word association in front, but I think it helps...
    association :medicine
    recommended_num_of_units {100}
  end

  factory :medicine_cost do
    association :medicine
    cost_per_unit {25}
    start_date {Date.current}
    end_date {nil}
  end  

  factory :procedure do
    name {"Check-up"}
    description {"A complete check-up of pet."}
    length_of_time {15}
    active {true}
  end  
  
  factory :procedure_cost do
    association :procedure
    cost {2500}
    start_date {Date.current}
    end_date {nil}
  end  

  factory :owner do
    first_name {"Alex"}
    last_name {"Heimann"}
    street {"10152 Sudberry Drive"}
    city {"Wexford"}
    state {"PA"}
    zip {"15090"}
    active {true}
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    email { |a| "#{a.first_name}.#{a.last_name}@example.com".downcase }
  end
  
  factory :pet do
    name {"Dusty"}
    female {true}
    active {true}
    date_of_birth {10.years.ago}
    association :owner  # don't have to put the word association in front, but I think it helps...
    association :animal
  end
  
  factory :visit do
    association :pet 
    date {6.months.ago.to_date}
    weight {5.0}
    overnight_stay {false}
    total_charge {5000}
  end
  
  factory :dosage do 
    association :visit
    association :medicine
    units_given {50}
    discount {0.00}
  end

  factory :treatment do 
    association :visit
    association :procedure
    successful {true}
    discount {0.00}
  end
  
  factory :user do 
    first_name {"Ed"}
    last_name {"Gruberman"}
    role {"assistant"}
    username {"gruberman"}
    password {"secret"}
    password_confirmation {"secret"}
    active {true}
  end

end