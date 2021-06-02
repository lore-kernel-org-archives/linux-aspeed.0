From: Matt Johnston <matt@codeconstruct.com.au>
Date: Wed,  2 Jun 2021 12:41:10 +0800
Subject: [RFC PATCH 0/3] Increase SMBus max block size to 255
Message-ID: <20210602044113.1581347-1-matt@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series increases the SMBus max block size from 32 to 255
as per the SMBus 3.0 specification.

Userspace remains backwards compatible with the current 32 byte block
for the I2C_SMBUS ioctl, and the block size limit remains for I2C_RDWR
ioctl with I2C_M_RECV_LEN.

It is separated into patches 1 & 2 though the userspace API isn't
correct with only the first patch - maybe they should be squashed. The
stack buffers in i2c_smbus_xfer_emulated() increase from ~70 bytes to
~500 bytes - I'm not sure if that is a problem.

I have tested with the Aspeed I2C controller, other drivers can add the
functionality as needed. For most emulated drivers it looks like minimal
changes are required.

This is required for MCTP I2C transport which has a 64 byte baseline
packet size.

Cheers,
Matt

Matt Johnston (3):
  i2c: core: Allow 255 byte transfers for SMBus 3.x
  i2c: dev: Handle 255 byte blocks for i2c ioctl
  i2c: aspeed: allow 255 byte block transfers

 drivers/i2c/busses/i2c-aspeed.c |  5 +-
 drivers/i2c/i2c-core-smbus.c    | 20 ++++---
 drivers/i2c/i2c-dev.c           | 92 ++++++++++++++++++++++++++++-----
 include/linux/i2c.h             | 13 +++++
 include/uapi/linux/i2c-dev.h    |  2 +
 include/uapi/linux/i2c.h        |  7 ++-
 6 files changed, 115 insertions(+), 24 deletions(-)

-- 
2.30.2

