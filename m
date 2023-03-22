From: Heiko Stuebner <heiko@sntech.de>
Date: Wed, 22 Mar 2023 20:15:44 +0100
Subject: [PATCH v2] dt-bindings: net: Drop unneeded quotes
In-Reply-To: <20230320233758.2918972-1-robh@kernel.org>
References: <20230320233758.2918972-1-robh@kernel.org>
Message-ID: <3745510.ElGaqSPkdT@phil>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Am Dienstag, 21. M?rz 2023, 00:37:54 CET schrieb Rob Herring:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for bindings/net/can
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Also drop quotes on URLs

>  .../devicetree/bindings/net/rockchip,emac.yaml |  2 +-
>  .../bindings/net/rockchip-dwmac.yaml           |  4 ++--

Reviewed-by: Heiko Stuebner <heiko@sntech.de> #rockchip


