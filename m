From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 21 Jul 2022 08:30:23 +0200
Subject: [PATCH 1/7] dt-bindings: vendor-prefixes: document several
 vendors for Aspeed BMC boards
In-Reply-To: <42fb4884-e2c3-4d7f-9049-f14c19701b20@www.fastmail.com>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <c86be8e0-8350-5d73-8055-e04a4e88f3b6@linaro.org>
 <42fb4884-e2c3-4d7f-9049-f14c19701b20@www.fastmail.com>
Message-ID: <fb1b5eed-41ed-2c4b-c984-235ec4b3b0f6@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/07/2022 04:34, Andrew Jeffery wrote:
>> Any comments on this patchset? Are you going to pick it up? If you
>> prefer me taking it, I can, but new boards depend on the bindings, so
>> this should rather go via your tree.
> 
> Apologies for not getting to this earlier, but I see Rob's applied it.

Rob took only the first patch - vendor-prefix. The DTS patches I sent to
arm-soc.

However the second bindings patch [1] will miss merge window as I did
not send it to arm-soc. I have it in my tree but I am not planning to
push it out before merge window.

[1]
https://lore.kernel.org/all/165589284658.28441.1588047978357747292.b4-ty at linaro.org/


Best regards,
Krzysztof
