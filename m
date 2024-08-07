From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 07 Aug 2024 11:38:48 +0930
Subject: [PATCH v2 0/5] Update the device tree for Ampere's BMC platform
In-Reply-To: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
References: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
Message-ID: <5218da67149847bb803081b9f59ed031ffd7b43c.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-08-06 at 07:18 +0000, Chanh Nguyen wrote:
> Updates the device tree to support some features on Ampere's
> Mt.Mitchell BMC and Ampere's Mt.Jade BMC.
> 
> Changes in v2:
>  - Add eeprom nodes to the riser cards and update commit message   [Chanh]
>  - Remove the "Add I2C Fan controllers"                            [Andrew]
>    
> Chanh Nguyen (5):
>   ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
>   ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias ports
>   ARM: dts: aspeed: mtmitchell: Add Riser cards
>   ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
>   ARM: dts: aspeed: mtmitchell: Add LEDs
> 
>  .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  16 ++
>  .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 154 ++++++++++++++++++
>  2 files changed, 170 insertions(+)
> 

I've applied these to be merged via the BMC tree.

Thanks,

Andrew
