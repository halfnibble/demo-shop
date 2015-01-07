// Only perform on CreateView
if (IMPORT_RECORD_PAGE == 'create') {
    $(document).ready(function() {
        $('#id_product').change(function(){
            var selected_value = $(this).val();
            /* record_list contains an object with the following format:
             * {
             *     id: partner_sku,
             *     ...,
             * }
             */
            var partner_sku = record_list[selected_value];
            $('#id_partner_sku').val(partner_sku);
        });
    });
}

// Only perform on UpdateView
if (IMPORT_RECORD_PAGE == 'update') {

}

// Perform for both CreateView and UpdateView
if (IMPORT_RECORD_PAGE == 'create' || IMPORT_RECORD_PAGE == 'update') {
    /* Update the calculated values in the Create/Update view
     * Note: these are approximataions
     */
    $(document).ready(function() {
        // Used in set_export_price
        $('#id_standard_export_price').change(function(){
            var standard_export_price = $(this).val();
            import_calc.set_export_price(standard_export_price);
        });
        $('#id_partner_discount').change(function(){
            var partner_discount = $(this).val();
            // Update other values.
            import_calc.set_export_price(null, partner_discount);
        });
        $('#id_origin_currency').change(function(){
            var origin_currency = $(this).val();
            // Update other values.
            import_calc.set_export_price(null, null, origin_currency);
        });

        // Used in set_import_price
        $('#id_currency_factor').change(function(){
            var currency_factor = $(this).val();
            // Update other values.
            import_calc.set_import_price(null, currency_factor);
            import_calc.set_msrp(null, currency_factor);
        });

        // Used in set_tariff_cost
        $('#id_tariff_rate').change(function(){
            var tariff_rate = $(this).val();
            // Update other values.
            import_calc.set_tariff_cost(null, tariff_rate);
        });

        // Used in set_shipping_cost
        $('#id__shipping_cost').change(function(){
            var _shipping_cost = $(this).val();
            // Update other values.
            import_calc.set_shipping_cost(_shipping_cost);
        });
        $('#id_shipping_weight').change(function(){
            var shipping_weight = $(this).val();
            // Update other values.
            import_calc.set_shipping_cost(null, shipping_weight);
        });
        $('#id_shipping_factor').change(function(){
            var shipping_factor = $(this).val();
            // Update other values.
            import_calc.set_shipping_cost(null, null, shipping_factor);
        });

        // Used in MSRP
        $('#id_origin_msrp').change(function(){
            var origin_msrp = $(this).val();
            // Update other values.
            import_calc.set_msrp(origin_msrp);
        });

        // Used in Wholesale pricing calculations
        $('#').change(function(){
            var new_value = $(this).val();
            // Update other values.
        });

        // Used in Retail pricing calculations
        $('#').change(function(){
            var new_value = $(this).val();
            // Update other values.
        });

        $('#').change(function(){
            var new_value = $(this).val();
            // Update other values.
        });
    });
}

var import_calc = (function() {
    function M(money) {
        // Round and format money values 00.00
        return parseFloat(money).toFixed(2);
    }

    function R(rate) {
        // Round and format rates 0.000
        return parseFloat(rate).toFixed(3);
    }

    function set_export_price(standard_export_price, partner_discount, origin_currency) {
        if (!standard_export_price)
            var standard_export_price = $('#id_standard_export_price').val();
        if (!partner_discount)
            var partner_discount = $('#id_partner_discount').val();
        if (!origin_currency)
            var origin_currency = $('#id_origin_currency').val();
        var export_price = this.M(
            standard_export_price * ((100.0  - partner_discount) / 100.00)
        );
        // Update fields
        $('#id_export_price').html(export_price);
        $('.export_currency').html(origin_currency);
        // Call methods dependent on export_price
        this.set_import_price(export_price);
    }

    function set_import_price(export_price, currency_factor) {
        if (!export_price)
            var export_price = parseFloat($('#id_export_price').html());
        if (!currency_factor)
            var currency_factor = $('#id_currency_factor').val();
        var import_price = this.M(
            export_price * currency_factor
        );
        // Update fields
        $('#id_import_price').html(import_price);
        // Call methods dependent on import_price
        this.set_tariff_cost(import_price);
        this.set_cost_price(import_price);
    }

    function set_tariff_cost(import_price, tariff_rate) {
        if (!import_price)
            var import_price = parseFloat($('#id_import_price').html());
        if (!tariff_rate)
            var tariff_rate = $('#id_tariff_rate').val();
        var tariff_cost = this.M(
            import_price * (tariff_rate / 100.0)
        );
        // Update fields
        $('#id_tariff_cost').html(tariff_cost);
        // Call methods dependent on tariff_cost
        this.set_import_cost(tariff_cost);
    }

    function set_shipping_cost( _shipping_cost, shipping_weight, shipping_factor) {
        if (!_shipping_cost)
            var _shipping_cost = $('#id__shipping_cost').val();

        if (_shipping_cost.length < 1) {
            if (!shipping_weight)
                var shipping_weight = $('#id_shipping_weight').val();
            if (!shipping_factor)
                var shipping_factor = $('#id_shipping_factor').val();

            var shipping_cost = this.M(
                shipping_weight * shipping_factor
            );
        } else {
            var shipping_cost = this.M(_shipping_cost);
        }
        // Update fields
        $('#id_shipping_cost').html(shipping_cost);
        // Call methods dependent on shipping_cost
        this.set_import_cost(null, shipping_cost);
    }

    function set_import_cost(tariff_cost, shipping_cost) {
        if (!tariff_cost)
            var tariff_cost = parseFloat($('#id_tariff_cost').html());
        if (!shipping_cost)
            var shipping_cost = parseFloat($('#id_shipping_cost').html());
        var import_cost = this.M(
            (+tariff_cost) + (+shipping_cost) // (+) necessary to avoid concatenation!
        );
        // Update fields
        $('#id_import_cost').html(import_cost);
        // Call methods dependent on import_cost
        this.set_cost_price(null, import_cost);
    }

    function set_cost_price(import_price, import_cost) {
        if (!import_price)
            var import_price = parseFloat($('#id_import_price').html());
        if (!import_cost)
            var import_cost = parseFloat($('#id_import_cost').html());
        var cost_price = this.M(
            (+import_price) + (+import_cost)  // (+) necessary to avoid concatenation!
        );
        // Update fields
        $('#id_cost_price').html(cost_price);
        // Call methods dependent on cost_price

    }

    function set_msrp(origin_msrp, currency_factor) {
        if (!origin_msrp)
            var origin_msrp = $('#id_origin_msrp').val();
        if (!currency_factor)
            var currency_factor = $('#id_currency_factor').val();
        var msrp = this.M(
            origin_msrp * currency_factor
        );
        // Update fields
        $('#id_msrp').html(msrp);
        // Call methods dependent on msrp
    }

    function set_wholesale_data(cost_price, target_wholesale_gpm) {  // _price_reseller?

    }

    function set_retail_data(target_wholesale_price, target_retail_factor, msrp) {

    }

    function set_reseller_data() {

    }

    return {
        M: M,
        R: R,
        set_export_price: set_export_price,
        set_import_price: set_import_price,
        set_tariff_cost: set_tariff_cost,
        set_shipping_cost: set_shipping_cost,
        set_import_cost: set_import_cost,
        set_cost_price: set_cost_price,
        set_msrp: set_msrp,
        set_wholesale_data: set_wholesale_data,
        set_retail_data: set_retail_data,
        set_reseller_data: set_reseller_data
    };
})();