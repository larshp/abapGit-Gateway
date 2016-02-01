
CLASS lcl_object_iwpr DEFINITION INHERITING FROM lcl_objects_super FINAL.

  PUBLIC SECTION.
    INTERFACES lif_object.

  PRIVATE SECTION.
    METHODS:
      find_project
        RETURNING VALUE(ri_project) TYPE REF TO /iwbep/if_sbdm_project
        RAISING   lcx_not_found
                  /iwbep/cx_sbcm_exception,
      walk
        IMPORTING it_nodes TYPE /iwbep/t_sbdm_nodes
                  iv_level TYPE i
        RAISING   /iwbep/cx_sbcm_exception.

ENDCLASS.

CLASS lcl_object_iwpr IMPLEMENTATION.

  METHOD walk.

    DATA: li_prop TYPE REF TO /iwbep/if_sbod_property.


    LOOP AT it_nodes ASSIGNING FIELD-SYMBOL(<li_node>).
      DO iv_level TIMES.
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
      DATA(lv_level) = iv_level + 1.
      walk( it_nodes = lt_nodes
               iv_level = lv_level ).
    ENDLOOP.

  ENDMETHOD.

  METHOD find_project.

    DATA: ls_sel_project TYPE LINE OF /iwbep/if_sbdm_manager=>ty_t_range_prjct_name,
          lt_sel_project TYPE /iwbep/if_sbdm_manager=>ty_t_range_prjct_name,
          lo_manager     TYPE REF TO /iwbep/if_sbdm_manager,
          lt_projects    TYPE /iwbep/t_sbdm_projects.


    ls_sel_project-sign   = 'I'.
    ls_sel_project-option = 'EQ'.
    ls_sel_project-low    = ms_item-obj_name.
    INSERT ls_sel_project INTO TABLE lt_sel_project.

    lo_manager = /iwbep/cl_sbdm=>get_manager( ).
    lt_projects = lo_manager->find_projects( lt_sel_project ).

    READ TABLE lt_projects INDEX 1 INTO ri_project.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE lcx_not_found.
    ENDIF.

  ENDMETHOD.

  METHOD lif_object~serialize.

    TRY.
        DATA(lt_nodes) = find_project( )->get_children( ).
        walk( it_nodes = lt_nodes
              iv_level = 0 ).
      CATCH lcx_not_found.
        BREAK-POINT.
      CATCH /iwbep/cx_sbcm_exception.
        BREAK-POINT.
    ENDTRY.

  ENDMETHOD.

  METHOD lif_object~deserialize.
    _raise 'todo, deserialize, IWPR'.
  ENDMETHOD.

  METHOD lif_object~delete.
    _raise 'todo, delete, IWPR'.
  ENDMETHOD.

  METHOD lif_object~exists.

    TRY.
        find_project( ).
        rv_bool = abap_true.
      CATCH /iwbep/cx_sbcm_exception.
        BREAK-POINT.
      CATCH lcx_not_found.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.

  METHOD lif_object~jump.
    _raise 'todo, jump, IWPR'.
  ENDMETHOD.

ENDCLASS.
