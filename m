From: Joel Stanley <joel@jms.id.au>
Date: Wed, 9 Aug 2023 08:05:25 +0000
Subject: [PATCH v7 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite 4 BMC
In-Reply-To: <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com>
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com> <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <CACPK8XfFWC-wxCt4DwNRNctXap5qiZUz-utcbpnp0vj=Z46=9Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 8 Aug 2023 at 08:43, Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
>
> Add linux device tree entry related to
> Yosemite 4 specific devices connected to BMC SoC.

Convention is to mention what kind of machine this is, to give us some
context for review. "This is an x86 server" or similar. Take a look at
existing aspeed device tree commits for inspiration.

> +&mac2 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii3_default>;
> +       no-hw-checksum;
> +       use-ncsi;
> +       mlx,multi-host;
> +       ncsi-ctrl,start-redo-probe;
> +       ncsi-ctrl,no-channel-monitor;
> +       ncsi-package = <1>;
> +       ncsi-channel = <1>;
> +       ncsi-rexmit = <1>;
> +       ncsi-timeout = <2>;

None of these are properties that mainline Linux supports. Do you plan
on sending patches for these?

> +};
> +
> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       no-hw-checksum;
> +       use-ncsi;
> +       mlx,multi-host;
> +       ncsi-ctrl,start-redo-probe;
> +       ncsi-ctrl,no-channel-monitor;
> +       ncsi-package = <1>;
> +       ncsi-channel = <1>;
> +       ncsi-rexmit = <1>;
> +       ncsi-timeout = <2>;
> +};
