package trainingapp.enhancements
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
}

//PEGAR EN PCF WIDGET, TODOS LOS CAMPOS DE RUT:
//if (acmelab.ta.webservice.contact.RutValidation.validate(contact.RUT)) {if (contact.isDuplicate(contact.RUT) == false){return null} else {return "El RUT ingresado ya existe."} } else return "El RUT no es valido."