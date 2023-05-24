const resourcePath = global.GetResourcePath ?
    global.GetResourcePath(global.GetCurrentResourceName()) : global.__dirname
const settingsjson = require(resourcePath + '/settings.js')

exports.runcmd = (fivemexports, client, message, params) => {
    message.delete()
    if (!params[0] || !params[1] || !parseInt(params[1])) {
        return message.reply('Invalid args! Correct term is: ' + process.env.PREFIX + 'ban [permid] [time (hours)] [reason]')
    }
    const reason = params.slice(2).join(' ');
    console.log("ban");
    if (params[1] == "-1") {
        let newval = fivemexports.vrp.vrpbot('banConsole', [params[0], "perm", `${reason}`]) 
    }
    else {
        let newval = fivemexports.vrp.vrpbot('banConsole', [params[0], params[1], `${reason}`])
    }
        let embed = {
            "title": "Banned User",
            "description": `\nPerm ID: **${params[0]}**\nTime: **${params[1]} hours**\nReason: **${reason}**\n\nAdmin: <@${message.author.id}>`,
            "color": settingsjson.settings.botColour,
            "footer": {
                "text": ``
            },
            "timestamp": new Date()
        }
        message.channel.send({embed})
}

exports.conf = {
    name: "ban",
    perm: 2
}