From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 29 Jun 2018 14:11:15 +1000
Subject: [PATCH v4 0/4] gpio: aspeed: Fixes and support for sharing with
 co-processor
Message-ID: <20180629041119.5132-1-benh@kernel.crashing.org>
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
v4: - Document the reason for including gpiolob.h
    - Expose GPIO offsets & bit number so coprocessor firmware doesn't
      have to hard-code them (allows multi-system generic firwmare
      that gets "configure" by the copro driver)

Please consider putting this in a topic branch so I can pull it
back into dependent series and point the reviewers to dependencies


