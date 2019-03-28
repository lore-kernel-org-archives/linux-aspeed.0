From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Mar 2019 10:48:30 +1030
Subject: [RFC linux 0/2] rtc: aspeed: Add alarm support
Message-ID: <20190328001832.11076-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These are some work in progress patches to add alarm support on top of
the recently upstreamed RTC driver.

TODO:
 - Make rtctest pass. The select() tests fail currently
 - Add locking to the alarm callbacks

Joel Stanley (2):
  rtc: aspeed: Add locking when touching registers
  rtc: aspeed: Add alarm support

 drivers/rtc/rtc-aspeed.c | 109 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

-- 
2.20.1

