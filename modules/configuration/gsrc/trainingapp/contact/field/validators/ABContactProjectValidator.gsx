package trainingapp.contact.field.validators
uses  java.util.regex.Pattern;
uses jdk.management.resource.internal.TotalResourceContext
uses org.apache.tools.ant.types.resources.comparators.Reverse

enhancement ABContactProjectValidator : ABContact {
  function PassportValidator(): Boolean{
    if(this.Passport_Ext.matches("[A-z]{1}[1-9]{6}")) return true
    else return false

  }
  function RutValidator() : Boolean {

    var identification = this.RUT_Ext

    var identificationV = identification.split("-")
    var identificationVAux = identificationV[0]
    var operational: int = 2
    var totalRut: int = 0
    var anotherNumber:int = 0

    for (aloneNumber in  identificationVAux.reverse()){
      print(aloneNumber)
      anotherNumber = Integer.parseInt(aloneNumber) * operational;
      totalRut += anotherNumber;
      if (operational == 7) {
        operational = 1;
      }
      operational++;
    }


    totalRut = totalRut%11

    totalRut = 11-totalRut

    var rest = Integer.toString(totalRut)

    var verifyDigit: String

    if (rest.equals("11")) {
      verifyDigit = "0";
    }

    if (rest.equals("10")) {
      verifyDigit = "K";
    }
    else {
      verifyDigit = Integer.toString(totalRut)
    }

    if(verifyDigit.equals(identificationV[1])) return true
    else return false


  }
}
