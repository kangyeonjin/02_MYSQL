select
    category_code
from
    tbl_menu
group by category_code;


select
   category_code,
   orderable_status
from
    tbl_menu
group by
    category_code,orderable_status;


select menu_price,
       category_code
from
    tbl_menu
group by menu_price,
         category_code
having category_code >= 5 and category_code <= 8
order by menu_price;

