package acmelab.ta.enhancements.entity

uses gw.api.system.database.SequenceUtil
uses gw.api.util.DisplayableException
uses gw.api.util.LocationUtil

uses java.math.BigDecimal

enhancement ABContactEnhancement : ABContact {

  property get CalculoPrima() : String
  {
    if (this.Coverable.CoverableCost != null) {
      //FACTORES QUE AFECTAN EL VALOR DE LA POLIZA
      var costoInicial = this.Coverable.CoverableCost as double
      var creditScore = this.CreditScore
      var totalPrimaCoverage : double = 0
      var totalPrimaCalculada : double = 0
      var totalPrimaCreditScore : double = 0

      //1- SE CALCULA COVERAGES SOBRE COSTO INICIAL
      //SE VERIFICA SI ES AUTO O DWELLING
      if (this.Coverable.TypeCoverable == CoverableType.TC_AUTO) {
        if (this.Poliza.CoverageExt.DamageAgainstOthers == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.02) // 2%
        }

        if (this.Poliza.CoverageExt.Crushes == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.028) // 2,8%
        }

        if (this.Poliza.CoverageExt.Accidents == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.0125) // 1,25%
        }

        if (this.Poliza.CoverageExt.WinterTires == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.012) // 1,20%
        }

        if (this.Poliza.CoverageExt.ElectricalSystems == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.05) // 5%
        }
      }

      //CASO COVERABLE DWELLING
      if (this.Coverable.TypeCoverable == CoverableType.TC_DWELLING) {
        if (this.Poliza.CoverageExt.Base == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.0085) // 0,85%
        }

        if (this.Poliza.CoverageExt.PersonalBelongings == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.0075) // 0,75%
        }

        if (this.Poliza.CoverageExt.Earthquakes == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.02) // 2%
        }

        if (this.Poliza.CoverageExt.Fires == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.015) // 1,5%
        }

        if (this.Poliza.CoverageExt.Flooding == true) {
          totalPrimaCoverage = totalPrimaCoverage + (costoInicial * 0.0025) // 0,25%
        }
      }


      //2- SE CALCULA EL TOTAL CALCULADO CON LOS COVERAGES Y SE APLICA EL FACTOR DE CREDIT SCORE
      if (creditScore <= 300)
      {
        return "POLIZA RECHAZADA POR CREDIT SCORE MUY BAJO"
      }

      if (creditScore > 300 && creditScore <= 500)
      {
        totalPrimaCreditScore = totalPrimaCreditScore + (totalPrimaCoverage * 0.0075) // 0,75%
      }

      if (creditScore > 500 && creditScore <= 700)
      {
        totalPrimaCreditScore = totalPrimaCreditScore + (totalPrimaCoverage * 0.0025) // 0,25%
      }

      if (creditScore > 700 && creditScore <= 999)
      {
        totalPrimaCreditScore = totalPrimaCreditScore + (totalPrimaCoverage * -0.0025) // -0,25%
      }


      //3- SE APLICA FACTOR DE EDAD SI ES PERSONA
      if (this typeis ABPerson) {
        var edadContacto = (this as ABPerson).AgeReal.toInt()

        if (edadContacto >= 18 && edadContacto <= 25)
        {
          totalPrimaCalculada = totalPrimaCalculada + (totalPrimaCoverage * 0.01) // 1%
        }

        if (edadContacto > 25 && edadContacto <= 40)
        {
          totalPrimaCalculada = totalPrimaCalculada + (totalPrimaCoverage * -0.005) // -0,5%
        }

        if (edadContacto > 40 && edadContacto <= 70)
        {
          totalPrimaCalculada = totalPrimaCalculada + (totalPrimaCoverage * 0.0075) // 0,75%
        }

        if (edadContacto > 70)
        {
          totalPrimaCalculada = totalPrimaCalculada + (totalPrimaCoverage * 0.015) // 1,5%
        }

        var primaTotalPersona = totalPrimaCoverage + totalPrimaCalculada + totalPrimaCreditScore

        return primaTotalPersona as Integer as String
      }
      //if (this typeis ABCompany)
      //{

      var primaTotalCompany = totalPrimaCoverage + totalPrimaCreditScore

      return primaTotalCompany as Integer as String
      //}
    }
    return "El valor no se puede calcular"
  }



  function activarPoliza() : void {
    this.Poliza.Activada = true
  }

  function activarPolizaVisible(anABContact : ABContact) : boolean{
        if (anABContact.Coverable.Brand != null && anABContact.Coverable.Color != null && anABContact.Coverable.Year != null && anABContact.Coverable.Model != null && anABContact.Coverable.WinterTires != null && anABContact.Coverable.LicensePlate != null)
        {
          return true
        }
        else if(anABContact.Coverable.ConstructionMaterial != null && anABContact.Coverable.HeatingType != null && anABContact.Coverable.Meters != null && anABContact.Coverable.RoofType != null && anABContact.Coverable.OccupationType != null)
        {
          return true
        }
        else
        {
          return false
        }
  }

  function desactivarPolizaVisible(anABContact : ABContact) : boolean
  {
    if (anABContact.Poliza.Activada != true || anABContact.Coverable.CoverableCost == null || anABContact.Poliza.Prima == 0)
    {
      return false
    }
    else
    {
      return true
    }
  }

  function desactivarPoliza() : void {
      this.Poliza.Activada = false
  }

  function eliminarCoverable() : void {
    this.Coverable.TypeCoverable = null
    this.Coverable.CoverableCost = null
  }

  function mostrarLabel(variable: boolean, location: LocationUtil) : void{
    location.addRequestScopedInfoMessage("Prueba")
  }

  property get CreditScoreDetail() : String {
    if (this.CreditScore >= 0 && this.CreditScore <= 300 ){
      return "Se rechaza la póliza"
    }
    if (this.CreditScore >= 301 && this.CreditScore <= 500 ){
      return "0.75%"
    }
    if (this.CreditScore >= 501 && this.CreditScore <= 700 ){
      return "0.25%"
    }
    if (this.CreditScore >= 701 && this.CreditScore <= 999 ){
      return "-0.25%"
    }
    return "Error"
  }


}