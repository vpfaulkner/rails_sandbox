module SandboxesHelper
  def data_type_to_dropdown(type)
    case type
    when 'integer'               then 'number_field'
    when 'float', 'decimal'      then 'text_field'
    when 'time'                  then 'time_select'
    when 'datetime', 'timestamp' then 'datetime_select'
    when 'date'                  then 'date_select'
    when 'text'                  then 'text_area'
    when 'boolean'               then 'check_box'
    else 'text_field'
    end
  end
end
