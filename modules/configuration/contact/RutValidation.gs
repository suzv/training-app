package acmelab.ta.webservice.contact
 uses acmelab.ta.webservice.contact.rutvalidaor.rut.RutsPortService
 uses acmelab.ta.webservice.contact.rutvalidaor.rut.elements.GetRutValidationRequest

class RutValidation {

  public static function validate(rut : String) : Boolean{

    var service = new RutsPortService()
    var request = new GetRutValidationRequest()
    request.Rut = rut
    var response = service.getRutValidation(request)
    return response.getIsValid()
  }

}