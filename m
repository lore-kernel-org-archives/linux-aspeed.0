From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 16 Sep 2020 18:34:13 +0200
Subject: [PATCH] soc: aspeed: Improve kconfig
In-Reply-To: <20200916125731.784527-1-joel@jms.id.au>
References: <20200916125731.784527-1-joel@jms.id.au>
Message-ID: <9c38c586-9667-4052-66be-a6e03459068f@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/16/20 2:57 PM, Joel Stanley wrote:
> Reword the kconfig text to be consistent and reflect that most drivers
> are available for all supported ASPEED chips (2400, 2500 and 2600).
> 
> Rearrange the symbols the SoC drivers depend on so the menu doesn't
> appear unless you are building for ASPEED for compile testing.
> 
> The SYSCON_MFD and REGMAP options are usually selected by drivers that
> need them, so do this.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C?dric Le Goater <clg@kaod.org>

> ---
>  drivers/soc/aspeed/Kconfig | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> index c95fa30f1a76..9ce252445605 100644
> --- a/drivers/soc/aspeed/Kconfig
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -1,32 +1,36 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -menu "Aspeed SoC drivers"
>  
> -config SOC_ASPEED
> -	def_bool y
> -	depends on ARCH_ASPEED || COMPILE_TEST
> +if ARCH_ASPEED || COMPILE_TEST
> +
> +menu "ASPEED SoC drivers"
>  
>  config ASPEED_LPC_CTRL
> -	depends on SOC_ASPEED && REGMAP && MFD_SYSCON
> -	tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> +	tristate "ASPEED LPC firmware cycle control"
> +	select REGMAP
> +	select MFD_SYSCON
>  	help
> -	  Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
> -	  ioctl()s, the driver also provides a read/write interface to a BMC ram
> -	  region where the host LPC read/write region can be buffered.
> +	  Control LPC firmware cycle mappings through ioctl()s. The driver
> +	  also provides a read/write interface to a BMC ram region where the
> +	  host LPC read/write region can be buffered.
>  
>  config ASPEED_LPC_SNOOP
> -	tristate "Aspeed ast2500 HOST LPC snoop support"
> -	depends on SOC_ASPEED && REGMAP && MFD_SYSCON
> +	tristate "ASPEED LPC snoop support"
> +	select REGMAP
> +	select MFD_SYSCON
>  	help
>  	  Provides a driver to control the LPC snoop interface which
>  	  allows the BMC to listen on and save the data written by
>  	  the host to an arbitrary LPC I/O port.
>  
>  config ASPEED_P2A_CTRL
> -	depends on SOC_ASPEED && REGMAP && MFD_SYSCON
> -	tristate "Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC bridge control"
> +	tristate "ASPEED P2A (VGA MMIO to BMC) bridge control"
> +	select REGMAP
> +	select MFD_SYSCON
>  	help
> -	  Control Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC mappings through
> -	  ioctl()s, the driver also provides an interface for userspace mappings to
> -	  a pre-defined region.
> +	  Control ASPEED P2A VGA MMIO to BMC mappings through ioctl()s.  The
> +	  driver also provides an interface for userspace mappings to a
> +	  pre-defined region.
>  
>  endmenu
> +
> +endif
> 

