From: Joel Stanley <joel@jms.id.au>
Date: Fri, 13 Aug 2021 01:29:17 +0000
Subject: [PATCH v2 4/6] ARM: dts: aspeed: Add Facebook Cloudripper
 (AST2600) BMC
In-Reply-To: <20210805222818.8391-5-rentao.bupt@gmail.com>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-5-rentao.bupt@gmail.com>
Message-ID: <CACPK8XcV5On2D4D+SXnfw1M0owwfCL4Su19jOEA7yWpq+T3jLw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 5 Aug 2021 at 22:28, <rentao.bupt@gmail.com> wrote:
> +&mdio1 {
> +       status = "okay";

You're enabling this but it looks like it's unused?

> +};
> +
> +&mdio3 {
> +       status = "okay";
> +
> +       ethphy1: ethernet-phy at 13 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0x0d>;
> +       };
> +};
> +
> +&mac3 {
> +       status = "okay";
> +       phy-mode = "rgmii";
> +       phy-handle = <&ethphy1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii4_default>;
> +};
