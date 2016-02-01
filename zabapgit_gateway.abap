START-OF-SELECTION.
  PERFORM run.


*  DATA g_field TYPE REF TO data.
*  CREATE DATA g_field TYPE ('/IWBEP/I_SBO_PR').

FORM display USING pt_nodes TYPE /iwbep/t_sbdm_nodes
                   pv_level TYPE i.

  DATA: li_prop TYPE REF TO /iwbep/if_sbod_property.


  LOOP AT pt_nodes ASSIGNING FIELD-SYMBOL(<li_node>).
    DO pv_level TIMES.
      WRITE space.
    ENDDO.
    WRITE: <li_node>->get_name( ), <li_node>->ms_node_type-node_type.

    IF <li_node>->ms_node_type-node_type = 'PROP'.
      li_prop ?= <li_node>.
      WRITE: / li_prop->get_maxlength( ).
    ENDIF.

* class /IWBEP/CL_SBOD_PROPERTY_PS
* table /IWBEP/I_SBO_PR
    WRITE /.

    DATA(lt_nodes) = <li_node>->get_children( ).
    DATA(lv_level) = pv_level + 1.
    PERFORM display USING lt_nodes lv_level.
  ENDLOOP.

ENDFORM.

FORM run.

  DATA ls_sel_project TYPE LINE OF /iwbep/if_sbdm_manager=>ty_t_range_prjct_name.
  DATA lt_sel_project TYPE /iwbep/if_sbdm_manager=>ty_t_range_prjct_name.
  DATA lo_manager TYPE REF TO /iwbep/if_sbdm_manager.
  DATA lt_projects TYPE /iwbep/t_sbdm_projects.


  ls_sel_project-sign = 'I'.
  ls_sel_project-option = 'EQ'.
  ls_sel_project-low = 'ZS'.
  INSERT ls_sel_project INTO TABLE lt_sel_project.

  lo_manager = /iwbep/cl_sbdm=>get_manager( ).
  lt_projects = lo_manager->find_projects( lt_sel_project ).

  LOOP AT lt_projects ASSIGNING FIELD-SYMBOL(<lo_project>).
    DATA(lt_nodes) = <lo_project>->get_children( ).
    PERFORM display USING lt_nodes 0.
  ENDLOOP.

ENDFORM.