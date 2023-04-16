-- adding a comment
SELECT
  rtrim(CTHV_Catalog_Master_Consolidated.Item_full_Desc_local),
  upper(rtrim(CTHV_Title_Master.Title)),
  case
when dbo.CTHV_configuration_CDS.Format_Cd ='BD' and  CTHV_Catalog_Master_Consolidated.Item_full_Desc_local like '%3D%' then 'BD3D'
when dbo.CTHV_configuration_CDS.Format_Cd ='BD' and  CTHV_Catalog_Master_Consolidated.Item_full_Desc_local not like '%3D%' Then 'BD'
when dbo.CTHV_configuration_CDS.Format_Cd ='DVD' Then 'DVD'
else dbo.CTHV_configuration_CDS.configuration_type_code
end,
  CTHV_Titles_Sony_MPM_Attributes.Retailer_exclusivity,
  CTHV_Titles_Sony_MPM_Attributes.Local_Title,
  CTHV_Titles_Sony_MPM_Attributes.Licensor,
  CTHV_Titles_Sony_MPM_Attributes.GPMS_sell_off_date,
  CTHV_Titles_Sony_MPM_Attributes.GPMS_expiry_date,
  rtrim(CTHV_Catalog_Master_Consolidated.BRAND_PRISM),
  CTHV_Catalog_Master_Consolidated.Local_Acquisition_ID,
  CTHV_Catalog_Master_Consolidated.Item_Earliest_Release_Dt,
  dbo.CTHV_configuration_CDS.configuration_type_code,
  rtrim(CTHV_Catalog_Master_Consolidated.UPC_Cd),
  CASE 
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' then 'Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '02' then 'Universal'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '18' then 'Universal Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '24' then 'Paramount'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '25' then 'Transmission'
ELSE Null
END,
  CTHV_Title_Master.GENRE,
  CASE 
WHEN ( CTHV_Catalog_Master_Consolidated.Tape_Disc_Cnt ) is NULL
THEN cast(CTHV_Catalog_Master_Consolidated.NUMBER_OF_DISCS as INT)
ELSE CTHV_Catalog_Master_Consolidated.Tape_Disc_Cnt                               END,
  CTHV_Catalog_Master_Consolidated.PACKAGING,
  CTHV_Title_Master.BoxOffice,
  Case when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='A'  then 'Active'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='B'  then 'Backorder'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='C'  then 'Cutout'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='D'  then 'Deleted'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd='I'  then 'Inactive'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='N'  then 'Not Complete'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='P'  then 'Preorder'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='L'  then 'LIMITED' 
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='S'  then 'SUBLICENSE'
else CTHV_Catalog_Master_Consolidated.Item_Status_Cd
end
,
  CASE 
WHEN ( CTHV_Catalog_Master_Consolidated.Rating_Ind ) is NULL
THEN CTHV_Catalog_Master_Consolidated.RATING
ELSE CTHV_Catalog_Master_Consolidated.Rating_Ind                               END,
  V_CTHV_catalog_master_consolidated_current.PriceList
,
  case CTHV_Catalog_Master_Consolidated.Item_Orig_Studio_Cd
when 'SPE' then 'Sony Pictures'
when 'DIS' then 'Disney'
when 'M' then 'MGM'
else 'Other'
End,
  V_CTHV_catalog_master_consolidated_current.Item_SKU_Nbr,
  Case when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='A'  then 'Active'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='B'  then 'Backorder'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='C'  then 'Cutout'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='D'  then 'Deleted'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='I'  then 'Inactive'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='N'  then 'Not Complete'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='P'  then 'Preorder'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='L'  then 'LIMITED'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='S'  then 'SUBLICENSE'
else V_CTHV_catalog_master_consolidated_current.Item_Status_Cd 
end,
  TIME_LINK.calendar_year,
  V_CTHV_catalog_master_consolidated_current.PriceList,
  CASE 
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  = 'STUDIOCANAL'  then 'STUDIOCANAL'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  = 'HOYTS'  then 'STUDIOCANAL'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  <> 'STUDIOCANAL'  then 'Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  <> 'HOYTS'  then 'Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  is null then 'Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group in ('02','18') then 'Universal'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '24' then 'Paramount'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '25' then 'Transmission'

ELSE Null
END,
  Sum(dbo.CTHV_POS_SALES.Sales_Qty)
FROM
  dbo.CTHV_configuration_CDS INNER JOIN CTHV_Catalog_Master_Consolidated ON (dbo.CTHV_configuration_CDS.Format_Cd=CTHV_Catalog_Master_Consolidated.Format_Cd)
   INNER JOIN dbo.CTHV_POS_SALES ON (dbo.CTHV_POS_SALES.idcatalog=CTHV_Catalog_Master_Consolidated.idCatalogMaster)
   INNER JOIN CTHV.dbo.CTHV_sales_group_CDS ON (dbo.CTHV_POS_SALES.sales_group_code=CTHV.dbo.CTHV_sales_group_CDS.sales_group_code and dbo.CTHV_POS_SALES.Territory=CTHV.dbo.CTHV_sales_group_CDS.Territory)
   INNER JOIN dbo.CTHV_Sales_date_table  TIME_LINK ON (TIME_LINK.iddatetimes=dbo.CTHV_POS_SALES.iddatetimes)
   INNER JOIN dbo.CTHV_Territory ON (dbo.CTHV_Territory.Territrory=dbo.CTHV_POS_SALES.Territory)
   INNER JOIN CTHV_Title_Catalog_Link ON (CTHV_Catalog_Master_Consolidated.idcatalogmaster=CTHV_Title_Catalog_Link.idcatalogmaster)
   INNER JOIN CTHV_Title_Master ON (CTHV_Title_Catalog_Link.Territory=CTHV_Title_Master.Territory and CTHV_Title_Catalog_Link.idtitlemaster=CTHV_Title_Master.idTitleMaster)
   INNER JOIN CTHV_Titles_Sony_MPM_Attributes ON (CTHV_Titles_Sony_MPM_Attributes.Item_Sku_Nbr=CTHV_Catalog_Master_Consolidated.Item_SKU_Nbr and CTHV_Titles_Sony_MPM_Attributes.Territory=CTHV_Catalog_Master_Consolidated.Territory)
   INNER JOIN V_CTHV_catalog_master_consolidated_current ON (CTHV_Catalog_Master_Consolidated.Item_SKU_Nbr=V_CTHV_catalog_master_consolidated_current.Item_SKU_Nbr and CTHV_Catalog_Master_Consolidated.Territory=V_CTHV_catalog_master_consolidated_current.Territory)
  
WHERE
( ( CTHV_Catalog_Master_Consolidated.consolidated_sku is not null or (CTHV_Catalog_Master_Consolidated.Distributor='SONY PICTURES' and CTHV_Catalog_Master_Consolidated.territory='NZ')  )  )
  AND  ( ( CTHV_Catalog_Master_Consolidated.consolidated_sku is not null or (CTHV_Catalog_Master_Consolidated.Distributor='SONY PICTURES' and CTHV_Catalog_Master_Consolidated.territory='NZ')  )  )
  AND  ( ( CTHV_Catalog_Master_Consolidated.consolidated_sku is not null or (CTHV_Catalog_Master_Consolidated.Distributor='SONY PICTURES' and CTHV_Catalog_Master_Consolidated.territory='NZ')  )  )
  AND  ( ( CTHV_Catalog_Master_Consolidated.consolidated_sku is not null or (CTHV_Catalog_Master_Consolidated.Distributor='SONY PICTURES' and CTHV_Catalog_Master_Consolidated.territory='NZ')  )  )
  AND  ( ( CTHV_Catalog_Master_Consolidated.consolidated_sku is not null or (CTHV_Catalog_Master_Consolidated.Distributor='SONY PICTURES' and CTHV_Catalog_Master_Consolidated.territory='NZ')  )  )
  AND  ( ( CTHV_Catalog_Master_Consolidated.consolidated_sku is not null or (CTHV_Catalog_Master_Consolidated.Distributor='SONY PICTURES' and CTHV_Catalog_Master_Consolidated.territory='NZ')  )  )
  AND  ( ( CTHV.dbo.CTHV_sales_group_CDS.sales_group_code )  NOT IN  ('AB', 'AL', 'TR', 'TY', 'HX', 'WH','AZ','CT','EY','KO','ZO','NI')  )
  AND  
  (
   ( ( dbo.CTHV_Territory.Territrory )='AUS' AND ( CTHV_Catalog_Master_Consolidated.Territory )='AUS'  )
   AND
   V_CTHV_catalog_master_consolidated_current.Item_SKU_Nbr  NOT LIKE  '%R'
  AND  (( CTHV_Catalog_Master_Consolidated.consolidated_sku is not null or (CTHV_Catalog_Master_Consolidated.Distributor='SONY PICTURES' and CTHV_Catalog_Master_Consolidated.territory='NZ')  ))
   AND
   rtrim(CTHV_Catalog_Master_Consolidated.Item_full_Desc_local)  NOT LIKE  '%RENTAL%'
   AND
   dbo.CTHV_configuration_CDS.configuration_type_code  IN  ( 'BLU','DVD','UHD'  )
   AND
   V_CTHV_catalog_master_consolidated_current.Item_SKU_Nbr  NOT LIKE  '1%'
  AND  (( CTHV_Catalog_Master_Consolidated.consolidated_sku is not null or (CTHV_Catalog_Master_Consolidated.Distributor='SONY PICTURES' and CTHV_Catalog_Master_Consolidated.territory='NZ')  ))
   AND
   TIME_LINK.calendar_year  IN  (2018)
   AND
   case CTHV_Catalog_Master_Consolidated.Product_Group when 77 then 'Rental Sku'
when 78 then 'Retail/Sell Thru Sku'
when 82 then 'Rental Sku'
when 81 then 'Retail/Sell Thru Sku'
else 'Undifined'
end  <>  'Rental Sku'
   AND
   CASE 
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' then 'Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '02' then 'Universal'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '18' then 'Universal Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '24' then 'Paramount'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '25' then 'Transmission'
ELSE Null
END  IN  ( 'Paramount','Sony','Transmission','Universal','Universal Sony'  )
   AND
   CTHV_Catalog_Master_Consolidated.Item_Earliest_Release_Dt  <  '01/01/2099 00:0:0'
   AND
   V_CTHV_catalog_master_consolidated_current.Item_SKU_Nbr  NOT IN  ( 'DM51179','DM54535','DM55284','BDP10477','DEZY54612','BDP10479','DM51826','DTINA38547','DTINA34657','BDP10451','DM52347','DMP02856','DM10735','DM33534','DOT54816','D33049','DM13020','DM11350','DOT19040','DOT10644','DOT13206','DOTP05827','DOTP03659','DOTP03658','DOTP09795','DOTP09794','DOTP09793','BDP10455','DM52911','DM56989','DTIN22651','DOT61844','DM53037','STR33849','DTIN44954','DMP02775','DM51840','DOTP03710','DOTP03761','DTIN10799','DOTX10799','DP08340','DM13562','DM52853','DPS06874','BD20471','DM51041','DM41896','DM51230','DM26025','DTINA44821','DPJB07560','DSN55777','DM10845','DOTW10045','DP10261','DP10262','DP10243','DM53854','DTINA11606','DM10725','DMP02893','DM51116','DM57045','BDP10482','DM53072','BDP10452','DM53612','DMP03966','DM12836','BDP10463','DM32479','DOT10006','BDP10484','DPTIN02050','DM38350','DMP3813','DMP03286','DM41705','DM28922','BD11459','DP09119','DP09118','DP08359','DOTP08359','BDP10472','DM53196','BD28060','DM52756','BDP10458','DM53261','DM12125','BDP10474','BDP10473','DTIN10010','BDP10475','DM51360','BD21739','DPS02678','DM53082','D50666','DTINA46545','DM51743','DM52198','DM41818','DM51183','BD43422','DM52324','BD11956','BDP10457','DM13654','DMP3801','DM57012','DM13497','DM52889','DM11480','BDP10459','DM38529','DM13653','DM51191','DM53161','DM55157','DTIN51195','DM12450','DM55303','DM55108','BDP10480','DM51675','DM11026','DM53422','DM54970','DTIN10001','DM52435','DM30503','DM11635','BDP10466','DM11315','D35014','DTINA32708','DMT55317','DM55317','DPTIN02089','DM11025','DM52486','DM11160','DM52713','BDP10465','BD47404','DOT17606','DOT10131','DM52432','DP07618','DM54004','DM51131','DMP03222','DM52920','BDP10478','DOTP08508','BDP10476','DP09084'  )
  AND  (( CTHV_Catalog_Master_Consolidated.consolidated_sku is not null or (CTHV_Catalog_Master_Consolidated.Distributor='SONY PICTURES' and CTHV_Catalog_Master_Consolidated.territory='NZ')  ))
  )
GROUP BY
  rtrim(CTHV_Catalog_Master_Consolidated.Item_full_Desc_local), 
  upper(rtrim(CTHV_Title_Master.Title)), 
  case
when dbo.CTHV_configuration_CDS.Format_Cd ='BD' and  CTHV_Catalog_Master_Consolidated.Item_full_Desc_local like '%3D%' then 'BD3D'
when dbo.CTHV_configuration_CDS.Format_Cd ='BD' and  CTHV_Catalog_Master_Consolidated.Item_full_Desc_local not like '%3D%' Then 'BD'
when dbo.CTHV_configuration_CDS.Format_Cd ='DVD' Then 'DVD'
else dbo.CTHV_configuration_CDS.configuration_type_code
end, 
  CTHV_Titles_Sony_MPM_Attributes.Retailer_exclusivity, 
  CTHV_Titles_Sony_MPM_Attributes.Local_Title, 
  CTHV_Titles_Sony_MPM_Attributes.Licensor, 
  CTHV_Titles_Sony_MPM_Attributes.GPMS_sell_off_date, 
  CTHV_Titles_Sony_MPM_Attributes.GPMS_expiry_date, 
  rtrim(CTHV_Catalog_Master_Consolidated.BRAND_PRISM), 
  CTHV_Catalog_Master_Consolidated.Local_Acquisition_ID, 
  CTHV_Catalog_Master_Consolidated.Item_Earliest_Release_Dt, 
  dbo.CTHV_configuration_CDS.configuration_type_code, 
  rtrim(CTHV_Catalog_Master_Consolidated.UPC_Cd), 
  CASE 
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' then 'Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '02' then 'Universal'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '18' then 'Universal Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '24' then 'Paramount'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '25' then 'Transmission'
ELSE Null
END, 
  CTHV_Title_Master.GENRE, 
  CASE 
WHEN ( CTHV_Catalog_Master_Consolidated.Tape_Disc_Cnt ) is NULL
THEN cast(CTHV_Catalog_Master_Consolidated.NUMBER_OF_DISCS as INT)
ELSE CTHV_Catalog_Master_Consolidated.Tape_Disc_Cnt                               END, 
  CTHV_Catalog_Master_Consolidated.PACKAGING, 
  CTHV_Title_Master.BoxOffice, 
  Case when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='A'  then 'Active'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='B'  then 'Backorder'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='C'  then 'Cutout'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='D'  then 'Deleted'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd='I'  then 'Inactive'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='N'  then 'Not Complete'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='P'  then 'Preorder'
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='L'  then 'LIMITED' 
when CTHV_Catalog_Master_Consolidated.Item_Status_Cd ='S'  then 'SUBLICENSE'
else CTHV_Catalog_Master_Consolidated.Item_Status_Cd
end
, 
  CASE 
WHEN ( CTHV_Catalog_Master_Consolidated.Rating_Ind ) is NULL
THEN CTHV_Catalog_Master_Consolidated.RATING
ELSE CTHV_Catalog_Master_Consolidated.Rating_Ind                               END, 
  V_CTHV_catalog_master_consolidated_current.PriceList
, 
  case CTHV_Catalog_Master_Consolidated.Item_Orig_Studio_Cd
when 'SPE' then 'Sony Pictures'
when 'DIS' then 'Disney'
when 'M' then 'MGM'
else 'Other'
End, 
  V_CTHV_catalog_master_consolidated_current.Item_SKU_Nbr, 
  Case when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='A'  then 'Active'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='B'  then 'Backorder'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='C'  then 'Cutout'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='D'  then 'Deleted'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='I'  then 'Inactive'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='N'  then 'Not Complete'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='P'  then 'Preorder'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='L'  then 'LIMITED'
when V_CTHV_catalog_master_consolidated_current.Item_Status_Cd ='S'  then 'SUBLICENSE'
else V_CTHV_catalog_master_consolidated_current.Item_Status_Cd 
end, 
  TIME_LINK.calendar_year, 
  V_CTHV_catalog_master_consolidated_current.PriceList, 
  CASE 
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  = 'STUDIOCANAL'  then 'STUDIOCANAL'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  = 'HOYTS'  then 'STUDIOCANAL'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  <> 'STUDIOCANAL'  then 'Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  <> 'HOYTS'  then 'Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '01' and CTHV_Catalog_Master_Consolidated.BRAND  is null then 'Sony'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group in ('02','18') then 'Universal'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '24' then 'Paramount'
WHEN CTHV_Catalog_Master_Consolidated.Label_Group = '25' then 'Transmission'

ELSE Null
END
