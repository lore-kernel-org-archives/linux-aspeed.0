From: Ali El-Haj-Mahmoud <aaelhaj@google.com>
Date: Tue, 30 Nov 2021 12:59:13 -0500
Subject: [PATCH] S8036 DTS changes:
In-Reply-To: <20211130175740.2216591-1-aaelhaj@google.com>
References: <20211130175740.2216591-1-aaelhaj@google.com>
Message-ID: <CAFPZpNb+7JNu+B9gLnv_Q_k_vFMt5odqRVZ1tQVgbM7QRxJpPQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Oops. Please ignore. Sent from incorrect workspace.

On Tue, Nov 30, 2021 at 12:58 PM Ali El-Haj-Mahmoud <aaelhaj@google.com>
wrote:

> - Allow VUART and SuperIO to coexist.
> - Minor formatting.
> ---
>  .../linux-aspeed/aspeed-bmc-tyan-s8036.dts    | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git
> a/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
> b/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
> index 30b68ce89..7f650f6c8 100644
> ---
> a/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
> +++
> b/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
> @@ -127,10 +127,23 @@
>         status = "okay";
>  };
>
> +&uart_routing {
> +       status = "okay";
> +};
> +
>  &vuart {
>         status = "okay";
> -       aspeed,lpc-io-reg = <0x3f8>;
> -       aspeed,lpc-interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> +
> +       /* We enable the VUART here, but leave it in a state that does
> +        * not interfere with the SuperIO. The goal is to have both the
> +        * VUART and the SuperIO available and decide at runtime whether
> +        * the VUART should actually be used. For that reason, configure
> +        * an "invalid" IO address and an IRQ that is not used by the
> +        * BMC.
> +        */
> +
> +       aspeed,lpc-io-reg = <0xffff>;
> +       aspeed,lpc-interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
>  };
>
>  &lpc_ctrl {
> @@ -340,7 +353,7 @@
>
>  &kcs1 {
>         status = "okay";
> -   aspeed,lpc-io-reg = <0xca8>;
> +       aspeed,lpc-io-reg = <0xca8>;
>  };
>
>  &kcs3 {
> @@ -385,7 +398,7 @@
>         /*A6*/          "",
>         /*A7*/          "",
>         /*B0-B7*/       "","","","","","","","",
> -   /*C0-C7*/   "","","","","","","","",
> +       /*C0-C7*/       "","","","","","","","",
>         /*D0*/          "",
>         /*D1*/          "",
>         /*D2*/          "power-chassis-good", /* in: PWR_GOOD_LED -- Check
> if this is Z3?*/
> @@ -447,6 +460,6 @@
>         /*AA5*/         "",
>         /*AA6*/         "",
>         /*AA7*/         "BMC_ASSERT_BMC_READY",
> -   /*AB0*/     "BMC_SPD_SEL",
> +       /*AB0*/     "BMC_SPD_SEL",
>         /*AB1-AB7*/     "","","","","","","";
>  };
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211130/27f773f5/attachment.htm>
