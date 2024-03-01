From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 1 Mar 2024 23:36:41 +0100
Subject: [PATCH v2 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
In-Reply-To: <20240301222257.3309541-1-supreeth.venkatesh@amd.com>
References: <20240301222257.3309541-1-supreeth.venkatesh@amd.com>
Message-ID: <c8686f40-e6e9-4652-b450-217de604b216@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +&mdio0 {
> +	status = "okay";
> +	ethphy0: ethernet-phy at 0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};
> +
> +&mac3 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-handle = <&ethphy0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii4_default>;
> +};

That looks odd. Where are the RGMII delays coming from? Normally its
"rgmii-id", which asks the PHY to insert the delays.

	Andrew
