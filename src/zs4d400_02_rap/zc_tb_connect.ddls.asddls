@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_TB_CONNECT
  provider contract transactional_query
  as projection on ZDM_TB_CONNECT
{
  key Uuid,
  @Consumption.valueHelpDefinition: [{ entity: {
    name: 'Z_I_CARRIER_VH',
    element: 'CarrierID'
  } }]
  Carrid,
  Connid,
  AirportFrom,
  CityFrom,
  CountryFrom,
  AirportTo,
  CityTo,
  CountryTo,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
