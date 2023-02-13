From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 10:35:17 +0100
Subject: [RFC PATCH] dt-bindings: Add AST2600 i3c controller binding
In-Reply-To: <80fa21969d9e0e7a123bd525199dbb40e79d47e3.camel@codeconstruct.com.au>
References: <5c047dd91390b9ee4cd8bca3ff107db37a7be4ac.1676273912.git.jk@codeconstruct.com.au>
 <7c6741e1-ae41-ba20-b859-736214c680e8@linaro.org>
 <91e9e815bed8c2eff19dbe6b3ed36d10c6edcbfd.camel@codeconstruct.com.au>
 <929a30fc-35f3-ab21-3a16-936ed69d5505@linaro.org>
 <80fa21969d9e0e7a123bd525199dbb40e79d47e3.camel@codeconstruct.com.au>
Message-ID: <71aeb3da-13a1-1c79-9fe6-f5c23d398394@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 10:21, Jeremy Kerr wrote:
> Hi Krzysztof,
> 
>> You should clearly communicate that driver is coming...
> 
> OK.
> 
>> Anyway binding comes with the driver, otherwise how can we check that
>> you actually implemented it?
> 
> I'll include this with the driver once we're past the RFC reviews.
> 
>> Please send patches, not RFC. RFC means you are uncertain this is even
>> correct and you ask for generic discussion.
> 
> Yes, that's essentially what I'm looking for with this change -
> particularly with the pullup config, which (as you say) could arguably
> be a pinctrl config instead.

Depends, there was just a short sentence. If this is external resistor
on the board, why this device needs such property (and none of other
devices need...)? If this is internal pull up of I3C (and there is no
other pin configuration possible, no other pins), it looks reasonable to
me to have it here. But I am all guessing it...


Best regards,
Krzysztof

