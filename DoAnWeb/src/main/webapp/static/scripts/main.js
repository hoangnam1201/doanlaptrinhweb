$(document).ready(function () {
    $('.single-carousel').slick({
        infinite: false,
        autoplay: true,
        autoplaySpeed: 3000,
    });
    $('.category-carousel').slick({
        infinite: false,
        slidesToShow: 5,
        rows: 2,
        responsive: [
            {
                breakpoint: 960,
                settings: {
                    slidesToShow: 4,
                    slidesToScroll: 3
                }
            },
            {
                breakpoint: 720,
                settings: {
                    slidesToShow: 3,
                    slidesToScroll: 2
                }
            },
            {
                breakpoint: 600,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 1
                }
            },
            {
                breakpoint: 420,
                settings: {
                    slidesToShow: 1
                }
            }
        ]
    })
    $('.multiple-carousel').slick({
        infinite: false,
        slidesToShow: 4,
        slidesToScroll: 3,
        responsive: [
            {
                breakpoint: 1100,
                settings: {
                    slidesToShow: 3
                }
            },
            {
                breakpoint: 820,
                settings: {
                    slidesToShow: 2,
                    slidesToScroll: 2
                }
            },
            {
                breakpoint: 640,
                settings: {
                    variableWidth: true,
                    slidesToShow: 1,
                    slidesToScroll: 1
                }
            }
        ]
    });
    $('#rating-form').submit(e => {
        e.preventDefault();
        var frm = $('#rating-form');
        var button = $(`#${e.target.id} button`);
        button.attr('disabled', true);
        $.ajax({
            type: "POST",
            url: frm.attr('action'),
            data: frm.serialize(),
            success: () => {
                alert("OK");
                location.reload();
            },
            error: () => {
                alert("Error");
                button.attr('disabled', false);
                return false;
            }
        })
    });
});

var quillOptions = {
    theme: 'snow',
    modules: {
        toolbar: [
            ['bold', 'italic', 'underline'],
            [{'list': 'ordered'}, {'list': 'bullet'}]
        ]
    }
};

var editor = new Quill("#quill", quillOptions);

$('#cat-select').change(e => {
    let catId = e.target.value;
    if (catId === '0') {
        $("#subcat-select").html("<option value='0'>None</option>")
        return;
    }
    e.target.disabled = true;
    $.ajax({
        url: myContextPath + '/get-subcategory?catId=' + catId,
        type: 'GET',
        dataType: 'json',
        error: (data) => {
            alert(data.responseText);
        },
        success: function (data) {
            let subcategorySelect = $("#subcat-select")
            subcategorySelect.html("");
            subcategorySelect.append('<option selected value="0">None</option>');
            data.forEach(subCategory => {
                subcategorySelect.append(`<option value="${subCategory.id}">${subCategory.name}</option>`)
            })
            const subcategoryId = $("#cat-select").data("subCat") || "";
            subcategorySelect.val(subcategoryId);
        },
        complete: () => {
            e.target.disabled = false;
        }
    })
})

$("#create-course #category").change(e => {
    let catId = e.target.value;
    e.target.disabled = true;
    $.ajax({
        url: myContextPath + '/get-subcategory?catId=' + catId,
        type: 'GET',
        dataType: 'json',
        error: (data) => {
            alert(data.responseText);
        },
        success: function (data) {
            let subcategorySelect = $("#create-course #subcategory")
            subcategorySelect.html("");
            subcategorySelect.append('<option selected disabled value="">-- Subcategory --</option>');
            data.forEach(subCategory => {
                subcategorySelect.append(`<option value="${subCategory.id}">${subCategory.name}</option>`)
            })
            const subcategoryId = $("#create-course #category").attr("subcategory-id") || "";
            subcategorySelect.val(subcategoryId);
        },
        complete: () => {
            e.target.disabled = false;
        }
    })
})

var encoding = text => {
    return encodeURIComponent(JSON.stringify(text)).replaceAll("'", "\\'");
}

var decoding = text => {
    return JSON.parse(decodeURIComponent(text));
}

$("#create-course").submit(e => {
    const content = encoding(editor.getContents());
    let description = $("#create-course #description");
    description.val(content);
})

var quills = [];

initEditors.forEach(editor => {
    const quill = new Quill(editor.selector, quillOptions);
    if (editor.value) {
        quill.setContents(decoding(editor?.value));
        quills.push({selector: editor?.selector, obj: quill})
    }
    quills.push({selector: editor?.selector, obj: quill})

})

$("form.lesson").submit(function (e) {
    const formId = e.target.id;
    const description = $(`#${formId} [name=description]`)
    const quillId = $(`#${formId} .ql-container`).attr('id')
    const quill = quills.find(q => q.selector === `#${quillId}`)
    const content = encoding(quill?.obj.getContents());
    description.val(content);
})

var quillGetHTML = inputDelta => {
    var tempCont = document.createElement("div");
    (new Quill(tempCont)).setContents(decoding(inputDelta));
    return tempCont.getElementsByClassName("ql-editor")[0].innerHTML;
}

$(".rating .starrr").each(function () {
    var rating = $(this).attr("data-rating");
    $(this).starrr({
        rating,
        readOnly: true
    })
})

$("#rating-form .starrr").each(function () {
    var rating = $(this).attr("data-rating");
    $(this).starrr({
        rating,
        change: function (e, value) {
            $("#rating-form [name='rating']").val(value)
        }
    })
    $(this).children("button").attr("type", "button")
})

$('#paging button').click(function (e) {
    var page = $(this).data('page');
    $('#paging [name="p"]').val(page);
})

$('#enroll-btn').click(function (e) {
    e.preventDefault()
    var button = $(this)
    button.html('<div style="width: 21px;height: 21px" class="spinner-border"></div>').prop('disabled', true)
    var courseId = $(this).data('course')
    $.ajax({
        type: 'POST',
        url: myContextPath + '/course/enroll',
        data: `courseId=${courseId}`,
        success: function (message) {
            if (message) {
                window.location.href = message;
            } else {
                button.html('Enrolled').removeClass('btn-danger').addClass('btn-secondary')
            }
        },
        error: function () {
            button.html('Enroll').prop('disabled', false)
        }
    })
})

$('#wishlist-btn').click(function (e) {
    e.preventDefault()
    var button = $(this)
    const tempHtml = $(this).html()
    button.html('<div style="width: 80px"><div style="width: 20px;height: 20px" class="spinner-border"/></div>').prop('disabled', true)
    var courseId = $(this).data('course')
    $.ajax({
        type: 'POST',
        url: myContextPath + '/course/' + $(this).data('action'),
        data: `courseId=${courseId}`,
        success: function (message) {
            if (message) {
                window.location.href = message;
            } else {
                button.prop('disabled', false)
                if (button.data('action') === 'add-wishlist') {
                    button.data('action', 'remove-wishlist')
                    button.html('Wishlisted ').append('<i class="fas fa-heart d-inline-block ml-2" />')
                } else {
                    button.data('action', 'add-wishlist')
                    button.html('Wishlist ').append('<i class="far fa-heart d-inline-block ml-2" />')
                }
            }
        },
        error: function () {
            button.html(tempHtml).prop('disabled', false)
        }
    })

})

$('.video-upload').change(function (e) {
    $(`[for="${e.target.id}"] + span`).text(e.target.value.split(/(\\|\/)/g).pop())
})

$('[data-parent="#curriculum"]').submit(async function (e) {
        e.preventDefault()
        const form = $(this)
        const saveBtn = $('.btn.save')
        const collapseBtn = $('[data-toggle="collapse"]')
        collapseBtn.prop('disabled', true)
        saveBtn.html('<div><div style="width: 20px;height: 20px" class="spinner-border"/></div>').prop('disabled', true)
        let error = false
        if (e.target.id.toString().includes('lesson')) {
            var videoForm = $(`#${e.target.id} + form`)
            if (videoForm.find('input').get(0).files.length !== 0) {
                var formData = new FormData(document.querySelector(`#${e.target.id} + form`))
                await $.ajax({
                    url: videoForm.attr('action'),
                    data: formData,
                    type: 'POST',
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        form.find('[name="video-url"]').val(data.toString().trim().replace('.', '_'))
                    },
                    error: function () {
                        alert("ERROR")
                        error = true
                    }
                })
            }
        }
        if (error) {
            alert("Error")
            saveBtn.prop('disabled', false).html('Save')
            collapseBtn.prop('disabled', false)
        }
        $.ajax({
            url: form.attr('action'),
            type: 'POST',
            data: form.serialize(),
            success: function () {
                location.reload()
            },
            error: function () {
                alert("Error")
                saveBtn.prop('disabled', false).html('Save')
                collapseBtn.prop('disabled', false)
            }
        })
    }
)

var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
var testUsername = /[^a-zA-Z0-9]/;

$('#update-profile').submit(function (e) {
    e.preventDefault();
    const form = $(this)
    $("#account-alert").html('<div style="white-space: pre-line" />')
    const alert = $("#account-alert > div")
    if (!testEmail.test($('#email').val()) || testUsername.test($('#username').val())) {
        alert.addClass("alert alert-danger d-flex justify-content-between")
        let message = "";
        if (!testEmail.test($('#email').val())) {
            $('#email').addClass('border-danger')
            message = "Invalid email address\n"
        }
        if (testUsername.test($('#username').val())) {
            $('#username').addClass('border-danger')
            message += "Username should not contain any special characters"
        }
        alert.text(message.trim())
        alert.append($('<button type="button" class="h-100" data-dismiss="alert" />').html('<span>&times;</span>'));
        alert.alert();
        return;
    }
    $('#email').removeClass('border-danger')
    $('#username').removeClass('border-danger')
    const button = $('#update-profile button')
    button.html('<div><div style="width: 20px;height: 20px" class="spinner-border"/></div>').prop('disabled', true)
    $.ajax({
        url: form.attr('action'),
        type: 'POST',
        data: form.serialize(),
        success: data => {
            alert.addClass("alert alert-success").text("Your profile has been updated successfully!")
                .append($('<button type="button" class="close" data-dismiss="alert" />').html('<span>&times;</span>'));
            alert.alert();
        },
        error: xhr => {
            alert.addClass("alert alert-danger d-flex justify-content-between").text(xhr.responseText || "Server error!")
                .append($('<button type="button" class="close" data-dismiss="alert" />').html('<span>&times;</span>'));
            alert.alert();
        },
        complete: function () {
            button.text("Update").prop('disabled', false)
        }
    })
})

$('#change-password').submit(function (e) {
    e.preventDefault();
    const form = $(this)
    $("#password-alert").html('<div />')
    const alert = $("#password-alert > div")
    if ($('#new-password').val() !== $('#confirm-password').val()) {
        $('#confirm-password').addClass('border-danger')
        alert.addClass("alert alert-danger").text("The Confirm Password does not match.")
            .append($('<button type="button" class="close" data-dismiss="alert" />').html('<span>&times;</span>'));
        alert.alert();
        return;
    }
    $('#confirm-password').removeClass('border-danger')
    const button = $('#change-password button')
    button.html('<div><div style="width: 20px;height: 20px" class="spinner-border"/></div>').prop('disabled', true)
    $.ajax({
        url: form.attr('action'),
        type: 'POST',
        data: form.serialize(),
        success: data => {
            alert.addClass("alert alert-success").text("Password changed successfully!")
                .append($('<button type="button" class="close" data-dismiss="alert" />').html('<span>&times;</span>'));
            alert.alert();
            form.find('input').val('')
        },
        error: xhr => {
            alert.addClass("alert alert-danger").text(xhr.responseText || "Server error!")
                .append($('<button type="button" class="close" data-dismiss="alert" />').html('<span>&times;</span>'));
            alert.alert();
        },
        complete: function () {
            button.text("Save").prop('disabled', false)
        }
    })
})