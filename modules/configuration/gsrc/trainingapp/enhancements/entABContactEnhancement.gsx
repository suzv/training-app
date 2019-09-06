package trainingapp.enhancements

uses gw.api.util.CoreFilters
uses gw.api.util.Math
uses gw.api.util.DateUtil

enhancement entABContactEnhancement : ABPerson{
  property get Edad() : String
  {
    var yearActual = DateUtil.currentDate().YearOfDate
    var fechaActual = DateUtil.currentDate()
    var genero = this.Gender
    var edadJubilacionM = 65
    var edadJubilacionF = 60
    var fechaNacimiento = this.getDateOfBirth()
    var fechaNacimientoDias = DateUtil.daysBetween(fechaActual, fechaNacimiento)
    var edadAnio = Math.roundDown(fechaNacimientoDias/365)

    if (genero.toString() != null)
    {
      if (genero.toString() == "M")
      {
        if (edadAnio >= edadJubilacionM)
        {
          return "Persona ya jubilada o en mejor vida"
        }
        else
        {
          return "Persona aun se puede jubilar, edad: " + edadAnio + ", faltan: " + (edadJubilacionM - edadAnio) + " años para jubilarse."
        }
      }

      if (genero.toString() == "F")
      {
        if (edadAnio >= edadJubilacionF)
        {
          return "Persona ya jubilada o en mejor vida"
        }
        else
        {
          return "Persona aun se puede jubilar, edad: " + edadAnio + ", faltan: " + (edadJubilacionF - edadAnio) + " años para jubilarse."
        }
      }
    }
    return "Unknown"
  }
}
