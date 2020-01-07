From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Mon,  6 Jan 2020 17:15:00 -0800
Subject: [PATCH 0/3] Add AST2600 Video Engine support
Message-ID: <20200107011503.17435-1-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Video engine in AST2600 has the exactly same register set with
AST2500 except VR084 register which provides more precise JPEG
size read back. This patch set adds Video Engine node and driver
support for AST2600.

Please review it.

Thanks,

Jae

Jae Hyun Yoo (3):
  ARM: dts: aspeed-g6: Add Video Engine node
  Documentation: dt-bindings: media: add AST2600 Video Engine support
  media: aspeed: add AST2600 support

 .../devicetree/bindings/media/aspeed-video.txt    |  5 +++--
 arch/arm/boot/dts/aspeed-g6.dtsi                  | 10 ++++++++++
 drivers/media/platform/aspeed-video.c             | 15 +++++++++++----
 3 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.17.1

