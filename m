From: Joel Stanley <joel@jms.id.au>
Date: Thu, 19 Nov 2020 05:17:32 +0000
Subject: [PATCH v2 5/6] ARM: dts: rainier: Add reserved memory for ramoops
In-Reply-To: <20201022014731.2035438-6-andrew@aj.id.au>
References: <20201022014731.2035438-1-andrew@aj.id.au>
 <20201022014731.2035438-6-andrew@aj.id.au>
Message-ID: <CACPK8XfaF_ZzhL1mQxK5Rcpkq9UmBtas+MzxJvFTFC3Bm2UGuw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2020 at 01:48, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Reserve a 1.5MiB region of memory to record kmsg dumps, console and
> userspace message state into 16kiB ring-buffer slots. The sizing allows
> for up to 16 dumps to be captured and read out.
>
> Set max-reason to KMSG_DUMP_EMERG to capture bad-path reboots.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index 802027a3c43c..8431cf1b32e6 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -55,6 +55,15 @@ flash_memory: region at B8000000 {
>
>                 /* 48MB region from the end of flash to start of vga memory */
>
> +               ramoops at bc000000 {
> +                       compatible = "ramoops";
> +                       reg = <0xbc000000 0x180000>; /* 16 * (3 * 0x8000) */
> +                       record-size = <0x8000>;
> +                       console-size = <0x8000>;
> +                       pmsg-size = <0x8000>;
> +                       max-reason = <3>; /* KMSG_DUMP_EMERG */
> +               };
> +
>                 /* VGA region is dictated by hardware strapping */
>                 vga_memory: region at bf000000 {
>                         no-map;
> --
> 2.25.1
>
