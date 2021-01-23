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

$("#create-course").submit(e => {
    let description = $("#create-course #description");
    description.val(JSON.stringify(editor.getContents()));
})

var quills = [];
initEditors.forEach(editor => {
    const quill = new Quill(editor.selector, quillOptions);
    quill.setContents(editor?.value);
    quills.push({selector: editor?.selector, obj: quill})
})

console.log(quills)

$("form.lesson").submit(e => {
    const formId = e.target.id;
    const description = $(`#${formId} [name=description]`)
    const quillId = $(`#${formId} .ql-container`).attr('id')
    const quill = quills.find(q => q.selector === `#${quillId}`)
    const content = JSON.stringify(quill?.obj.getContents().replace(/\&nbsp;/g, ''));
    console.log(encodeURIComponent(content));
    e.preventDefault()
    description.val(encodeURIComponent(content));
})