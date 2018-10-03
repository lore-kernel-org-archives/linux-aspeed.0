From: Joel Stanley <joel@jms.id.au>
Date: Wed,  3 Oct 2018 15:31:53 +0200
Subject: [PATCH 0/2] rtc: Add ASPEED RTC
Message-ID: <20181003133155.27494-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds support for the ASPEED RTC hardware.

Joel Stanley (2):
  rtc: Add ASPEED RTC driver
  dt-bindings: rtc: Add ASPEED description

 .../devicetree/bindings/rtc/rtc-aspeed.txt    |  18 +++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-aspeed.c                      | 142 ++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
 create mode 100644 drivers/rtc/rtc-aspeed.c

-- 
2.17.1

