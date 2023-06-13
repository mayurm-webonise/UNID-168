--Customer_details

select
  v.id as 'vessel_id',
  c.name as 'company_name',
  v.imo,
  v.name as 'vessel_name',
  f.name,
  v.flag_iso,
  s.name as 'scale_name',
  v.status as 'vessel_status',
  v.active as 'Active_on_portal',
  dfdpv.delivered_at as 'Initial delivery',
  'Gregory' as 'Account manager' ,
  'UMM / MS+' as 'Vessel Comms Responsibility' ,
  'Grigoris.kotsinonos@ummsc.com;Supply@chartworld.gr;MarinaAthanasiadou@chartworld.gr;
  jules@ummsc.com;paulq@ummsc.com;maria.platara@ummsc.com;panagiota.tsakona@ummsc.com;
  faidon.chrysostalis@ummsc.com;' 
  as 'Vessel Comms CC', 
  'OK' as 'user_created',
  u.email ,
  'OK' as 'Usage submission info', 
  sc.expires_at as 'Certificate_expiry_date',
  DATEDIFF(cov.end_date,cov.start_date) as 'Time to Certificate Expiry',
  max(ch.effective_date) as 'Last Comms',
  u.email as 'vessel_email',
  'ex X-Press Assurance/ex PRIORITY/ex JAL SASVATA' as 'MS+ Notes',
  'X' as 'vessel_inactive' 
from vessels v  
left join communications_history ch on ch.vessel_id =v.id
left join companies c on v.company_id =c.id
left join users u on u.company_id =c.id 
left join scale_certificates sc on sc.vessel_id =v.id 
left join fleet f on v.fleet_id =f.id 
left join scales s on v.scale_id =s.id 
left join dash_first_delivery_per_vessel dfdpv on dfdpv .vessel_id =v.id
left join contract_of_vessel cov on cov.vessel_id =v.id;


--Recertification

select 
   v.id as vessel_id,
   c.name,
   v.imo,
   v.name as vessel_name,
   scl.expires_at as certificate_expiry,
   'Stavroula' as Manager ,
   '2022-01-18' as 'Sent to UMM' ,
   '2022-01-26' as 'Vessels Reply' ,
   '2022-02-08' as 'Suggested requisition created',
   '2022-02-18' as 'certificate uploaded',
   'Send enrollment reminder 2 months prior the expiration date (certificate from previous vendor)' as 
   'Issues/Notes' ,
   'in process' as 'Recertification Status' ,
   'X' as 'vessel_left_check' 
from vessels v 
left join companies c  on v.company_id =c.id
left join scale_certificates_log scl  on v.id =scl.vessel_id;


--Inventory_Reviews_Attributes

Select
v.id as 'vessel_id',
c.name as 'company_name',
v.imo,
v.name as 'vessel_name',
'Antzela / Sylia'as 'Manager',
'08-Dec-2022' as 'Sent_to_UMM',
'review reminder sent 5-Jan' as 'Issues Notes',
'x' as 'Vessel_Left_Check'
from vessels v 
left join companies c  on v.company_id=c.id;


--Outstanding_Requests_Attributes

Select
 v.id as 'vessel_id',
 c.name as 'company_name',
 v.imo,
 v.name as 'vessel_name',
 ch.comments as 'type',
 'Stavroula' as 'Urgent',
 ch.effective_date  as 'Date received', 
 'x/OK' as 'Status', 
 'included in recertification form' as 'comment/blocker',
 scl.created_by as 'Processed_by', 
 ch.time_creation  as 'Processed Date',  
 '6 month replenishment' as 'Notes',
 sc.expires_at,
 'X' as 'Vessel_Left'
from vessels v 
 left join companies c on v.company_id=c.id
 left join scale_certificates_log scl on v.id=scl.vessel_id 
 left join communications_history ch  on v.id=ch.vessel_id
 left join scale_certificates sc on sc.vessel_id=v.id;


 --Oxygen

Select
   v.id as 'vessel_id',
   c.name as 'company_name',
   v.imo,
   v.name as 'vessel_name',
   '2021-12-28' as 'Date_Recieved', 
   'X' as 'Status',  
   'Contact Info pending / MOX40 Hydro & Fill dates pending' as 'Comments/Blocker', 
   'Tereza/blank' as 'Processd by',  
   '2022-01-28' as 'Processed Date',  
   '2022-11-08' as 'Reminder_sent', 
   'seaspan' as 'Vessel_left_Check'
from vessels v 
left join companies c  on v.company_id =c.id;


--Scale_Help


Select
  s.name as scale_code,
  s.origin,
  c.name as company_name,
  'Added items, joined scale IDs' as 'Notes' 
from scales s 
left join vessels v  on s.id=v.scale_id
left join companies c  on v.company_id  =c.id 
 group by s.name,s.origin,c.name;


 --DB_data_sheet

Select
  v.id as 'vessel_id',
  v.imo,
  v.name as 'vessel_name',
  v.flag_iso,
  s.name as 'scale_name',
  c.name as 'company_name',
  v.status as 'vessel_status',
  f.name as 'fleet_name',
  cov.start_date as 'contract_start_date',
  cov.end_date as 'contract_end_date',
  dfdpv.delivered_at  as 'Initial_delivery',
  sc.expires_at as 'certificate',
  max(ch.effective_date) as 'Last_comm_date',
  v.active as 'Active_on_portal',
  '' as ''
from vessels v 
left join companies c on v.company_id =c.id 
left join scales s  on v.scale_id =s.id 
left join fleet f on f.id=v.fleet_id 
left join contract_of_vessel cov on v.id =cov.vessel_id 
left join dash_first_delivery_per_vessel dfdpv on v.id=dfdpv.vessel_id  
left join scale_certificates sc on v.id =sc.vessel_id 
left join communications_history ch  on v.id=ch.vessel_id
group by v.id;