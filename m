From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 20 May 2021 21:23:04 +0700
Subject: [PATCH v3 0/7] Add Aspeed SSIF BMC driver
In-Reply-To: <20210519123401.GG2921206@minyard.net>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
 <20210519123401.GG2921206@minyard.net>
Message-ID: <58adf982-bf9c-f706-68ed-c25be43a22fb@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 19/05/2021 19:34, Corey Minyard wrote:
> On Wed, May 19, 2021 at 02:49:27PM +0700, Quan Nguyen wrote:
>> This series add support for the Aspeed specific SSIF BMC driver which
>> is to perform in-band IPMI communication with the host in management
>> (BMC) side.
>>
>> v3:
>>    + Switched binding doc to use DT schema format [Rob]
>>    + Splited into generic ssif_bmc and aspeed-specific [Corey, Joel]
>>    + Removed redundant license info [Joel]
>>    + Switched to use traditional if-else [Joel]
>>    + Removed unused ssif_bmc_ioctl() [Joel]
>>    + Made handle_request()/complete_response() to return void [Joel]
>>    + Refactored send_ssif_bmc_response()/receive_ssif_bmc_request() [Corey]
>>    + Remove mutex [Corey]
>>    + Use spin_lock/unlock_irqsave/restore in callback [Corey]
>>    + Removed the unnecessary memset [Corey]
>>    + Switch to use dev_err() [Corey]
>>    + Combine mask/unmask two interrupts together [Corey]
>>    + Fixed unhandled Tx done with NAK [Quan]
>>    + Late ack'ed Tx done w/wo Ack irq [Quan]
>>    + Use aspeed-specific exported aspeed_set_slave_busy() when slave busy
>> to fix the deadlock [Graeme, Philipp, Quan]
>>    + Clean buffer for last multipart read [Quan]
>>    + Handle unknown incoming command [Quan]
>>
>> v2:
>>    + Fixed compiling error with COMPILE_TEST for arc
>>
>> Quan Nguyen (7):
>>    i2c: i2c-core-smbus: Expose PEC calculate function for generic use
> 
> Note that for this I2C-specific change, I will need acks from the I2C
> maintainers to be able to include this in my tree.
>  >>    ipmi: ssif_bmc: Add SSIF BMC driver
>>    i2c: aspeed: Fix unhandled Tx done with NAK
> 
> For the aspeed changes, they don't really belong here, they belong in
> the aspeed tree.  I see that you need them for the device to work
> correctly, though.  I'll need acks from maintainers to include them.
> 
Thanks for you information.
Will separate these i2c-aspeed's patches into other independent series 
in next version.

>>    i2c: aspeed: Acknowledge Tx done w/wo ACK irq late
>>    i2c: aspeed: Add aspeed_set_slave_busy()
>>    ipmi: ssif_bmc: Add Aspeed SSIF BMC driver
>>    bindings: ipmi: Add binding for Aspeed SSIF BMC driver
>>
>>   .../bindings/ipmi/aspeed-ssif-bmc.yaml        |  33 +
>>   drivers/char/ipmi/Kconfig                     |  22 +
>>   drivers/char/ipmi/Makefile                    |   2 +
>>   drivers/char/ipmi/ssif_bmc.c                  | 605 ++++++++++++++++++
>>   drivers/char/ipmi/ssif_bmc.h                  |  93 +++
>>   drivers/char/ipmi/ssif_bmc_aspeed.c           |  75 +++
>>   drivers/i2c/busses/i2c-aspeed.c               |  51 +-
>>   drivers/i2c/i2c-core-smbus.c                  |  12 +-
>>   include/linux/i2c.h                           |   1 +
>>   9 files changed, 884 insertions(+), 10 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.yaml
>>   create mode 100644 drivers/char/ipmi/ssif_bmc.c
>>   create mode 100644 drivers/char/ipmi/ssif_bmc.h
>>   create mode 100644 drivers/char/ipmi/ssif_bmc_aspeed.c
>>
>> -- 
>> 2.28.0
>>

