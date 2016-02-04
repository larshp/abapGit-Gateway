INTERFACE lif_object_iwpr_handler.

  METHODS:
    serialize
      IMPORTING ii_node TYPE REF TO /iwbep/if_sbdm_node
      RAISING   /iwbep/cx_sbcm_exception.

ENDINTERFACE.

CLASS lcl_object_iwpr_collection DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS:
* todo, method signature should be generic?
      add_prop
        IMPORTING is_data TYPE /iwbep/i_sbo_pr,
      add_gena
        IMPORTING is_data TYPE /iwbep/i_sbd_ga,
      clear,
      finalize
        IMPORTING io_xml TYPE REF TO lcl_xml
        RAISING   lcx_exception.

  PRIVATE SECTION.
    CLASS-DATA:
      gt_gena TYPE TABLE OF /iwbep/i_sbd_ga,
      gt_prop TYPE TABLE OF /iwbep/i_sbo_pr.

ENDCLASS.

CLASS lcl_object_iwpr_collection IMPLEMENTATION.

  METHOD add_prop.
    APPEND is_data TO gt_prop.
  ENDMETHOD.

  METHOD add_gena.
    APPEND is_data TO gt_gena.
  ENDMETHOD.

  METHOD finalize.
* todo
    io_xml->table_add( it_table = gt_prop
                       iv_name = 'NODES_PROP' ).
    io_xml->table_add( it_table = gt_gena
                       iv_name = 'NODES_GENA' ).
  ENDMETHOD.

  METHOD clear.
    CLEAR: gt_prop,
           gt_gena.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_object_iwpr_prop DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES lif_object_iwpr_handler.

ENDCLASS.

CLASS lcl_object_iwpr_prop IMPLEMENTATION.

  METHOD lif_object_iwpr_handler~serialize.

* class /IWBEP/CL_SBOD_PROPERTY_PS
* table /IWBEP/I_SBO_PR

    DATA: ls_data TYPE /iwbep/i_sbo_pr,
          li_prop TYPE REF TO /iwbep/if_sbod_property.


    li_prop ?= ii_node.

    ls_data-node_uuid = ii_node->mv_node_guid.
    ls_data-parent_uuid = li_prop->/iwbep/if_sbdm_node~get_parent( )->mv_node_guid.
    ls_data-name = ii_node->get_name( ).
    ls_data-is_key = li_prop->is_key( ).
    ls_data-as_author = li_prop->get_as_author( ).
    ls_data-as_etag = li_prop->get_as_etag( ).
    ls_data-as_published = li_prop->get_as_published( ).
    ls_data-as_title = li_prop->get_as_title( ).
    ls_data-as_updated = li_prop->get_as_updated( ).
    ls_data-creatable = li_prop->get_creatable( ).
    ls_data-filterable = li_prop->get_filterable( ).
    ls_data-fixed_length = li_prop->get_fixedlength( ).
    ls_data-max_length = li_prop->get_maxlength( ).
    ls_data-prop_precision = li_prop->get_precision( ).
    ls_data-requires_filter = li_prop->get_requiresfilter( ).
    ls_data-scale = li_prop->get_scale( ).
    ls_data-semantics = li_prop->get_semantics( ).
    ls_data-sortable = li_prop->get_sortable( ).
*  ls_data-edm_core_type = li_prop->mv_edm_core_type.
*  ls_data-complex_type = li_prop->ms_complex_type_guid-node_uuid.
*
*  ls_data-node_uuid_ty = li_prop->ms_type-node_uuid.
*  ls_data-plugin_ty = li_prop->ms_type-type-plugin.
*  ls_data-node_type_ty = li_prop->ms_type-type-node_type.

    ls_data-updatable = li_prop->get_updatable( ).
    ls_data-deletable = li_prop->get_deletable( ).
    ls_data-is_nullable = li_prop->is_nullable( ).
    ls_data-is_unicode = li_prop->is_unicode( ).
    ls_data-is_collection = li_prop->is_collection( ).
*  ls_data-unit_prop = li_prop->ms_unit_prop_guid-node_uuid.
*  ls_data-fc_target_path = li_prop->mv_fc_target_path.
*  IF li_prop->mo_label IS BOUND.
*    ls_data-txtr = li_prop->mo_label->ms_lbl_txt_ref.
*  ENDIF.
    ls_data-abap_field = li_prop->get_abap_field( ).
    ls_data-abty = /iwbep/cl_sbod_util=>calculate_abap_type( li_prop->get_abap_type( ) ).
*  ls_data-proref = li_prop->ms_prototype.
*  ls_data-sort_order = li_prop->mv_sort_order.

**handling of undefined flag
*  ls_data-name_xu  = li_prop->ms_undefined_attr-name.
*  ls_data-is_key_xu  = li_prop->ms_undefined_attr-is_key.
    ls_data-as_author_xu = li_prop->is_as_author_undefined( ).
    ls_data-as_etag_xu = li_prop->is_as_etag_undefined( ).
    ls_data-as_published_xu = li_prop->is_as_published_undefined( ).
    ls_data-as_title_xu = li_prop->is_as_title_undefined( ).
    ls_data-as_updated_xu = li_prop->is_as_updated_undefined( ).
    ls_data-creatable_xu = li_prop->is_creatable_undefined( ).
    ls_data-filterable_xu = li_prop->is_filterable_undefined( ).
    ls_data-fixed_length_xu = li_prop->is_fixedlength_undefined( ).
    ls_data-max_length_xu = li_prop->is_maxlength_undefined( ).
    ls_data-propprecision_xu = li_prop->is_precision_undefined( ).
    ls_data-requirefilter_xu = li_prop->is_requiresfilter_undefined( ).
    ls_data-scale_xu = li_prop->is_scale_undefined( ).
    ls_data-semantics_xu = li_prop->is_semantics_undefined( ).
    ls_data-sortable_xu = li_prop->is_sortable_undefined( ).
    ls_data-type_xu = li_prop->is_type_undefined( ).

    ls_data-updatable_xu = li_prop->is_updatable_undefined( ).
    ls_data-is_nullable_xu = li_prop->is_nullable_undefined( ).
    ls_data-is_unicode_xu = li_prop->is_unicode_undefined( ).
    ls_data-unit_prop_xu = li_prop->is_unit_undefined( ).
    ls_data-fctargetpath_xu  = li_prop->is_fc_target_path_undefined( ).
    ls_data-abap_field_xu  = li_prop->is_abap_field_undefined( ).
    ls_data-deletable_xu  = li_prop->is_deletable_undefined( ).
*  ls_data-abty_xu  = li_prop->ms_undefined_attr-abty.
*  ls_data-txtr_xu  = li_prop->ms_undefined_attr-txtr.

*  ls_data-description_xu  = li_prop->ms_undefined_attr-description.
*  ls_data-prop_label_xu  = li_prop->ms_undefined_attr-prop_label.

    lcl_object_iwpr_collection=>add_prop( ls_data ).

  ENDMETHOD.

ENDCLASS.

CLASS lcl_object_iwpr_gena DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES lif_object_iwpr_handler.

ENDCLASS.

CLASS lcl_object_iwpr_gena IMPLEMENTATION.

  METHOD lif_object_iwpr_handler~serialize.

* /IWBEP/CL_SBDM_GEN_ARTIFACT_PS
* /iwbep/i_sbd_ga

    DATA: ls_data TYPE /iwbep/i_sbd_ga,
          li_gena TYPE REF TO /iwbep/if_sbdm_gen_artifact.


    li_gena ?= ii_node.

    ls_data-node_uuid    = ii_node->mv_node_guid.
    ls_data-name         = ii_node->get_name( ).
    ls_data-pgmid        = li_gena->get_tadir_data( )-pgmid.
    ls_data-trobj_type   = li_gena->get_tadir_data( )-trobj_type.
    ls_data-trobj_name   = li_gena->get_tadir_data( )-trobj_name.
    ls_data-gen_art_type = li_gena->get_type( ).
    ls_data-hash         = li_gena->get_hash( ).
    ls_data-rfc_name     = li_gena->get_rfcname( ).

    lcl_object_iwpr_collection=>add_gena( ls_data ).

  ENDMETHOD.

ENDCLASS.

CLASS lcl_object_iwpr_etyp DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES lif_object_iwpr_handler.

ENDCLASS.

CLASS lcl_object_iwpr_etyp IMPLEMENTATION.

  METHOD lif_object_iwpr_handler~serialize.
* todo
  ENDMETHOD.

ENDCLASS.

CLASS lcl_object_iwpr_serv DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES lif_object_iwpr_handler.

ENDCLASS.

CLASS lcl_object_iwpr_serv IMPLEMENTATION.

  METHOD lif_object_iwpr_handler~serialize.
* todo
  ENDMETHOD.

ENDCLASS.

CLASS lcl_object_iwpr_srmt DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES lif_object_iwpr_handler.

ENDCLASS.

CLASS lcl_object_iwpr_srmt IMPLEMENTATION.

  METHOD lif_object_iwpr_handler~serialize.
* todo
  ENDMETHOD.

ENDCLASS.

CLASS lcl_object_iwpr_modl DEFINITION FINAL.

  PUBLIC SECTION.
    INTERFACES lif_object_iwpr_handler.

ENDCLASS.

CLASS lcl_object_iwpr_modl IMPLEMENTATION.

  METHOD lif_object_iwpr_handler~serialize.
* todo
  ENDMETHOD.

ENDCLASS.

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
        RAISING   /iwbep/cx_sbcm_exception.

ENDCLASS.

CLASS lcl_object_iwpr IMPLEMENTATION.

  METHOD walk.

    DATA: lv_class   TYPE string,
          li_handler TYPE REF TO lif_object_iwpr_handler.


    LOOP AT it_nodes ASSIGNING FIELD-SYMBOL(<li_node>).

      CONCATENATE 'LCL_OBJECT_IWPR_' <li_node>->ms_node_type-node_type INTO lv_class.
      TRY.
          CREATE OBJECT li_handler TYPE (lv_class).
        CATCH cx_sy_create_object_error.
          BREAK-POINT.
      ENDTRY.

      li_handler->serialize(
        ii_node = <li_node> ).

      DATA(lt_nodes) = <li_node>->get_children( ).
      walk( lt_nodes ).
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

    DATA: lo_xml     TYPE REF TO lcl_xml,
          li_element TYPE REF TO if_ixml_element.


    TRY.
        DATA(lt_nodes) = find_project( )->get_children( ).
* todo, project top level data?

        lcl_object_iwpr_collection=>clear( ).
        walk( lt_nodes ).
        CREATE OBJECT lo_xml.
        lcl_object_iwpr_collection=>finalize( lo_xml ).
        mo_files->add_xml( lo_xml ).
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
