class FeatureDatabase

  def initialize(model)
    `#{RAILS_ROOT}/lib/lazar/linfrag -s #{model.structure_file} -a #{RAILS_ROOT}/lib/lazar/data/elements.txt > #{model.feature_file}`
  end

end
