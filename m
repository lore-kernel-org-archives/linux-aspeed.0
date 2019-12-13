From: Rob Herring <robh@kernel.org>
Date: Fri, 13 Dec 2019 16:23:17 -0600
Subject: [PATCH v3 5/6] dt-bindings: mfd: da9062: add regulator gpio
 enable/disable documentation
In-Reply-To: <20191129172537.31410-6-m.felsch@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-6-m.felsch@pengutronix.de>
Message-ID: <20191213222317.GA32740@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2019 18:25:36 +0100, Marco Felsch wrote:
> At the gpio-based regulator enable/disable documentation. This property
> can be applied to each subnode within the 'regulators' node so each
> regulator can be configured differently.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> v3:
> - adapt binding description
> 
>  Documentation/devicetree/bindings/mfd/da9062.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
