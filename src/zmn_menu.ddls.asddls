@EndUserText.label: 'menu of tcodes'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_MENU'
define custom entity Zmn_Menu

{
  key line        : int4;

      @UI.lineItem: [{ position: 10, type: #WITH_URL,  url : 'url'}]
      tcode       : tcode;
      @UI.lineItem: [{ position:  20 }]
      @EndUserText.label: 'Description'
      description : abap.char(36);
      @UI.hidden: true
      url         : abap.char(255);

}
