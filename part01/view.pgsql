create view modelled.current_production_processes as 
    select 
        p.*
    from modelled.fact_production_processes p
    where p."production day" = CURRENT_DATE
    and p."production process status" = 'Active'
