xml.instruct!
xml.model do
  xml.id @model.id
  xml.name @model.name
  xml.regression @model.regression
  xml.user @model.user.name
  xml.created_at @model.created_at
  xml.validation do
    xml.summary_uri "http://" + request.host + request.port_string + "/models/" + @model.id.to_s + '/' + @model.validation_summary_filename
    xml.details_uri "http://" + request.host + request.port_string + "/models/" + @model.id.to_s + '/' + @model.validation_loo_filename
  end
end
