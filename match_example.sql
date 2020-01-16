select *  
  from trial t cross join profile p
 where 
 /*
   Profile has desease_stage_id=2 - so add subquery to filter on it
   for desease_stage_id=null - not applicable such subquery
 */
exists (select 1 
  from trial_allow_desease_stage ads
 where ads.trial_id = t.id
   and ads.desease_stage_id = p.desease_stage_id)
/*
  Profile has biomarkers=[2,3] - so add subquery to filter on it
  Not applicable if patient profile without biomarkers
  with many_to_many next comparison will check any intersect but not guarantie that all biomarkers allowed
*/
and exists (select 1
  from trial_allow_biomarker adb
 inner join profile_biomarker pb on adb.biomarker_id = pb.biomarker_id
 where adb.trial_id = t.id
   and pb.profile_id = p.id)