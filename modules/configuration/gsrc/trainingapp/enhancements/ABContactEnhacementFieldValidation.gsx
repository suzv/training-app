package trainingapp.enhancements
uses aQute.libg.sax.filters.ElementSelectionFilter
uses gw.api.database.Query
uses gw.api.database.Relop

enhancement ABContactEnhacementFieldValidation: ABContact {

  function  isDuplicate(rut: String): Boolean{
    rut = rut.toLowerCase()
    var queryObj = Query.make(ABContact)
    queryObj.compare(ABContact#RUT, Relop.Equals, rut)
    var resultObj = queryObj.select()

    rut = rut.toUpperCase()
    var queryObj2 = Query.make(ABContact)
    queryObj2.compare(ABContact#RUT, Relop.Equals, rut)
    var resultObj2 = queryObj2.select()

    if(resultObj.isEmpty() && resultObj2.isEmpty()){
      return false
    }
    else{
      return true
    }
  }

  function isUnderAge(age: Date): Boolean{
    //  age.DaysSince < 6570
    if(age.daysBetween(Date.CurrentDate) > 6570)return false
    else return true
  }

  public static function GenerateTaxID(anABContact: ABContact): String{
    anABContact.TaxID = "11-2345678"
    return (anABContact.TaxID)

  }

  public static function GenerateCreditScore(anABContact: ABContact): Integer{
    anABContact.CreditScore = acmelab.ta.webservice.contact.CreditScoreWS.setContactCreditScore(anABContact.RUT)
    return (anABContact.CreditScore)
  }

}

//PEGAR EN PCF WIDGET, TODOS LOS CAMPOS DE RUT:
//if (acmelab.ta.webservice.contact.RutValidation.validate(contact.RUT)) {if (contact.isDuplicate(contact.RUT) == false){return null} else {return "El RUT ingresado ya existe."} } else return "El RUT no es valido."