From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 7 Apr 2021 14:23:32 +0700
Subject: [PATCH v2 2/3] drivers: char: ipmi: Add Aspeed SSIF BMC driver
In-Reply-To: <20210402120137.GA26002@pengutronix.de>
References: <20210330141029.20412-1-quan@os.amperecomputing.com>
 <20210330141029.20412-3-quan@os.amperecomputing.com>
 <20210402120137.GA26002@pengutronix.de>
Message-ID: <82887823-b6b7-3d53-0fe3-571cbb2552c8@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 02/04/2021 19:01, Philipp Zabel wrote:
> Hi Quan,
> 
> On Tue, Mar 30, 2021 at 09:10:28PM +0700, Quan Nguyen wrote:
>> The SMBus system interface (SSIF) IPMI BMC driver can be used to perform
>> in-band IPMI communication with their host in management (BMC) side.
>>
>> This commits adds support specifically for Aspeed AST2500 which commonly
>> used as Board Management Controllers.
>>
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
> [...]
>> diff --git a/drivers/char/ipmi/ssif_bmc_aspeed.c b/drivers/char/ipmi/ssif_bmc_aspeed.c
>> new file mode 100644
>> index 000000000000..a563fcff5acc
>> --- /dev/null
>> +++ b/drivers/char/ipmi/ssif_bmc_aspeed.c
>> @@ -0,0 +1,132 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * The driver for BMC side of Aspeed SSIF interface
>> + *
>> + * Copyright (c) 2021, Ampere Computing LLC
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <https://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +#include <linux/poll.h>
>> +#include <linux/iopoll.h>
>> +
>> +#include "ssif_bmc.h"
>> +
>> +struct aspeed_i2c_bus {
>> +	struct i2c_adapter              adap;
>> +	struct device                   *dev;
> 
> This device handle is apparently unused.
> 
>> +	void __iomem                    *base;
>> +	struct reset_control            *rst;
> 
> This reset control handle is unused as well.
> 

Thank for the comment, Philipp.

The main purpose here is to get the aspeed_i2c_bus->base of aspeed_i2c 
driver so that the ASPEED_I2CD_INTR_RX_DONE and 
ASPEED_I2CD_INTR_SLAVE_MATCH can be masked while handling the incoming 
request, otherwise, the process is disturbed because these interrupts 
keep occurring with unwanted value.

Other solution we have in mind is to implement and expose the 
EXPORT_SYMBOL_GPL(i2c_aspeed_configure_slave) from 
drivers/i2c/busses/i2c-aspeed.c

Really appreciate if you could comment more on the solution.

Thanks,
- Quan
