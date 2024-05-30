From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 30 May 2024 10:21:15 +0930
Subject: [PATCH 2/4] dt-bindings: gpio: aspeed,sgpio: Specify
 gpio-line-names
In-Reply-To: <5d0016f1-ccdc-4645-9840-6f8c2870ef6c@kernel.org>
References: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
	 <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-2-91c42976833b@codeconstruct.com.au>
	 <5d0016f1-ccdc-4645-9840-6f8c2870ef6c@kernel.org>
Message-ID: <91f9d528649b967e7499f1e85b83da03b8a0f5d0.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-05-29 at 09:27 +0200, Krzysztof Kozlowski wrote:
> On 29/05/2024 07:13, Andrew Jeffery wrote:
> > Some devicetrees specify gpio-line-names in the sgpio node despite it
> > not being defined by the binding. It's a reasonable thing to do, so
> > define the property to squash warnings such as:
> > 
> > ```
> 
> No need for ```
> 
> This is just commit log. Not markdown.

I'm going to do a v2 anyway, so I'll drop the markup.

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks,

Andrew
