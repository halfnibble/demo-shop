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

        $('#id_related_tariff').change(function(){
            var id = $(this).val();
            // Update tariff fields
            if (id) {
                $('#id_tariff_code').val(tariff_list[id].tariff_code);
                $('#id_tariff_rate').val(tariff_list[id].tariff_rate);
            }
            // Update other values
            import_calc.set_tariff_cost(null, tariff_list[id].tariff_rate);         
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
        $('#id_target_wholesale_gpm').change(function(){
            var target_wholesale_gpm = $(this).val();
            // Update other values.
            import_calc.set_wholesale_data(null, target_wholesale_gpm);
        });
        $('#id__price_reseller').change(function(){
            var manual_wholesale_price = $(this).val();
            // Update other values.
            import_calc.set_wholesale_data(null, null, manual_wholesale_price);
        });

        // Used in Retail pricing calculations
        $('#id_target_retail_factor').change(function(){
            var target_retail_factor = $(this).val();
            // Update other values.
            import_calc.set_retail_data(null, target_retail_factor);
        });
        $('#id__price_retail').change(function(){
            var manual_price_retail = $(this).val();
            // Update other values.
            import_calc.set_retail_data(null, null, null, manual_price_retail);
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
        this.set_wholesale_data(cost_price);
        this.set_retail_data(null, null, null, null, cost_price);

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
        this.set_retail_data(null, null, msrp);
    }

    function set_wholesale_data(cost_price, target_wholesale_gpm, manual_wholesale_price) {  // _price_reseller?
        if (!cost_price)
            var cost_price = parseFloat($('#id_cost_price').html());
        if (!target_wholesale_gpm)
            var target_wholesale_gpm = $('#id_target_wholesale_gpm').val();
        if (!manual_wholesale_price)
            var manual_wholesale_price = $('#id__price_reseller').val();

        var target_wholesale_price = this.M(
            cost_price * (100.0 + (+target_wholesale_gpm)) / 100.0 // (+) necessary to avoid concatenation!
        );
        var wholesale_price = (
            manual_wholesale_price.length > 0 ? manual_wholesale_price : this.M(
                Math.ceil(target_wholesale_price * 10.0) / 10.0
            )
        );
        var wholesale_profit = this.M(
            wholesale_price - cost_price
        );
        var wholesale_gpm = this.R(
            wholesale_profit / cost_price * 100.0
        );
        // Update fields
        $('#id_target_wholesale_price').html(target_wholesale_price);
        $('#id_price_reseller, .price_reseller').html(wholesale_price);
        $('#id_wholesale_profit').html(wholesale_profit);
        $('#id_wholesale_gpm').html(wholesale_gpm);
        // Call methods dependent on wholesale_data
        this.set_retail_data(target_wholesale_price);
        this.set_reseller_data(null, wholesale_price);
    }

    function set_retail_data(target_wholesale_price, target_retail_factor, msrp, manual_price_retail, cost_price) {
        if (!target_wholesale_price)
            var target_wholesale_price = parseFloat($('#id_target_wholesale_price').html());
        if (!target_retail_factor)
            var target_retail_factor = $('#id_target_retail_factor').val();
        if (!msrp)
            var msrp = parseFloat($('#id_msrp').html());
        if (!manual_price_retail)
            var manual_price_retail = $('#id__price_retail').val();
        if (!cost_price)
            var cost_price = parseFloat($('#id_cost_price').html());

        var implied_msrp = this.M(
            target_wholesale_price * target_retail_factor
        );
        var msrp_delta = this.M(
            implied_msrp - msrp
        );
        var msrp_markup = this.R(
            msrp_delta / msrp * 100.0
        );
        var price_retail = (
            manual_price_retail.length > 0 ? manual_price_retail : this.M(
                Math.ceil(implied_msrp) - 0.01
            )
        );
        var retail_profit = this.M(
            price_retail - cost_price
        );
        var retail_gpm = this.R(
            retail_profit / cost_price * 100.0
        );
        // Update fields
        $('#id_implied_msrp').html(implied_msrp);
        $('#id_msrp_delta').html(msrp_delta);
        $('#id_msrp_markup').html(msrp_markup);
        $('#id_price_retail').html(price_retail);
        $('#id_retail_profit').html(retail_profit);
        $('#id_retail_gpm').html(retail_gpm);
        // Call methods dependent on retail_data
        this.set_reseller_data(price_retail);

    }

    function set_reseller_data(price_retail, wholesale_price) {
        if (!price_retail)
            var price_retail = parseFloat($('#id_price_retail').html());
        if (!wholesale_price)
            var wholesale_price = parseFloat($('#id_price_reseller').html());
        var reseller_profit = this.M(
            price_retail - wholesale_price
        );
        var reseller_gpm = this.R(
            reseller_profit / wholesale_price * 100.0
        );
        // Update fields
        $('#id_reseller_profit').html(reseller_profit);
        $('#id_reseller_gpm').html(reseller_gpm);
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