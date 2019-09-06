package acmelab.ta.webservice.contact
uses acmelab.ta.webservice.contact.rutvalidator.contacts.ContactsPortService
uses acmelab.ta.webservice.contact.rutvalidator.contacts.elements.GetContactRequest

class CreditScoreWS {

  public static function setContactCreditScore(rut: String) : int{
    var service = new ContactsPortService()
    var request = new GetContactRequest()
    request.Id =  rut
    var response = service.getContact(request)
    return response.Hc
  }

}