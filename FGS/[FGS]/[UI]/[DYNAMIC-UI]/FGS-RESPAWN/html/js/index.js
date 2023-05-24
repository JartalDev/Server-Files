$(function () {
    function displaytherespawnmenu(bool) {
        if (bool) {
            $(".content-ui").show();
        } else {
            $(".content-ui").hide();
        }
    }

    displaytherespawnmenu(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "respawnmenu") {
            if (item.status == true) {
                displaytherespawnmenu(true)
            } else {
                displaytherespawnmenu(false)
            }
        }
    })

    $("#tptohomerton").click(function () {
        $.post('https://FGS-RESPAWN/tptohomerton')
    })
    $("#tptosandy").click(function () {
        $.post('https://FGS-RESPAWN/tptosandy')
    })
    $("#tptopaleto").click(function () {
        $.post('https://FGS-RESPAWN/tptopaleto')
    })
    $("#tptopd").click(function () {
        $.post('https://FGS-RESPAWN/tptopd')
    })
    $("#tptovespucci").click(function () {
        $.post('https://FGS-RESPAWN/tptovespucci')
    })
    $("#tptorebel").click(function () {
        $.post('https://FGS-RESPAWN/tptorebel')
    })
    $("#tptovip").click(function () {
        $.post('https://FGS-RESPAWN/tptovip')
    })
})