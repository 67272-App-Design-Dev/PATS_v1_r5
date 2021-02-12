namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Step 0: initial set-up
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate to set up db structure based on latest migrations
    Rake::Task['db:migrate'].invoke
    
    # Get the faker gem (see docs at http://faker.rubyforge.org/rdoc/)
    require 'faker' 

    # -----------------------
    # Step 1: add a default user
    user = User.new
    user.first_name = "Yodeling"
    user.last_name = "Veterinarian"
    user.username = "vet"
    user.password = "yodel"
    user.password_confirmation = "yodel"
    user.role = "vet"    
    user.save!
    
    # -----------------------    
    # Step 2: add some animal types to work with (small set for now...)
    animals = %w[Bird Cat Dog Ferret Rabbit]
    animals.sort.each do |animal|
      a = Animal.new
      a.name = animal
      a.active = true
      a.save!
    end
    # get an array of animal_ids to use later
    animal_ids = Animal.alphabetical.all.map{|a| a.id}
    
    # -----------------------
    # Step 3: add some procedures (and associated costs) that PATS will offer
    procedures = {"Check-up" => [30,12500], 
                 "Examination" => [30,15000], 
                 "X-ray" => [10,5000], 
                 "Grooming" => [15,4000], 
                 "Testing" => [10,15000], 
                 "Minor Surgery" => [75,40000], 
                 "Major Surgery" => [180,120000], 
                 "Observation" => [180,7500], 
                 "Observation, Extended" => [540,15000]
                 }
    procedures.sort.each do |procedure, vars|
      p = Procedure.new
      p.name = procedure
      p.description = "An amazing procedure"
      p.length_of_time = vars[0].to_i
      p.active = true
      p.save!

      # add one older cost
      pc_older = ProcedureCost.new
      pc_older.procedure_id = p.id
      pc_older.cost = (((vars[1].to_i/100) * (0.9))*100).to_i 
      originally_started = 150  # since no pet is older than 12...
      pc_older.start_date = originally_started.months.ago.to_date
      pc_older.save!
      
      # add current cost of procedure
      pc = ProcedureCost.new
      pc.procedure_id = p.id
      pc.cost = vars[1].to_i
      started = rand(4) + 1
      pc.start_date = started.years.ago.to_date
      pc.save!
      
    end
    # get an array of procedure_ids to use later
    procedure_ids = Procedure.alphabetical.all.map{|p| p.id}
    puts "Procedure count: #{procedure_ids.count}"
    
    # -----------------------
    # Step 4: add some medicines that PATS will offer
    medicines = {"Carprofen" => [[3],"Used to relieve pain and inflammation in dogs. Annedotal reports of severe GI effects in cats."], 
                 "Deracoxib" => [[1,2,3,4,5],"Post operative pain management and osteoarthritis. Interest in use as adjunctive treatment to transitional cell carcinoma."], 
                 "Ivermectin" => [[3],"A broad-spectrum antiparasitic used in horses and dogs."], 
                 "Ketamine" => [[2,3],"Anesthetic and tranquilizer in cats, dogs, horses, and other animals"], 
                 "Mirtazapine" => [[2,3],"Antiemetic and appetite stimulant in cats and dog"], 
                 "Amoxicillin" => [[1,2,3,4,5],"Antibiotic indicated for susceptible gram positive and gram negative infections. Ineffective against species that produce beta-lactamase."], 
                 "Aureomycin" => [[1],"For use in birds for the treatment of bacterial pneumonia and bacterial enteritis."], 
                 "Pimobendan" => [[3],"Used to manage heart failure in dogs"], 
                 "Nitroscanate" => [[2,3,4,5],"Anthelmintic used to treat Toxocara canis, Toxascaris leonina, Ancylostoma caninum, Uncinaria stenocephalia, Taenia, and Dipylidium caninum (roundworms, hookworms and tapeworms)."],
                 "Buprenorphine" => [[2],"Narcotic for pain relief in cats after surgery."]
                 }
    medicines.each do |medicine, vars|
      m = Medicine.new
      m.name = medicine
      m.description = vars[1]
      m.unit = ['mililiters', 'miligrams'].sample
      m.admin_method = ['oral','injection','intravenous','topical'].sample
      m.stock_amount = rand(200000) + 50000
      m.vaccine = false
      m.active = true
      m.save!
      
      # link the medicine to relevant species
      vars[0].each do |a_id|
        am = AnimalMedicine.new
        am.medicine_id = m.id
        am.animal_id = a_id
        am.recommended_num_of_units = nil
        am.save!
      end
      
      # add an older cost
      mc_older = MedicineCost.new
      mc_older.medicine_id = m.id
      mc_older.cost_per_unit = rand(50) + 20 
      originally_started = 150 
      mc_older.start_date = originally_started.months.ago.to_date
      mc_older.save!

      # add current cost of medicine
      mc = MedicineCost.new
      mc.medicine_id = m.id
      mc.cost_per_unit = mc_older.cost_per_unit + (10 - rand(5))
      started = rand(4) + 1
      mc.start_date = started.years.ago.to_date
      mc.save!
    end
    # get an array of medicine_ids to use later
    medicine_ids = Medicine.alphabetical.all.map{|m| m.id}
    puts "Medicine count: #{medicine_ids.count}"
    
    # -----------------------
    # Step 5: add 240 owners to the system and associated pets
    240.times do 
      owner = Owner.new
      # get some fake data using the Faker gem
      owner.first_name = Faker::Name.first_name
      owner.last_name = Faker::Name.last_name
      owner.street = Faker::Address.street_address
      owner.city = "Pittsburgh"
      # assume PA since this is a Pittsburgh vet office
      owner.state = "PA"
      # randomly assign one of Pgh area zip codes
      owner.zip = ["15213", "15212", "15203", "15237", "15222", "15219", "15217", "15224"].sample
      # want to store phone as 10 digits in db and use rails helper
      # number_to_phone to format it properly in views
      owner.phone = rand(10 ** 10).to_s.rjust(10,'0')
      owner.email = "#{owner.first_name.downcase}.#{owner.last_name.downcase}@example.com"
      # assume all the owners still have living pets
      owner.active = true
      # save the owner
      owner.save!
    end
    # an array of all owner ids
    all_owner_ids = Owner.all.to_a.map{|o| o.id}
    puts "Owner count: #{all_owner_ids.count}"
    
    # Step 6: Give each owner 1 to 3 pets
    all_owner_ids.each do |oid| 
      num_pets = rand(3) + 1
      pet_names = %w[Sparky Dusty Caspian Lucky Fluffy Snuggles Snuffles Dakota Montana Cali Polo Buddy Mambo Pickles Pork\ Chop Fang Zaphod Yeller Groucho Meatball BJ CJ TJ Buttercup Bull Bojangles Copper Fozzie Nipper Mai\ Tai Bongo Bama Spot Tango Tongo Weeble].shuffle
      num_pets.times do 
        pet = Pet.new
        # assign the owner
        pet.owner_id = oid
        # give the pet a unique name from shuffled list of typical pet names
        pet.name = pet_names.pop
        # assign an animal id from ones created earlier
        pet.animal_id = animal_ids.sample
        # randomly assign female status
        pet.female = [true, false].sample
        # pick a DOB at random ranging 30 days ago (newborn) to 12 years old
        pet.date_of_birth = (30..4400).to_a.sample.days.ago
        # now save the object
        pet.save!
      end
    end  
    all_pets = Pet.all.to_a
    puts "Pet count: #{all_pets.count}"
 
    # Step 7: add between 1 to 15 visits for each pet
    all_pets.each do |pet|
      num_visits = rand(15) + 1
      num_visits.times do
        visit = Visit.new
        visit.pet_id = pet.id
        # set the visit to sometime between DOB and the present
        visit.date = Faker::Time.between(from: pet.date_of_birth, to: Date.today).to_date
        # different animals fall in different weight ranges so we need
        # to find the right range of weights for the visiting pet
        case pet.animal_id
          when 1  # birds tend to be between 1 & 2 pounds
            weight_range = (1..2) 
          when 2  # cats 
            weight_range = (5..15)
          when 3  # dogs
            weight_range = (10..60)
          when 4  # ferrets
            weight_range = (1..6)
          when 5  # rabbits
            weight_range = (2..7)
        end
        # now assign the pet a weight within the range
        visit.weight = weight_range.to_a.sample
        visit.save!
      end
    end

    all_visit_ids = Visit.all.map(&:id)
    puts "Visit count: #{all_visit_ids.count}"

    # Step 8: every visit has at least 1 treatment, maybe 2 or 3
    all_visit_ids.each do |visit_id|
      proc_id = procedure_ids.shuffle
      treatment = Treatment.new
      treatment.visit_id = visit_id
      treatment.procedure_id = proc_id.pop
      treatment.successful = true
      treatment.discount = 0.00
      treatment.save!
      # a third of the time there is a second treatment
      if rand(3).zero?
        t2 = Treatment.new
        t2.visit_id = visit_id
        t2.procedure_id = proc_id.pop
        t2.successful = true
        if rand(7).zero? 
          t2.discount = 0.25
        else
          t2.discount = 0.00
        end
        t2.save!
        # one out of four times there is a third treatment (always discounted)
        if rand(4).zero?
          t3 = Treatment.new
          t3.visit_id = visit_id
          t3.procedure_id = proc_id.pop
          t3.successful = true
          if rand(7).zero? 
            t3.discount = 0.40
          else
            t3.discount = 0.10
          end
          t3.save!
        end
      end
    end
    puts "Treatment count: #{Treatment.all.count}"

    # Step 9: _some_ visits have medicine administered
    all_visit_ids.each do |visit_id|
      if rand(3).zero?
        proc_id = procedure_ids.shuffle
        dosage = Dosage.new
        dosage.visit_id = visit_id
        # find appropriate meds for this animal
        this_animal = Visit.find(visit_id).animal.id
        approp_meds = AnimalMedicine.for_animal(this_animal).to_a.shuffle
        dosage.medicine_id = approp_meds.pop.medicine_id
        dosage.units_given = [25, 50, 100].sample
        dosage.discount = 0.00
        dosage.save!
        # a quarter of the time there is a second medicine given
        if rand(4).zero?
          d2 = Dosage.new
          d2.visit_id = visit_id
          d2.medicine_id = approp_meds.pop.medicine_id
          d2.units_given = [25, 50, 100].sample
          if rand(4).zero? 
            d2.discount = 0.25
          else
            d2.discount = 0.00
          end
          d2.save!
        end
      end
    end 
    puts "Dosage count: #{Dosage.all.count}"
    puts "All done."       
  end
end
