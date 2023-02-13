From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 10:31:23 +0100
Subject: [PATCH v2 3/3] dts: ast2600: Add reset config for I3C
In-Reply-To: <34b2ebb4781c6157496012efce392743e1821c8a.camel@codeconstruct.com.au>
References: <cover.1676267865.git.jk@codeconstruct.com.au>
 <f426c3a22d64d076b007a0fc75dc95a389a9387f.1676267865.git.jk@codeconstruct.com.au>
 <4eed8885-a149-43b1-f6f6-f9b7fbb2f3b4@linaro.org>
 <40269fdbc75a149a37e8a44f62cb3a6102f61d8a.camel@codeconstruct.com.au>
 <2a3f5c20-3bfb-c1b8-f9df-d1908022509d@linaro.org>
 <34b2ebb4781c6157496012efce392743e1821c8a.camel@codeconstruct.com.au>
Message-ID: <1ab0b28d-8935-4e4c-ba8a-635de1f5bb8d@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 10:23, Jeremy Kerr wrote:
> Hi Krzysztof,
> 
>> There was clk already, wasn't it? What do you want to change?
>> I asked why do you call it in the same patchset aspeed and as2600?
> 
> There was "clk" and "dts",

In patch 1 and 2? Please point me.

> where the latter should have probably been either
> also "clk" or "dt-bindings".

Aren't you referring to some other comment now?

> 
> I'll unify the "aspeed" to "ast2600".
> 
> Cheers,
> 
> 
> Jeremy

Best regards,
Krzysztof

