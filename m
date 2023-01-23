From: Adriana Kobylak <anoo@linux.ibm.com>
Date: Mon, 23 Jan 2023 14:34:44 -0600
Subject: [PATCH 1/2] ARM: dts: aspeed: bletchley: rename flash1 label
In-Reply-To: <20221226054535.2836110-2-potin.lai.pt@gmail.com>
References: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
 <20221226054535.2836110-2-potin.lai.pt@gmail.com>
Message-ID: <4A9DBC51-596B-47C0-BA4D-9E790EBAE0FC@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On Dec 25, 2022, at 11:45 PM, Potin Lai <potin.lai.pt@gmail.com> wrote:
> 
> In OpenBMC, phosphor-software-manager use "alt-bmc" for secondary falsh
> label.
> Rename flash1 label to "alt-bmc" to support dual image feature inOpenBMC.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
> arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index a619eec70633..791f83aaac50 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -307,7 +307,7 @@ flash at 0 {
> 	flash at 1 {
> 		status = "okay";
> 		m25p,fast-read;
> -		label = "flash1";
> +		label = "alt-bmc";
> 		spi-max-frequency = <50000000>;

This is correct, and I see it?s been merged into 6.3. 
Just something you may want do to as a follow-up change to add the partitions to the alternate flash device. Similar to the include line for:

flash at 0{
?
label = ?bmc?
...
#include "openbmc-flash-layout-128.dtsi?
};

You probably want an include for the alt partitions and add this include line at the end:
flash at 1{
?
label = ?alt-bmc?;
...
+ #include "openbmc-flash-layout-128-alt.dtsi?
};

There?s not a file "openbmc-flash-layout-128-alt.dtsi? that exists today, so you?d need to create it by copying it the existing "openbmc-flash-layout-128.dtsi? and just add an ?alt-? prefix to the partition labels, this is the change that was done to create the file "openbmc-flash-layout-64-alt.dtsi? for 64MB flash chips as an example: https://lore.kernel.org/openbmc/Yboga8RUoYrXoPB1 at heinlein/t/#maca042c23241f765fc2aaaa9d90131ee69b8cf81

The function that you gain by adding ?alt-? partitions to the secondary flash device is that the phosphor-software-manager code will auto-mount the partitions including the read-write filesystem for syncing/backup and also create the d-bus version interfaces for this secondary flash device.

This is probably more information that you?d want, but you may had noticed that IBM?s 128MB tacoma system "aspeed-bmc-opp-tacoma.dts? does not have partitions for the secondary device, and the reason is that the 2nd NOR chip is not used, instead we have an eMMC card attached and use the u-boot partition from the primary NOR flash device. Otherwise we would had created the "openbmc-flash-layout-128-alt.dtsi? file already.

> 	};
> };
> -- 
> 2.31.1
> 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230123/233fe1bc/attachment-0001.htm>
