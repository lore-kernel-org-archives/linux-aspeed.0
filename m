From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Jun 2018 16:33:18 +1000
Subject: [PATCH v3 4/4] gpio: aspeed: Add interfaces for co-processor to
 grab GPIOs
In-Reply-To: <20180622020448.6102-5-benh@kernel.crashing.org>
References: <20180622020448.6102-1-benh@kernel.crashing.org>
 <20180622020448.6102-5-benh@kernel.crashing.org>
Message-ID: <c8a71b3f23b2039fa1a7b28d5f1f91cb6c6870f8.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2018-06-22 at 12:04 +1000, Benjamin Herrenschmidt wrote:
> On the Aspeed chip, the GPIOs can be under control of the ARM
> chip or of the ColdFire coprocessor. (There's a third command
> source, the LPC bus, which we don't use or support yet).

At the risk of offending people even more, I'm going to respin
this with another extra Aspeed specific interface to retrieve
a given GPIO registers and bit number.

So far, I've made the corprocessor code system specific, effectively
hard wiring in the binary the above. But I found a way to make it
more flexible without losing too much performance, thus drastically
simplifying deployment for us since every machine out there seems
to be wiring these things differently.

However, for that to work, after "grabbing" the GPIOs, the coprocessor
driver will need to give the data and write data latch registers and
bit numbers to the microcode.

I'll respin a v4 with that added interface in the form of a separate
patch at the end of the series.

Cheers,
Ben.
