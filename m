From: Joel Stanley <joel@jms.id.au>
Date: Wed, 18 Jan 2023 03:04:43 +0000
Subject: [PATCH] ARM: dts: ethanolx: Add label for the master partition
In-Reply-To: <20230111100105.707-1-aladyshev22@gmail.com>
References: <20230111100105.707-1-aladyshev22@gmail.com>
Message-ID: <CACPK8Xenc2E6-fe_mkoDOXXHim8ZUV9-h2vFpwUfvuen0M0aPQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 11 Jan 2023 at 10:01, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> Add label "bmc" for the flash master partition. The master partition
> is required for the firmware update in the OpenBMC ecosystem.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

I've merged the 5 patches you sent for submission into v6.3.

If you have a set of device tree patches feel free to send them as a
series next time. I know they're unrelated, but by sending a series
they are easier for the maintainer tools to process as a group.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 6406a0f080ee..889b2fdd19cf 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -58,6 +58,7 @@ &fmc {
>         flash at 0 {
>                 status = "okay";
>                 m25p,fast-read;
> +               label = "bmc";
>                 #include "openbmc-flash-layout.dtsi"
>         };
>  };
> --
> 2.25.1
>
