From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 13 Feb 2023 10:06:53 +0100
Subject: [PATCH v2 3/3] dts: ast2600: Add reset config for I3C
In-Reply-To: <40269fdbc75a149a37e8a44f62cb3a6102f61d8a.camel@codeconstruct.com.au>
References: <cover.1676267865.git.jk@codeconstruct.com.au>
 <f426c3a22d64d076b007a0fc75dc95a389a9387f.1676267865.git.jk@codeconstruct.com.au>
 <4eed8885-a149-43b1-f6f6-f9b7fbb2f3b4@linaro.org>
 <40269fdbc75a149a37e8a44f62cb3a6102f61d8a.camel@codeconstruct.com.au>
Message-ID: <2a3f5c20-3bfb-c1b8-f9df-d1908022509d@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 13/02/2023 10:02, Jeremy Kerr wrote:
> Hi Krzysztof,
> 
>> 2. This is not DTS. There is nothing from DTS here.
> 
> [and from, your reply on patch 2/3:]
> 
>> Why do you use subject prefix in patch 1 different than in patch 2?
> 
> Ack, will change to "clk:"; there is quite a mix of "dt-bindings:" and
> "clk:" on the changes within this dir. I'll unify across the series.
> 

There was clk already, wasn't it? What do you want to change? I asked
why do you call it in the same patchset aspeed and as2600?

Best regards,
Krzysztof

