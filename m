From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 30 May 2024 10:22:29 +0930
Subject: [PATCH 3/4] dt-bindings: gpio: aspeed,sgpio: Specify
 #interrupt-cells
In-Reply-To: <e40041ef-fb1e-4348-97b5-64487859a7f9@kernel.org>
References: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
	 <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-3-91c42976833b@codeconstruct.com.au>
	 <e40041ef-fb1e-4348-97b5-64487859a7f9@kernel.org>
Message-ID: <032b986258c92b6d400b2514cc018b8622ecf355.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-05-29 at 09:28 +0200, Krzysztof Kozlowski wrote:
> On 29/05/2024 07:13, Andrew Jeffery wrote:
> > Squash warnings such as:
> > 
> > ```
> > /home/andrew/src/kernel.org/linux/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: sgpio at 1e780200: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Please trim the log from unnecessary path components.

Ack.
