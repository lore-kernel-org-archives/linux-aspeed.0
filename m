From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 12 Jun 2018 10:10:39 +1000
Subject: [PATCH 0/4] gpio: aspeed: Fixes and support for sharing with
 co-processor
Message-ID: <20180612001043.9327-1-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series cleans up the register accessors a bit, adds missing ones,
fixes the access to the write latch and finally adds an interface
that a co-processor driver can use to change the owner of some of
the GPIO lines and arbitrate access to shared GPIO banks.


