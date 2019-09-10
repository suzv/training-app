package acmelab.ta.enhancements.entity

uses gw.api.util.DateUtil
uses org.apache.poi.ss.formula.functions.Today
uses org.joda.time.DateTime

enhancement ABPersonEnhancement : ABPerson {

  property get AgeReal() : String{
    if (this.DateOfBirth != null) {
      var fechaNacimiento = this.DateOfBirth as Date
      var fechaHoy = DateUtil.currentDate()

      var edadTot = DateUtil.daysBetween(fechaNacimiento, fechaHoy)
      var edadTotal = Math.round(edadTot/365)
      return edadTotal as String
    }
    else
    {
      return "Unknown"
    }
  }

  function AgeInDays() : int {
    if (this.DateOfBirth != null) {
      var fechaNac = this.DateOfBirth as Date
      var fechaActual = DateUtil.currentDate() as Date

      var fechaDias = DateUtil.daysBetween(fechaNac, fechaActual)

      return fechaDias as int
    }
    return 0
  }

  property get AgeFactor() :String {
    if (this.AgeReal >= "18" && this.AgeReal <= "25" ){
      return "1%"
    }
    if (this.AgeReal >= "26" && this.AgeReal <= "40" ){
      return "-0.5%"
    }
    if (this.AgeReal>= "41" && this.AgeReal <= "70" ){
      return "0.75%"
    }
    if (this.AgeReal >= "71" ){
      return "1.5%"
    }
    return ""
  }


}
