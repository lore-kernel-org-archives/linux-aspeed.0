From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 31 Aug 2019 08:01:35 -0700
Subject: [PATCH v4 4/4] aspeed/watchdog: Add access_cs0 option for alt-boot
In-Reply-To: <20190828102402.13155-5-i.mikhaylov@yadro.com>
References: <20190828102402.13155-1-i.mikhaylov@yadro.com>
 <20190828102402.13155-5-i.mikhaylov@yadro.com>
Message-ID: <20190831150135.GA7230@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 28, 2019 at 01:24:02PM +0300, Ivan Mikhaylov wrote:
> The option for the ast2400/2500 to get access to CS0 at runtime.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../ABI/testing/sysfs-class-watchdog          | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
> index 6317ade5ad19..675f9b537661 100644
> --- a/Documentation/ABI/testing/sysfs-class-watchdog
> +++ b/Documentation/ABI/testing/sysfs-class-watchdog
> @@ -72,3 +72,37 @@ Description:
>  		It is a read/write file. When read, the currently assigned
>  		pretimeout governor is returned.  When written, it sets
>  		the pretimeout governor.
> +
> +What:		/sys/class/watchdog/watchdog1/access_cs0
> +Date:		August 2019
> +Contact:	Ivan Mikhaylov <i.mikhaylov@yadro.com>,
> +		Alexander Amelkin <a.amelkin@yadro.com>
> +Description:
> +		It is a read/write file. This attribute exists only if the
> +		system has booted from the alternate flash chip due to
> +		expiration of a watchdog timer of AST2400/AST2500 when
> +		alternate boot function was enabled with 'aspeed,alt-boot'
> +		devicetree option for that watchdog or with an appropriate
> +		h/w strapping (for WDT2 only).
> +
> +		At alternate flash the 'access_cs0' sysfs node provides:
> +			ast2400: a way to get access to the primary SPI flash
> +				chip at CS0 after booting from the alternate
> +				chip at CS1.
> +			ast2500: a way to restore the normal address mapping
> +				from (CS0->CS1, CS1->CS0) to (CS0->CS0,
> +				CS1->CS1).
> +
> +		Clearing the boot code selection and timeout counter also
> +		resets to the initial state the chip select line mapping. When
> +		the SoC is in normal mapping state (i.e. booted from CS0),
> +		clearing those bits does nothing for both versions of the SoC.
> +		For alternate boot mode (booted from CS1 due to wdt2
> +		expiration) the behavior differs as described above.
> +
> +		This option can be used with wdt2 (watchdog1) only.
> +
> +		When read, the current status of the boot code selection is
> +		shown. When written with any non-zero value, it clears
> +		the boot code selection and the timeout counter, which results
> +		in chipselect reset for AST2400/AST2500.
