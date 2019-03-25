From: Joel Stanley <joel@jms.id.au>
Date: Tue, 26 Mar 2019 00:01:57 +1030
Subject: [PATCH v2 0/2] rtc: Add ASPEED RTC driver
Message-ID: <20190325133159.10653-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I finally found some time to send a v2 for this one. Thanks Alexandre
for the review back in October.

v2: Address review from Alexandre

Joel Stanley (2):
  dt-bindings: rtc: Add on-chip ASPEED RTC documentation
  rtc: Add ASPEED RTC driver

 .../devicetree/bindings/rtc/rtc-aspeed.txt    |  19 +++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-aspeed.c                      | 152 ++++++++++++++++++
 4 files changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
 create mode 100644 drivers/rtc/rtc-aspeed.c

-- 
2.20.1

