From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 29 Feb 2024 13:51:45 +1030
Subject: [PATCH v6] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to
 DT schema
In-Reply-To: <c2060450-4b76-4740-afe4-d14717245f01@linaro.org>
References: <20240228003043.1167394-1-andrew@codeconstruct.com.au>
	 <c2060450-4b76-4740-afe4-d14717245f01@linaro.org>
Message-ID: <16ddd99007176da3f84462de217cb76c8fa4e1bd.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-02-28 at 08:47 +0100, Krzysztof Kozlowski wrote:
> On 28/02/2024 01:30, Andrew Jeffery wrote:
> > Squash warnings such as:
> > 
> > ```
> > arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/gpio at 1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
> > ```
> > 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> > v6: Address more constraint feedback from Krzysztof:
> >     https://lore.kernel.org/all/f69ef2ad-8ace-40c8-b923-4dde20eda2ec at linaro.org/
> 
> You still have way too many examples. One is enough, two is still okay.
> We really do not want more of examples with minor differences.

Noted, I'll keep them to a minimum in the future.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for the feedback.

Andrew

