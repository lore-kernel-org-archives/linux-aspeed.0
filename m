From: Joel Stanley <joel@jms.id.au>
Date: Thu,  3 Feb 2022 22:23:41 +1030
Subject: [PATCH v2 0/3] firmware: Add boot information to sysfs
Message-ID: <20220203115344.267159-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v2 reworks the series to put the sysfs properties in the core, and
optionally show them with the is_visible() callback.

This is the second iteration of this idea. The first used socinfo
custom attribute groups, but Arnd suggested we make this something
standardised under /sys/firmware instead:

 http://lore.kernel.org/all/CAK8P3a3MRf0aGt1drkgsuZyBbeoy+S7Ha18SBM01q+3f33oL+Q at mail.gmail.com

Some ARM systems have a firmware that provides a hardware root of
trust. It's useful for the system to know how this root of trust has
been configured, so provide a standardised interface that expose this
information to userspace.

This is implemented as a sysfs attribute group registration in the
driver core, with platforms populating values obtained from firmware at
kernel boot time.

Patch 2 provides a user of the properties on an ARM system.

Patch 3 is new in v2 and is an example of populating bootinfo with the
EFI secure boot status.

Joel Stanley (3):
  firmware: Add boot information to sysfs
  ARM: aspeed: Add secure boot controller support
  x86/setup: Populate bootinfo with secure boot status

 .../ABI/testing/sysfs-firmware-bootinfo       | 43 +++++++++
 arch/x86/kernel/setup.c                       |  6 ++
 drivers/base/firmware.c                       | 90 +++++++++++++++++++
 drivers/soc/aspeed/aspeed-socinfo.c           | 46 +++++++++-
 include/linux/firmware_bootinfo.h             | 22 +++++
 5 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
 create mode 100644 include/linux/firmware_bootinfo.h

-- 
2.34.1

