From: Corey Minyard <minyard@acm.org>
Date: Fri, 2 Apr 2021 09:21:24 -0500
Subject: [PATCH v2 0/3] Add Aspeed SSIF BMC driver
In-Reply-To: <20210330141029.20412-1-quan@os.amperecomputing.com>
References: <20210330141029.20412-1-quan@os.amperecomputing.com>
Message-ID: <20210402142124.GV507977@minyard.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 30, 2021 at 09:10:26PM +0700, Quan Nguyen wrote:
> This series add support for the Aspeed specific SSIF BMC driver which
> is to perform in-band IPMI communication with the host in management
> (BMC) side.

I don't have any specific feedback for this, but I'm wondering if it's
really necessary.

Why can't the BMC just open the I2C device and use it?  Is there any
functionality that this provides that cannot be accomplished from
userland access to the I2C device?  I don't see any.

If it tied into some existing framework to give abstract access to a BMC
slave side interface, I'd be ok with this.  But I don't see that.

Unless there is a big need to have this in the kernel, I'm against
including this and would suggest you do all this work in userland.
Perhaps write a library.  Sorry, but I'm trying to do my part to reduce
unnecessary things in the kernel.

Thanks,

-corey

> 
> v2:
>   + Fixed compiling error with COMPILE_TEST for arc
> 
> Quan Nguyen (3):
>   i2c: i2c-core-smbus: Expose PEC calculate function for generic use
>   drivers: char: ipmi: Add Aspeed SSIF BMC driver
>   bindings: ipmi: Add binding for Aspeed SSIF BMC driver
> 
>  .../bindings/ipmi/aspeed-ssif-bmc.txt         |  18 +
>  drivers/char/ipmi/Kconfig                     |  22 +
>  drivers/char/ipmi/Makefile                    |   2 +
>  drivers/char/ipmi/ssif_bmc.c                  | 645 ++++++++++++++++++
>  drivers/char/ipmi/ssif_bmc.h                  |  92 +++
>  drivers/char/ipmi/ssif_bmc_aspeed.c           | 132 ++++
>  drivers/i2c/i2c-core-smbus.c                  |  12 +-
>  include/linux/i2c.h                           |   1 +
>  8 files changed, 922 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-ssif-bmc.txt
>  create mode 100644 drivers/char/ipmi/ssif_bmc.c
>  create mode 100644 drivers/char/ipmi/ssif_bmc.h
>  create mode 100644 drivers/char/ipmi/ssif_bmc_aspeed.c
> 
> -- 
> 2.28.0
> 
