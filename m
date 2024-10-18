From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 18 Oct 2024 15:04:40 +1030
Subject: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
In-Reply-To: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
Message-ID: <d514fd066353c529052e59c564d1d15f91b6a8b5.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Chanh,

On Mon, 2024-10-14 at 10:50 +0000, Chanh Nguyen wrote:
> 
> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	clock-names = "MACCLK", "RCLK";

Should this be overriding `clocks` also? There's only one clock
specified in the dtsi.

Andrew

> +	use-ncsi;
> +};
