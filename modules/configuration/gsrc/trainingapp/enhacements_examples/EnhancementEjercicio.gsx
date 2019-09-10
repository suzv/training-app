package trainingapp.enhacements_examples

uses typekey.ABContact

enhancement EnhancementEjercicio : ABPerson {

  property get AgeInDays(): int{

    var edadEnDias = this.getDateOfBirth()
    //print(edadEnDias)
    return (edadEnDias.DaysSince)

  }
}
