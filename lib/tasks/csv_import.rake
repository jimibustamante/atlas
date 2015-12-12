#encoding: utf-8 
require 'csv'

namespace :import do
  desc "Importing provinces from csv document"
  task provinces: :environment do
    filename = File.join Rails.root, 'db/CATASTRO_RELAVES_CHILE_02_11_2015.csv'
    CSV.foreach(filename, headers: true) do |row|
      puts row["PROVINCIA"]
      puts row["REGIÓN_IN"]
      if row["PROVINCIA"]
        region = Region.find_by_region_number row["REGIÓN_IN"]
        province = Province.find_by_name row["PROVINCIA"]
        if province.nil? && region
          puts "NUEVO"
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
      puts row["PROVINCIA"]
      if row["COMUNA_INS"] && row["PROVINCIA"]
        province = Province.find_by_name row["PROVINCIA"]
        commune = Commune.find_by_name row["COMUNA_INS"]
        if commune.nil? && province
          commune = Commune.create name: row["COMUNA_INS"], province_id: province.id
        end
      end
    end
  end

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

  desc "Importing labors from csv document"
  task labors: :environment do
    filename = File.join Rails.root, 'db/CATASTRO_RELAVES_CHILE_02_11_2015.csv'
    CSV.foreach(filename, headers: true) do |row|
      puts row["NOMBRE_FAE"]
      if !row["NOMBRE_FAE"].nil?
        labor = Labor.find_by_name row["NOMBRE_FAE"]
        owner = Owner.find_by_name row["NOMBRE_EMP"]
        commune = Commune.find_by_name row["COMUNA_INS"] 
        if !owner.nil? && !commune.nil?
          if labor.nil? 
            labor = Labor.create! name: row["NOMBRE_FAE"], owner_id: owner.id, commune_id: commune.id
          else
            labor.update_attributes! name: row["NOMBRE_FAE"], owner_id: owner.id, commune_id: commune.id
          end
        end
      end
    end
  end

  desc "Importing communes from csv document"
  task mining_wastes: :environment do
    filename = File.join Rails.root, 'db/CATASTRO_RELAVES_CHILE_02_11_2015.csv'
    CSV.foreach(filename, headers: true) do |row|
      puts row["NOMBRE_INS"]
      labor = Labor.find_by_name row["NOMBRE_FAE"]
      if !labor.nil? && !row["NORTE_GEO"].nil? && !row["ESTE_GEO"].nil?
        mining_waste = MiningWaste.find_by_sernageomin_id row["OBJECTID"]
        if mining_waste.nil?
          mining_waste = MiningWaste.create! sernageomin_id: row["OBJECTID"], 
            labor_id: labor.id,
            status: row["ESTADO_INS"],
            lon: row["ESTE_GEO"],
            lat: row["NORTE_GEO"],
            utm_north: row["UTM_NORTE"],
            utm_east: row["UTM_ESTE"],
            height: row["COTA"],
            name: row["NOMBRE_INS"],
            mining_waste_type: row["TIPO_INSTA"],
            partial_volume: row["Vol_Parcial_1"],
            total_volume: row["Vol_Total_1"],
            partial_ton: row["Ton_Parcial_1"],
            total_ton: row["Ton_Total_1"],
            resolution_date: row["FECHA_RE"],
            resolution_number: row["RES"],
            resolution_closure_date: row["FECHA_RES_PDC"],
            resolution_closure_number: row["RES_PDC"],
            region_id: labor.commune.province.region.id
        else
          mining_waste.update_attributes! sernageomin_id: row["OBJECTID"], 
            labor_id: labor.id,
            status: row["ESTADO_INS"], 
            lon: row["ESTE_GEO"], 
            lat: row["NORTE_GEO"],
            utm_north: row["UTM_NORTE"],
            utm_east: row["UTM_ESTE"],
            height: row["COTA"],
            name: row["NOMBRE_INS"],
            mining_waste_type: row["TIPO_INSTA"],
            partial_volume: row["Vol_Parcial_1"],
            total_volume: row["Vol_Total_1"],
            partial_ton: row["Ton_Parcial_1"],
            total_ton: row["Ton_Total_1"],
            resolution_date: row["FECHA_RE"],
            resolution_number: row["RES"],
            resolution_closure_date: row["FECHA_RES_PDC"],
            resolution_closure_number: row["RES_PDC"],
            region_id: labor.commune.province.region.id
        end
      end
    end
  end
  task :all => [:provinces, :communes, :owners, :labors, :mining_wastes]
end 