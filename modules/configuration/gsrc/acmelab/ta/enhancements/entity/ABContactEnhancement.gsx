package acmelab.ta.enhancements.entity

enhancement ABContactEnhancement : ABContact {

  property get CalculoPrima() : String
  {
    if (this.Coverable.CoverableCost != null) {
      //FACTORES QUE AFECTAN EL VALOR DE LA POLIZA
      var costoInicial = this.Coverable.CoverableCost as Double
      var creditScore = 505 //acmelab.ta.webservice.contact.CreditScoreWS.setContactCreditScore(this.RUT)
      var totalPrima : double

      //1- SE CALCULA COVERAGES SOBRE COSTO INICIAL
      //SE VERIFICA SI ES AUTO O DWELLING
      if (this.Coverable.TypeCoverable == CoverableType.TC_AUTO) {
        if (this.Poliza.CoverageExt.DamageAgainstOthers == true) {
          costoInicial = costoInicial + (costoInicial * 0.02) // 2%
        }

        if (this.Poliza.CoverageExt.Crushes == true) {
          costoInicial = costoInicial + (costoInicial * 0.028) // 2,8%
        }

        if (this.Poliza.CoverageExt.Accidents == true) {
          costoInicial = costoInicial + (costoInicial * 0.0125) // 1,25%
        }

        if (this.Poliza.CoverageExt.WinterTires == true) {
          costoInicial = costoInicial + (costoInicial * 0.012) // 1,20%
        }

        if (this.Poliza.CoverageExt.ElectricalSystems == true) {
          costoInicial = costoInicial + (costoInicial * 0.05) // 5%
        }
      }

      //CASO COVERABLE DWELLING
      if (this.Coverable.TypeCoverable == CoverableType.TC_DWELLING) {
        if (this.Poliza.CoverageExt.Base == true) {
          costoInicial = costoInicial + (costoInicial * 0.0085) // 0,85%
        }

        if (this.Poliza.CoverageExt.PersonalBelongings == true) {
          costoInicial = costoInicial + (costoInicial * 0.0075) // 0,75%
        }

        if (this.Poliza.CoverageExt.Earthquakes == true) {
          costoInicial = costoInicial + (costoInicial * 0.02) // 2%
        }

        if (this.Poliza.CoverageExt.Fires == true) {
          costoInicial = costoInicial + (costoInicial * 0.015) // 1,5%
        }

        if (this.Poliza.CoverageExt.Flooding == true) {
          costoInicial = costoInicial + (costoInicial * 0.0025) // 0,25%
        }
      }
      //VALOR AL CUAL SE LE APLICAN LOS SIGUIENTE FACTORES
      totalPrima = costoInicial

      //2- SE CALCULA EL TOTAL CALCULADO CON LOS COVERAGES Y SE APLICA EL FACTOR DE CREDIT SCORE
      if (creditScore <= 300)
      {
        return "POLIZA RECHAZADA POR CREDIT SCORE MUY BAJO"
      }

      if (creditScore > 300 && creditScore <= 500)
      {
        totalPrima = totalPrima + (totalPrima * 0.0075) // 0,75%
      }

      if (creditScore > 500 && creditScore <= 700)
      {
        totalPrima = totalPrima + (totalPrima * 0.0025) // 0,25%
      }

      if (creditScore > 700 && creditScore <= 999)
      {
        totalPrima = totalPrima + (totalPrima * -0.0025) // -0,25%
      }

      //3- SE APLICA FACTOR DE EDAD SI ES PERSONA
      if (this typeis ABPerson) {
        var edadContacto = (this as ABPerson).AgeReal.toInt()

        if (edadContacto >= 18 && edadContacto <= 25)
        {
          totalPrima = totalPrima + (totalPrima * 0.01) // 1%
        }

        if (edadContacto > 25 && edadContacto <= 40)
        {
          totalPrima = totalPrima + (totalPrima * -0.005) // -0,5%
        }

        if (edadContacto > 40 && edadContacto <= 70)
        {
          totalPrima = totalPrima + (totalPrima * 0.0075) // 0,75%
        }

        if (edadContacto > 70)
        {
          totalPrima = totalPrima + (totalPrima * 0.015) // 1,5%
        }
      }

      return totalPrima as String
    }
    return "Unknown"
  }

  function activarPoliza() : void {
    if (this.Poliza.Activada != true) {
      this.Poliza.Activada = true
    }
  }

  function desactivarPoliza() : void {
    if (this.Poliza.Activada == true) {
      this.Poliza.Activada = false
    }
  }
}