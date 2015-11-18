require 'csv'

namespace :import do
  desc "Importing mining wastes owners"
  task owners: :environment do
    filename = File.join Rails.root, 'db/CATASTRO_RELAVES_CHILE_02_11_2015.csv'
    CSV.foreach(filename, headers: true) do |row|
      puts row["NOMBRE_EMP"]
      if row["NOMBRE_EMP"] === "" || row["NOMBRE_EMP"].nil? || row["NOMBRE_EMP"] === "S/I" 
        owner = Owner.find_by_name "EPV"
        if !owner
          owner = Owner.create name: "EPV"
        end
      else
        owner = Owner.find_by_name row["NOMBRE_EMP"]
        if !owner
          owner = Owner.create name: row["NOMBRE_EMP"]
        end
      end
    end
  end

  desc "Importing provinces from csv document"
  task provinces: :environment do
    filename = File.join Rails.root, 'db/CATASTRO_RELAVES_CHILE_02_11_2015.csv'
    CSV.foreach(filename, headers: true) do |row|
      puts row["PROVINCIA"]
      if !row["PROVINCIA"].nil?
        region = Region.find_by_region_number row["REGIÓN_IN"]
        province = Province.find_by_name row["PROVINCIA"]
        if province.nil?
          province = Province.create name: row["PROVINCIA"], region_id: region.id
        end
      end
    end
  end

  desc "Importing communes from csv document"
  task communes: :environment do
    filename = File.join Rails.root, 'db/CATASTRO_RELAVES_CHILE_02_11_2015.csv'
    CSV.foreach(filename, headers: true) do |row|
      puts row["COMUNA_INS"]
      if !row["COMUNA_INS"].nil?
        province = Province.find_by_name row["PROVINCIA"]
        commune = Commune.find_by_name row["COMUNA_INS"]
        if commune.nil?
          commune = Commune.create name: row["COMUNA_INS"], province_id: province.id
        end
      end
    end
  end
end 