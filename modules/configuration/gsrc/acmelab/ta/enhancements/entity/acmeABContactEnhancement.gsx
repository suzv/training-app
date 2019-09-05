package acmelab.ta.enhancements.entity


enhancement acmeABContactEnhancement : ABContact {
/*

  property get NextCourtesyContact() : Date{
    if (this.LastCourtesyContact_Ext == null)
    {
      return null
    }
    else
    {
      var mes = this.LastCourtesyContact_Ext.addMonths(6)
      return mes
    }
  }

  function upgradeToStrategicPartner(){
    this.IsStrategicPartner_Ext = true

    if(this.CustomerRating_Ext == null)
    {
      this.setCustomerRating_Ext(25)
    }
    else
    {
      if(this.CustomerRating_Ext >= 0 || this.CustomerRating_Ext <= 989.9)
      {
        this.CustomerRating_Ext = this.CustomerRating_Ext + 10
      }
      else
      {
        if (this.CustomerRating_Ext > 989.9)
        {
          this.CustomerRating_Ext = 999.9
        }
        else
        {
          this.CustomerRating_Ext = 0
        }
      }
    }
  }
 */
}