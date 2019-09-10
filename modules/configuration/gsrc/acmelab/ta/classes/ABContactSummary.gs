package acmelab.ta.classes

uses gw.api.database.Query
uses gw.api.database.Relop
uses gw.transaction.Transaction
uses trainingapp.base.QueryUtil

class ABContactSummary {

  //Variables
  var _ExternalID : int as ExternalID
  var _ContactID : String as ContactID
  var _Name : String as Name
  var _NumCheckingAccounts : int as NumCheckingAccounts

  var _AssignedUserWorkload : int as AssignedUserWorkload

/*
    //Getters y Setters
    property get ExternalID() : int{
      return this._ExternalID
    }

    property set ExternalID(newExternalID : int){
      this._ExternalID = newExternalID
    }

    property get ContactID() : String{
      return this._ContactID
    }

    property set ContactID(newContactID : String){
      this._ContactID = newContactID
    }

    property get Name() : String{
      return this._Name
    }

    property set Name(newName : String){
      this._Name = newName
    }

    property get NumCheckingAccounts() : int{
      return this._NumCheckingAccounts
    }

    property set NumCheckingAccounts(newNumCheckingAccounts : int){
      this._NumCheckingAccounts = newNumCheckingAccounts
    }
*/

  function initializeExternalID(){
    if (this._ExternalID == 0)
    {
      //Opcion 1
      //Crear array variable de 1000 posiciones, ir sumando +1 cada vez para que sean numeros consecutivos

      //Opcion 2
      //Numero Random + Numero Random = Posibilidad de que no sean valores unicos
      var randomNum = Math.random()*1002
      var randomNum2 = Math.random()*1000 + 1
      var randomNumber = randomNum + randomNum2

      this._ExternalID = (randomNumber as Integer) + 1001

      //this._ExternalID = 1001
    }
  }

  function loadSummaryData(anABContact : ABContact){

    this._ContactID = anABContact.PublicID
    this._Name = anABContact.DisplayName
    var cantAccounts = anABContact.BankAccounts.where(\elt -> elt.AccountType == BankAccountType.TC_CHECKING)
    this._NumCheckingAccounts = cantAccounts.length

    var userAsignado = anABContact.AssignedUser
    var usersDB = Query.make(ABContact)
    usersDB.compare(ABContact#AssignedUser, Relop.Equals, userAsignado)
    var usersAssignedQ = usersDB.select()

    this._AssignedUserWorkload = usersAssignedQ.Count

    //Contar cantidad de usuarios asignados al userEncontrado
    //PREGUNTAR COMO
  }

  function getConcatenatedSummary():String{
    var out = ""
    out += this._ExternalID + ", " + this._ContactID + ", " + this._Name + ", " + this._NumCheckingAccounts

    return out
  }

  function saveSummaryNote(){
    if (this._ContactID != null)
    {
      Transaction.runWithNewBundle(\bundlecito ->{
        var contactNote = new ContactNote()
        {
          :Subject = "ABContact Summary",
          :Body = "External ID: " + this._ExternalID + "\n Name: " + this._Name + "\n Number of Checking accounts: " + this._NumCheckingAccounts,
          :ContactNoteType = ContactNoteType.TC_GENERAL
          /*:IsConfidential = true,
          :ABContact = anABContactNote */
        }

        var contact = Query.make(ABContact).compare(ABContact#PublicID, Relop.Equals, this._ContactID)
        contact.select().first().addToContactNotes(contactNote)
      }, "su")
    }

/*
  //EXTRAER NUMEROS DEL PUBLIC ID

  function holi(id : String){
    var user = QueryUtil.findContact(id)
    var out = ""
    var outNum = ""
    out += user.PublicID
    outNum += out.charAt(3)
    outNum += out.charAt(4)
    outNum.toInt()
    print(outNum)
  }
  var idHoli = "ab:78"
  holi(idHoli)
*/
  }
}