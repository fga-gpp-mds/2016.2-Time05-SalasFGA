function Booking() {

    this.check_empty = function(value) {
        if(value.length == 0) {
           return false;
        }

        else {
            return true;
        }
    }

    this.check_name = function(value) {
        if(value.length == 0) {
           return false;
        }

        else {
            return true;
        }
    }

    this.addError = function(element) {
        if(!element.hasClass("has-error")) {
            element.addClass("has-error");
        }
    }

    this.addSpan = function(element, text) {
        if(document.getElementsByClassName("help-block").length > 0) {
            $('.help-block').remove();
        }

        element.after("<span class='help-block'>" + text + "</span>");
    }

    this.check_name_element = function(element) {
        var name = element.val();

        if(!this.check_name(name)) {
            this.addError(element.parent());
            this.addSpan(element, "Booking name cannot be blank");

            return false;
        }

        return true;
    }

    this.check_date = function(element) {
        var date = element.val();

        if(!this.check_empty(date)) {
            this.addError(element.parent());
            this.addSpan(element, "Date cannot be blank");

            return false;
        }

        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1;

        var yyyy = today.getFullYear();
        if(dd<10) { dd='0'+dd }
        if(mm<10) { mm='0'+mm }

        var today = mm+'/'+dd+'/'+yyyy;

        if(date < today) {
            this.addError(element.parent());
            this.addSpan(element, "Date has to be bigger or equal to today's date");

            return false;
        }

        return true;
    }

    this.check_interval_date = function (element1, element2) {
        var startDate = element1.val();
        var endDate = element2.val();

        if (endDate < startDate) {
            this.addError(element2.parent());
            this.addSpan(element2, "End date has to be after start date");

            return false;
        }

        return true;
    }

    this.check_time = function(element1, element2) {
        var beginTime = parseInt(element1.val());
        var endTime = parseInt(element2.val());

        if(beginTime >= endTime) {
            this.addError(element2.parent());
            this.addSpan(element2, "End time has to be after begin time");

            return false;
        }

        return true;
    }

    this.post_form = function(building, place, name, start_date, end_date, start_hour, end_hour, week_days) {
        $.post("/booking/newbooking/", {
            building: building,
            place: place,
            name: name,
            start_date: start_date,
            end_date: end_date,
            start_hour: start_hour,
            end_hour: end_hour,
            week_days: week_days
        })

        .always(function() {
            $("#page1").hide();
            $("#page2").hide();
            $("#page3").hide();
            $("#page4").hide();
            $("#page5").show();
            breadcrumbsadd(4);
        })

        .done(function() {
            $('#result-booking').html('\
                <p>Booking successfully done!</p>\
            ');

            $('#result-booking > p').css('text-align', 'center')
                                    .css('color', '#2C3E50')
                                    .css('font-weight', 'bold');
            $('#finish-form').remove();
        })

        .fail(function() {
            $('#result-booking').html('\
                <p>An error has occurred!</p>\
            ');
            $('#result-booking > p').css('text-align', 'center')
                                    .css('color', '#C9302C')
                                    .css('font-weight', 'bold');
            $('#finish-form').remove();
        });
    }
}