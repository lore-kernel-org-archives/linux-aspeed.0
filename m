From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 05:28:13 +0000
Subject: [PATCH 2/3] ARM: dts: aspeed: amd-ethanolx: Enable KCS channel 3
In-Reply-To: <20201027123722.2935-2-aladyshev22@gmail.com>
References: <20201027123722.2935-1-aladyshev22@gmail.com>
 <20201027123722.2935-2-aladyshev22@gmail.com>
Message-ID: <CACPK8XeaWbrWBKonxqW0Gu2AnB3mXBNXsEDmsEP_hzT1e8gX1w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2020 at 12:41, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> The KCS interface on the LPC channel 3 in the controller
> is used for the in-band BMC<->BIOS IPMI communication.
> 0xCA2 is a default host CPU LPC IO address for this
> interface.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

I don't have any docs on the platform so I'll wait for a review from
Supreeth before applying this one.

It's a correct use of the bindings:

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 89ddc3847222..2a86bda8afd8 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -147,6 +147,11 @@
>         aspeed,lpc-io-reg = <0x62>;
>  };
>
> +&kcs3 {
> +       status = "okay";
> +       aspeed,lpc-io-reg = <0xCA2>;
> +};
> +
>  &kcs4 {
>         status = "okay";
>         aspeed,lpc-io-reg = <0x97DE>;
> --
> 2.17.1
>
