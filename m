From: Corey Minyard <minyard@acm.org>
Date: Tue, 13 Jul 2021 19:17:36 -0500
Subject: [PATCH v4 0/3] Add SSIF BMC driver
In-Reply-To: <f7dd5b0f-a2a7-0a5f-3521-6721e8e52cb5@os.amperecomputing.com>
References: <20210713055425.30636-1-quan@os.amperecomputing.com>
 <20210713154405.GB3406@minyard.net>
 <f7dd5b0f-a2a7-0a5f-3521-6721e8e52cb5@os.amperecomputing.com>
Message-ID: <20210714001736.GD3406@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 14, 2021 at 06:29:27AM +0700, Quan Nguyen wrote:
> On 13/07/2021 22:44, Corey Minyard wrote:
> > On Tue, Jul 13, 2021 at 12:54:22PM +0700, Quan Nguyen wrote:
> > > This series add support the SSIF BMC driver which is to perform in-band
> > > IPMI communication with their host in management (BMC) side.
> > 
> > Per the kernel build robot, looks like patch 3 introduces slave_enable()
> > but patch 1 uses it.
> > 
> > -corey
> > 
> Thanks Corey,
> 
> The order is not correct and kernel build robot found this hurts
> bisectibility.
> The patch 3 should be the first patch.

Ok, can you re-submit in the right order?

Thanks,

-corey

> 
> - Quan
> 
> > > 
> > > SSIF BMC driver in this series is tested with Aspeed AST2500.
> > > 
> > > v4:
> > >    + Fix recursive spinlock                                      [Graeme]
> > >    + Send response with Completion code 0xFF when aborting         [Quan]
> > >    + Fix warning with dt_binding_check                              [Rob]
> > >    + Change aspeed-ssif-bmc.yaml to ssif-bmc.yaml                  [Quan]
> > >    + Added bounding check on SMBus writes and the whole request     [Dan]
> > >    + Moved buffer to end of struct ssif_bmc_ctx to avoid context
> > >      corruption if somehow buffer is written past the end           [Dan]
> > >    + Return -EINVAL if userspace buffer too small, dont
> > >      silence truncate                                       [Corey, Joel]
> > >    + Not necessary to check NONBLOCK in lock                      [Corey]
> > >    + Enforce one user at a time                                    [Joel]
> > >    + Reject write with invalid response length from userspace     [Corey]
> > >    + Add state machines for better ssif bmc state handling         [Quan]
> > >    + Drop ssif_bmc_aspeed.c and make ssif_bmc.c is generic
> > >      SSIF BMC driver                                               [Quan]
> > >    + Change compatible string "aspeed,ast2500-ssif-bmc" to
> > >      "ampere,ssif-bmc"                                             [Quan]
> > >    + Toggle Slave enable in i2c-aspeed to turn on/off slave mode   [Ryan]
> > >    + Added slave_enable() to struct i2c_algorithm to control
> > >      slave mode and to address the recursive spinlock      [Graeme, Ryan]
> > >    + Abort current request with invalid SMBus write or
> > >      invalid command                                               [Quan]
> > >    + Abort all request if there is pending response                [Quan]
> > >    + Changed validate_pec() to validate_request()                  [Quan]
> > >    + Add unsupported_smbus_cmd() to handle unknown SMBus command   [Quan]
> > >    + Print internal state string for ease investigating issue      [Quan]
> > >    + Move to READY state on SLAVE_STOP event                       [Quan]
> > >    + Change initilize_transfer() to process_smbus_cmd()            [Quan]
> > >    + Introduce functions for each slave event                      [Quan]
> > > 
> > > v3:
> > >    + Switched binding doc to use DT schema format [Rob]
> > >    + Splited into generic ssif_bmc and aspeed-specific [Corey, Joel]
> > >    + Removed redundant license info [Joel]
> > >    + Switched to use traditional if-else [Joel]
> > >    + Removed unused ssif_bmc_ioctl() [Joel]
> > >    + Made handle_request()/complete_response() to return void [Joel]
> > >    + Refactored send_ssif_bmc_response()/receive_ssif_bmc_request()
> > >    [Corey]
> > >    + Remove mutex [Corey]
> > >    + Use spin_lock/unlock_irqsave/restore in callback [Corey]
> > >    + Removed the unnecessary memset [Corey]
> > >    + Switch to use dev_err() [Corey]
> > >    + Combine mask/unmask two interrupts together [Corey]
> > >    + Fixed unhandled Tx done with NAK [Quan]
> > >    + Late ack'ed Tx done w/wo Ack irq [Quan]
> > >    + Use aspeed-specific exported aspeed_set_slave_busy() when slave busy
> > >    to fix the deadlock [Graeme, Philipp, Quan]
> > >    + Clean buffer for last multipart read [Quan]
> > >    + Handle unknown incoming command [Quan]
> > > 
> > > v2:
> > >    + Fixed compiling error with COMPILE_TEST for arc
> > > 
> > > Quan Nguyen (3):
> > >    ipmi: ssif_bmc: Add SSIF BMC driver
> > >    bindings: ipmi: Add binding for SSIF BMC driver
> > >    i2c: aspeed: Add slave_enable() to toggle slave mode
> > > 
> > >   .../devicetree/bindings/ipmi/ssif-bmc.yaml    |  38 +
> > >   drivers/char/ipmi/Kconfig                     |  11 +
> > >   drivers/char/ipmi/Makefile                    |   1 +
> > >   drivers/char/ipmi/ssif_bmc.c                  | 781 ++++++++++++++++++
> > >   drivers/char/ipmi/ssif_bmc.h                  | 106 +++
> > >   drivers/i2c/busses/i2c-aspeed.c               |  20 +
> > >   include/linux/i2c.h                           |   2 +
> > >   7 files changed, 959 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
> > >   create mode 100644 drivers/char/ipmi/ssif_bmc.c
> > >   create mode 100644 drivers/char/ipmi/ssif_bmc.h
> > > 
> > > -- 
> > > 2.28.0
> > > 
> 
