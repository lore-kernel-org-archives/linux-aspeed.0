From: Zhu Wang <wangzhu9@huawei.com>
Date: Tue, 8 Aug 2023 19:52:08 +0800
Subject: [PATCH -next 0/5] rtc: remove redundant of_match_ptr()
Message-ID: <20230808115213.154377-1-wangzhu9@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr().

Zhu Wang (5):
  rtc: aspeed: remove redundant of_match_ptr()
  rtc: at91sam9: remove redundant of_match_ptr()
  rtc: nct3018y: remove redundant of_match_ptr()
  rtc: armada38x: remove redundant of_match_ptr()
  rtc: at91rm9200: remove redundant of_match_ptr()

 drivers/rtc/rtc-armada38x.c  | 4 +---
 drivers/rtc/rtc-aspeed.c     | 2 +-
 drivers/rtc/rtc-at91rm9200.c | 2 +-
 drivers/rtc/rtc-at91sam9.c   | 2 +-
 drivers/rtc/rtc-nct3018y.c   | 2 +-
 5 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.17.1

