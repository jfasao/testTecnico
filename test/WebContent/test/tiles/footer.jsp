<!-- Imagen Pie -->

<table  align="center"  cellpadding="0" cellspacing="0" border="0"  width="100%" >
	<tr >
			<td  height="20" width="20%" align="center" class="pie" valign="middle" background="../test/images/template/top.jpg">
			</td>
			<td  height="20" width="60%" align="center" class="pie" valign="middle" background="../test/images/template/top.jpg">
	&nbsp;			
			</td>
			<td  height="20" width="20%" align="right" class="pie" valign="bottom" background="../test/images/template/top.jpg">
		   		 Versión ${session.VersionApp}					
			</td>
	</tr>
</table>	
<script>
var ONESECOND = 1000;
var ONEMINUTE = ONESECOND * 60;
InactivityMonitor = Ext.extend(Ext.util.Observable, {
    inactivityTimeout: ONEMINUTE*3,
    pollActionParam: "a",
    pollAction: "StayAlive",
    pollInterval: ONEMINUTE,
    pollUrl: "",
    messageBoxConfig: {}, // allows developers to override the appearance of the messageBox
    messageBoxCountdown: 30, // how long should the messageBox wait?
    
    constructor: function(config) {
        this.addEvents({timeout: true});
        Ext.apply(this, config);
        InactivityMonitor.superclass.constructor.apply(this, arguments);
        if (this.inactivityTimeout >= ONEMINUTE) {
            this.resetTimeout();
            this._pollTask = Ext.TaskMgr.start({
                run: function () {
                    var params = {};
                    params[this.pollActionParam] = this.pollAction;
                    Ext.Ajax.request({params: params, url: this.pollUrl});
                },
                interval: this.pollInterval,
                scope: this
            });
            var body = Ext.get(document.body);
            body.on("click", this.resetTimeout, this);
            body.on("keypress", this.resetTimeout, this);
        }
    },
    
    destroy: function() {
        var body = Ext.get(document.body);
        body.un("click", this.resetTimeout, this);
        body.un("keypress", this.resetTimeout, this);
		Ext.TaskMgr.stop(this._pollTask);
		this._inactivityTask.cancel();
		Ext.TaskMgr.stop(this._countdownTask);
    },
    
    resetTimeout: function () {
        if (!this._inactivityTask) {
            this._inactivityTask = new Ext.util.DelayedTask(this._beginCountdown, this);
        }
        this._inactivityTask.delay(this.inactivityTimeout);
    },
    
    // private stuff
    _pollTask: null, // task to poll server
    _countdownTask: null, // ONESECOND interval for updating countdown MessageBox
    _countdownMessage: null, // countdown MessageBox
    _inactivityTask: null, // task to start countdown
    _beginCountdown: function () {
        var config = Ext.apply({
            buttons: {ok: "Aceptar"},
            closable: true,
            fn: function (btn) {
                Ext.TaskMgr.stop(this._countdownTask);
                this.resetTimeout();
                this.fireEvent("timeout", this, win);
                console.log("por alla");
                //window.location = "../seguridad/logout.action";
              //  window.location.reload();
            },
            msg: "Su sesión ha finalizado, por favor ingrese nuevamente.",
            progress: true,
            scope: this,
            title: "Inactividad"
        }, this.messageBoxConfig);
        if (!this._countdownMessage) {
			// only create the MessageBox once
            this._countdownMessage = Ext.MessageBox.show(config);
        }
        var win = this._countdownMessage;
        if (!win.isVisible()) {
            win.show(config);
        }
        win.updateProgress(0);
        win.seconds = 0;
        this._countdownTask = Ext.TaskMgr.start({
            run: function () {
                win.seconds += 1;
                console.log("por aca");
                if (win.seconds > this.messageBoxCountdown) {
                    
                    Ext.TaskMgr.stop(this._countdownTask);
                    this.fireEvent("timeout", this, win);
                } else {
                    win.updateProgress(win.seconds / this.messageBoxCountdown);
                }
            },
            scope: this,
            interval: ONESECOND
        });
    }
});

</script>

