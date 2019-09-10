package acmelab.ta.enhancements.entity

uses gw.api.system.database.SequenceUtil

enhancement PolicyEnhacement : Policy_Ext {



  public static function GeneratePolicyID(anABContact: ABContact): Integer{
    if (anABContact.Poliza.Numero == null && anABContact.Poliza.FechaEfectiva != null && anABContact.Poliza.Activada){
      var id = SequenceUtil.next(1000, "Sencuencia Policy ID") as Integer
       anABContact.Poliza.Numero = id
      return anABContact.Poliza.Numero
    }
    else{
      return anABContact.Poliza.Numero
    }
  }
}
