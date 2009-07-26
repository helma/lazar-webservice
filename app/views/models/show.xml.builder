xml.instruct!
xml.model do
  xml.id @model.id
  xml.name @model.name
  xml.regression @model.regression
  xml.user @model.user.name
  xml.created_at @model.created_at
  xml.validation do
    xml.summary_uri request.url + '/' + @model.validation_summary_filename
    xml.details_uri request.url + '/' + @model.validation_loo_filename
  end
end
