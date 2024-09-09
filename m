From: Zhang Zekun <zhangzekun11@huawei.com>
Date: Mon, 9 Sep 2024 20:29:17 +0800
Subject: [PATCH 0/4] Simplify code with dev_err_probe()
Message-ID: <20240909122921.12627-1-zhangzekun11@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use dev_err_probe() to simplify code, and we can avoid judging
if the error code is not equal to -EPROBE_DEFER

Zhang Zekun (4):
  soc: qcom: rpmh-rsc: Simplify code with dev_err_probe()
  soc: aspeed: Simplify code with dev_err_probe()
  soc: qcom: smem: Simplify code with dev_err_probe()
  soc: qcom: smp2p: Simplify code with dev_err_probe()

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 10 ++++------
 drivers/soc/qcom/rpmh-rsc.c           |  9 +++------
 drivers/soc/qcom/smem.c               |  8 +++-----
 drivers/soc/qcom/smp2p.c              |  9 +++------
 4 files changed, 13 insertions(+), 23 deletions(-)

-- 
2.17.1

