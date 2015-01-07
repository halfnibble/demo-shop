if (IMPORT_RECORD_PAGE == 'create') {
    $(document).ready(function() {
        $('#id_product').change(function(){
            var selected_value = $(this).val();
            var partner_sku = record_list[selected_value];
            $('#id_partner_sku').val(partner_sku);
        });
    });
}