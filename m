From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 9 Dec 2023 11:39:26 +0100
Subject: [PATCH v6 2/2] ARM: dts: aspeed: Harma: Add Facebook Harma
 (AST2600) BMC
In-Reply-To: <20231206155316.4181813-3-peteryin.openbmc@gmail.com>
References: <20231206155316.4181813-1-peteryin.openbmc@gmail.com>
 <20231206155316.4181813-3-peteryin.openbmc@gmail.com>
Message-ID: <390187fb-4ab4-49e6-b382-7be1fa117f01@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 06/12/2023 16:53, Peter Yin wrote:
> Add linux device tree entry related to
> Harma specific devices connected to BMC SoC.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---

...

> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	no-hw-checksum;
> +	use-ncsi;
> +	ncsi-ctrl,start-redo-probe;
> +	ncsi-ctrl,no-channel-monitor;
> +	mlx,multi-host;

There is no such property. Please stop copying downstream code into
upstream.

Best regards,
Krzysztof

