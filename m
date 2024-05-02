From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 02 May 2024 19:10:19 +0800
Subject: [PATCH] ARM: dts: aspeed-g6: Add nodes for i3c controllers
In-Reply-To: <c5331cf8-7295-4e6a-ba39-e0751a2c357e@kernel.org>
References: <20240501033832.1529340-1-jk@codeconstruct.com.au>
	 <65af46c3-e48f-4eae-8390-2bc01332ccbf@kernel.org>
	 <09ed10182e2282d7e408a4fef7994da010fe058e.camel@codeconstruct.com.au>
	 <c5331cf8-7295-4e6a-ba39-e0751a2c357e@kernel.org>
Message-ID: <f14b79f4771a4216be6eb2de4352f9f1dda0eafc.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Krysztof,

> Your first node is empty and that is not readable.

I'd argue that separating the i3c definitions makes the source more
readable (granted, at the cognitive expense of having to dereference a
label), but ok.

I'll send a v2 with the bus definitions inline, but first reworking the
existing i2c definitions to use the same format.

Cheers,


Jeremy
