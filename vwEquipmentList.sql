CREATE VIEW equipment.vwEquipmentList
AS
SELECT EC.[CategoryId]
      ,EC.[CategoryBusinessKey]
      ,EC.[CategoryOptimizerCode]
      ,EC.[Name] as CategoryName
      ,EC.[IsActive]
	  ,EE.[EquipmentId]
      ,EE.[EquipmentBusinessKey]
      ,EE.[EquipmentOptimizerCode]
	  ,ES.[SubcategoryId]
      ,ES.[SubcategoryBusinessKey]
      ,ES.[SubcategoryOptimizerCode]
      ,ES.[Name] as SubCategoryName
      ,ES.[Description]
	  ,EL.[LengthId]
      ,EL.[LengthBusinessKey]
      ,EL.[LengthOptimizerCode]
      ,EL.[Name]
      ,EL.[Display]
      ,EL.[Measure]
  FROM [MDMRepository].[equipment].[Category] EC
	inner join [MDMRepository].[equipment].[Equipment] EE
		on EC.CategoryId = EE.CategoryId
	inner join [MDMRepository].[equipment].[Subcategory] ES
		on EE.SubcategoryId = ES.SubcategoryId
	inner join [MDMRepository].[equipment].[Length] EL
		on EL.LengthId = EE.LengthId
GO