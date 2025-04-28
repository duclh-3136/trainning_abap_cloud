@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'value input help carrier id'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z_I_CARRIER_VH as select from /DMO/I_Carrier
{
    @EndUserText.label: 'Carrier ID Duclh'
    key AirlineID as CarrierID,
    @EndUserText.label: 'Carrier Name Duclh'
    Name as CarrierName
}
