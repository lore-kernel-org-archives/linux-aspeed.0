From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 29 May 2024 09:28:27 +0200
Subject: [PATCH 3/4] dt-bindings: gpio: aspeed,sgpio: Specify
 #interrupt-cells
In-Reply-To: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-3-91c42976833b@codeconstruct.com.au>
References: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
 <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-3-91c42976833b@codeconstruct.com.au>
Message-ID: <e40041ef-fb1e-4348-97b5-64487859a7f9@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/05/2024 07:13, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> /home/andrew/src/kernel.org/linux/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: sgpio at 1e780200: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'

Please trim the log from unnecessary path components.

Best regards,
Krzysztof

