From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 17:23:50 +0800
Subject: [PATCH v2 3/3] dts: ast2600: Add reset config for I3C
In-Reply-To: <2a3f5c20-3bfb-c1b8-f9df-d1908022509d@linaro.org>
References: <cover.1676267865.git.jk@codeconstruct.com.au>
	 <f426c3a22d64d076b007a0fc75dc95a389a9387f.1676267865.git.jk@codeconstruct.com.au>
	 <4eed8885-a149-43b1-f6f6-f9b7fbb2f3b4@linaro.org>
	 <40269fdbc75a149a37e8a44f62cb3a6102f61d8a.camel@codeconstruct.com.au>
	 <2a3f5c20-3bfb-c1b8-f9df-d1908022509d@linaro.org>
Message-ID: <34b2ebb4781c6157496012efce392743e1821c8a.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

> There was clk already, wasn't it? What do you want to change?
> I asked why do you call it in the same patchset aspeed and as2600?

There was "clk" and "dts", where the latter should have probably been either
also "clk" or "dt-bindings".

I'll unify the "aspeed" to "ast2600".

Cheers,


Jeremy
