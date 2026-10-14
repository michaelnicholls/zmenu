CLASS zcl_menu DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_menu IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA lt_data TYPE TABLE OF zmn_menu.
    TRY.
        IF io_request->is_data_requested(  ).

          DATA(lo_filter) = io_request->get_filter(  ).
          DATA(lt_params) = io_request->get_parameters(  ).
          DATA(lt_sort_elements)  = io_request->get_sort_elements(  ).

          DATA(lo_paging) = io_request->get_paging(  ).
          " entries are a tcode, plus description, separated by a ','
          DATA(tcodes) = VALUE string_table(
           ( `ST22,Short dumps` )
           ( `AL08,Logged on users` )
           ( `SM66,All work processes` )
           ).
          LOOP AT tcodes INTO DATA(tcode).
            SPLIT tcode AT ',' INTO DATA(code) DATA(description).
            DATA(linenumber) = lines(  lt_data ).
            linenumber += 1.
            lt_data = VALUE #( BASE lt_data
           (  line = linenumber tcode = code description = description url = '#Shell-startGUI?sap-ui2-tcode=' && code ) ).
          ENDLOOP.




          io_response->set_data( lt_data ).
          io_response->set_total_number_of_records( lines( lt_data ) ).
        ENDIF.
      CATCH cx_root.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
