class FeatureDatabase

  def initialize(model)
    `#{RAILS_ROOT}/lib/lazar-core/linfrag -s #{model.structure_file} -a #{RAILS_ROOT}/lib/lazar-core/data/elements.txt > #{model.feature_file}`
  end

end
