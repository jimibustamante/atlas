require 'csv'

namespace :import do
  desc "Importing mining wastes from csv document"
  task owners: :environment do
    filename = File.join Rails.root, 'db/CATASTRO_RELAVES_CHILE_02_11_2015.csv'
    CSV.foreach(filename, headers: true) do |row|
      puts row["NOMBRE_EMP"]
      if row["NOMBRE_EMP"] != "" && !row["NOMBRE_EMP"].nil?
        owner = Owner.find_by_name row["NOMBRE_EMP"] 
        if !owner
          owner = Owner.create name: row["NOMBRE_EMP"]
        end
      end
    end

  end
end 