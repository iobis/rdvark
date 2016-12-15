library(rdvark)
library(finch)
library(yaml)

# Broedvogel dataset, tests "allowed"

archive <- dwca_read("broedvogel_data.zip", read = TRUE)
data <- archive$data$occurrence.txt
config <- yaml.load_file("broedvogel_settings.yaml")
errors <- validate(data, config)
expect_equal(nrow(errors), 7)

# conditional tests:
# https://github.com/inbo/data-validator/blob/master/examples/inboveg/dwc-measurementorfact.yaml

# expected output:
#{u'INBO:BROEDVOGELATLAS:AH:00000368:00070': {'language': ['unallowed value e'],
#  'nomenclaturalCode': ['unallowed value ICNN']},
#u'INBO:BROEDVOGELATLAS:AH:00000477:00070': {'rightsHolder': ['unallowed value INO']},
#u'INBO:BROEDVOGELATLAS:AH:00000512:00070': {'language': ['unallowed value nl']},
#u'INBO:BROEDVOGELATLAS:AH:00000763:00070': {'nomenclaturalCode': ['unallowed value ICZ'],
#  'rightsHolder': ['unallowed value INTRO']},
#u'INBO:BROEDVOGELATLAS:AH:00000905:00070': {'language': ['unallowed value den']}}
