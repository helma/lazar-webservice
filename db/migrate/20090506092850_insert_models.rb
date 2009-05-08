class InsertModels < ActiveRecord::Migration
  def self.up
    YAML::load(File.open("db/migrate/data/prediction.yml")).each do |c,models|
      models.each do |e|
        regression = true 
        regression = false if e["unit"].nil?
        unless regression # disabled because of segfaults
        model_name = File.basename(e["directory"])
        model = Model.create( :regression => regression, :name => model_name)
        FileUtils.makedirs(model.data_path)
        oldpath = e["directory"].sub(/public/,"#{RAILS_ROOT}/db/migrate/") + "data"
        FileUtils.cp_r(Dir.glob("#{oldpath}/*"),model.data_path, :verbose => true, :remove_destination => true )
        end
      end
    end
  end

  def self.down
  end
end
