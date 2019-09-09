package acmelab.ta.enhancements.entity

uses gw.api.database.Query
uses gw.transaction.Transaction

uses java.math.BigDecimal

enhancement CoverageEnhancement : Coverage_Ext {

  public static function createCov(DamageAgainstOtherS : Integer, CrushesS: double, AccidentsS:double, WinterTiresS:double,
                            ElectricalSystemsS:Integer, BaseS:double, PersonalBelongingsS:double, EarthquakesS:Integer, FiresS:double,
                            FloodingS:double) {
    Transaction.runWithNewBundle(\newBundle -> {
      var cov = new Coverage_Ext() {
        :DamageAgainstOthersS = DamageAgainstOtherS,
        :CrushesS = CrushesS,
        :AccidentsS = AccidentsS,
        :WinterTiresS = WinterTiresS,
        :ElectricalSystemsS = ElectricalSystemsS,
        :BaseS = BaseS,
        :PersonalBelongingsS = PersonalBelongingsS,
        :EarthquakesS = EarthquakesS,
        :FiresS = FiresS,
        :floodingS = FloodingS
      }
    }, "su")
  }

    public static function valueOfDamagesS():Integer {
      var datos = Query.make(Coverage_Ext).select().AtMostOneRow.DamageAgainstOthersS
      return datos
    }

    public static function valueOfCrushesS():BigDecimal
    {
      var datos2 = Query.make(Coverage_Ext).select().AtMostOneRow.CrushesS
      return datos2
    }

    public static function valueOfAccidentsS():BigDecimal {
      var datos3 = Query.make(Coverage_Ext).select().AtMostOneRow.AccidentsS
      return datos3
    }

    public static function valueOfWinterTiresS():BigDecimal {
      var datos4 = Query.make(Coverage_Ext).select().AtMostOneRow.WinterTiresS
      return datos4
    }

    public static function valueOfElectricalSystemsS():Integer {
      var datos5 = Query.make(Coverage_Ext).select().AtMostOneRow.ElectricalSystemsS
      return datos5
    }

    public static function valueOfBaseS():BigDecimal {
      var datos6 = Query.make(Coverage_Ext).select().AtMostOneRow.BaseS
      return datos6
    }

    public static function valueOfPersonalBelongingsS():BigDecimal {
      var datos7 = Query.make(Coverage_Ext).select().AtMostOneRow.PersonalBelongingsS
      return datos7
    }

    public static function valueOfEarthquakesS():Integer {
      var datos8 = Query.make(Coverage_Ext).select().AtMostOneRow.EarthquakesS
      return datos8
    }

    public static function valueOfFiresS():BigDecimal {
      var datos9 = Query.make(Coverage_Ext).select().AtMostOneRow.FiresS
      return datos9
    }

    public static function valueOfFloodingS():BigDecimal {
      var datos10 = Query.make(Coverage_Ext).select().AtMostOneRow.floodingS
      return datos10
    }
}