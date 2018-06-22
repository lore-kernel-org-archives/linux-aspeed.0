From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Jun 2018 12:04:44 +1000
Subject: [PATCH v3 0/4] gpio: aspeed: Fixes and support for sharing with
 co-processor
Message-ID: <20180622020448.6102-1-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series cleans up the register accessors a bit, adds missing ones,
fixes the access to the write latch and finally adds an interface
that a co-processor driver can use to change the owner of some of
the GPIO lines and arbitrate access to shared GPIO banks.

v2: - Address Joel comments
v3: - Adds Reviewed-by tags

NOTE: I haven't changed the inclusion of gpio/consumer.h and gpiolib.h
      as, according to my replies, I do actually need them. I'm happy
      to use an alternative if somebody can suggest a reasonable one.


