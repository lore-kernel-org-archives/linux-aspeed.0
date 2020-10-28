From: Joel Stanley <joel@jms.id.au>
Date: Wed, 28 Oct 2020 05:28:47 +0000
Subject: [PATCH 3/3] ARM: dts: aspeed: amd-ethanolx: Enable devices for
 the iKVM functionality
In-Reply-To: <20201027123722.2935-3-aladyshev22@gmail.com>
References: <20201027123722.2935-1-aladyshev22@gmail.com>
 <20201027123722.2935-3-aladyshev22@gmail.com>
Message-ID: <CACPK8XdDZTYuOb-0QvpStAO0iZH+Si4t2f3sNjPjmPwLrGMc5g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2020 at 12:41, Konstantin Aladyshev
<aladyshev22@gmail.com> wrote:
>
> Enable the USB 2.0 Virtual Hub Controller and
> the Video Engine with it's reserved memory region for the implementation
> of the iKVM functionality in the BMC.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 2a86bda8afd8..b93ed44eba0c 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -13,6 +13,21 @@
>         memory at 80000000 {
>                 reg = <0x80000000 0x20000000>;
>         };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               video_engine_memory: jpegbuffer {
> +                       size = <0x02000000>;    /* 32M */
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +       };
> +
> +
>         aliases {
>                 serial0 = &uart1;
>                 serial4 = &uart5;
> @@ -220,5 +235,12 @@
>         };
>  };
>
> +&video {
> +       status = "okay";
> +       memory-region = <&video_engine_memory>;
> +};
>
> +&vhub {
> +       status = "okay";
> +};
>
> --
> 2.17.1
>
