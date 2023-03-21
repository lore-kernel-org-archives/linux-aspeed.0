From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
Date: Tue, 21 Mar 2023 20:45:48 +0000
Subject: [PATCH v2] dt-bindings: net: Drop unneeded quotes
In-Reply-To: <20230320233758.2918972-1-robh@kernel.org>
References: <20230320233758.2918972-1-robh@kernel.org>
Message-ID: <TYWPR01MB9420194A9C7EA41A70CF8DA892819@TYWPR01MB9420.jpnprd01.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, March 21, 2023 8:38 AM
> To: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Andreas F?rber <afaerber@suse.de>;
> Manivannan Sadhasivam <mani@kernel.org>; Chen-Yu Tsai
> <wens@csie.org>; Jernej Skrabec <jernej.skrabec@gmail.com>; Samuel
> Holland <samuel@sholland.org>; Neil Armstrong
> <neil.armstrong@linaro.org>; Kevin Hilman <khilman@baylibre.com>; Jerome
> Brunet <jbrunet@baylibre.com>; Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>; Joel Stanley <joel@jms.id.au>;
> Andrew Jeffery <andrew@aj.id.au>; Rafa? Mi?ecki <rafal@milecki.pl>;
> Broadcom internal kernel review list
> <bcm-kernel-feedback-list@broadcom.com>; Florian Fainelli
> <f.fainelli@gmail.com>; Appana Durga Kedareswara rao
> <appana.durga.rao@xilinx.com>; Naga Sureshkumar Relli
> <naga.sureshkumar.relli@xilinx.com>; Wolfgang Grandegger
> <wg@grandegger.com>; Marc Kleine-Budde <mkl@pengutronix.de>; Michal
> Simek <michal.simek@xilinx.com>; Andrew Lunn <andrew@lunn.ch>;
> Vladimir Oltean <olteanv@gmail.com>; Heiner Kallweit
> <hkallweit1@gmail.com>; Russell King <linux@armlinux.org.uk>; Tobias
> Waldekranz <tobias@waldekranz.com>; Lars Povlsen
> <lars.povlsen@microchip.com>; Steen Hegelund
> <Steen.Hegelund@microchip.com>; Daniel Machon
> <daniel.machon@microchip.com>; UNGLinuxDriver at microchip.com; Andy
> Gross <agross@kernel.org>; Bjorn Andersson <andersson@kernel.org>;
> Konrad Dybcio <konrad.dybcio@linaro.org>; Heiko Stuebner
> <heiko@sntech.de>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> Alexandre Torgue <alexandre.torgue@foss.st.com>; iwamatsu nobuhiro(??
> ?? ????????) <nobuhiro1.iwamatsu@toshiba.co.jp>; Richard
> Cochran <richardcochran@gmail.com>; Matthias Brugger
> <matthias.bgg@gmail.com>; AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
> netdev at vger.kernel.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-actions at lists.infradead.org;
> linux-kernel at vger.kernel.org; linux-sunxi at lists.linux.dev;
> linux-amlogic at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-can at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> linux-rockchip at lists.infradead.org;
> linux-stm32 at st-md-mailman.stormreply.com;
> linux-mediatek at lists.infradead.org
> Subject: [PATCH v2] dt-bindings: net: Drop unneeded quotes
> 
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
> ---

[snip]

>  .../bindings/net/toshiba,visconti-dwmac.yaml   |  4 ++--

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp> # for bindings/net/toshiba,visconti-dwmac.yaml

Best regards,
  Nobuhiro
