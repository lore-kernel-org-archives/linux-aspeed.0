From: Joel Stanley <joel@jms.id.au>
Date: Wed, 27 Mar 2019 11:32:13 +1030
Subject: [PATCH v3 0/2] rtc: Add ASPEED RTC driver
Message-ID: <20190327010215.10231-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v3: Remove unnecessary locking, use ptR
v2: Address review from Alexandre

Joel Stanley (2):
  dt-bindings: rtc: Add on-chip ASPEED RTC documentation
  rtc: Add ASPEED RTC driver

 .../devicetree/bindings/rtc/rtc-aspeed.txt    |  22 +++
 drivers/rtc/Kconfig                           |  11 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-aspeed.c                      | 138 ++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
 create mode 100644 drivers/rtc/rtc-aspeed.c

-- 
2.20.1

