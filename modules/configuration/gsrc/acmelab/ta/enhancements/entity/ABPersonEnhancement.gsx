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
}
