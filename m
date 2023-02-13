From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 10:05:26 +0100
Subject: [RFC PATCH] dt-bindings: Add AST2600 i3c controller binding
In-Reply-To: <91e9e815bed8c2eff19dbe6b3ed36d10c6edcbfd.camel@codeconstruct.com.au>
References: <5c047dd91390b9ee4cd8bca3ff107db37a7be4ac.1676273912.git.jk@codeconstruct.com.au>
 <7c6741e1-ae41-ba20-b859-736214c680e8@linaro.org>
 <91e9e815bed8c2eff19dbe6b3ed36d10c6edcbfd.camel@codeconstruct.com.au>
Message-ID: <929a30fc-35f3-ab21-3a16-936ed69d5505@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 09:55, Jeremy Kerr wrote:
>> 4. Where is the driver? Where is the DTS? Why do we want unused
>> binding in the kernel?
> 
> The driver is coming next, but I wanted to sort out the structure of the
> binding before committing to how the driver consumes the DT data - hence
> the RFC.

You should clearly communicate that driver is coming... Anyway binding
comes with the driver, otherwise how can we check that you actually
implemented it? Please send patches, not RFC. RFC means you are
uncertain this is even correct and you ask for generic discussion. So
generic discussion comment - implement how other recent i3c bindings are
implemented. This is basic device, there is nothing special here.

Since you did not respond to rest of comments, I assume you are going to
implement them fully - including dropping the questioned properties.

Best regards,
Krzysztof

