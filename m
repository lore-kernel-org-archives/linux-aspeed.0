From: Joel Stanley <joel@jms.id.au>
Date: Tue,  1 Feb 2022 15:34:59 +1030
Subject: [PATCH 0/2] firmware: Add boot information to sysfs
Message-ID: <20220201050501.182961-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is the second iteration of this idea. The first used socinfo
custom attribute groups, but Arnd suggested we make this something
standardised under /sys/firmware instead:

 http://lore.kernel.org/all/CAK8P3a3MRf0aGt1drkgsuZyBbeoy+S7Ha18SBM01q+3f33oL+Q at mail.gmail.com

Some ARM systems have a firmware that provides a hardware root of
trust. It's useful for the system to know how this root of trust has
been configured, so provide a standardised interface that expose this
information to userspace.

This is implemented as a sysfs attribute group registration to be called
at boot, with the properties described in the ABI document.

Alternatively we could put the properties in the driver core, and have
platforms register callbacks for each supported property. This would
make it harder to insert non-standard properties, with the trade off of
more code to selectively show supported properties.

An user of the properties is provided in the second patch.

Joel Stanley (2):
  firmware: Add boot information sysfs
  ARM: aspeed: Add secure boot controller support

 .../ABI/testing/sysfs-firmware-bootinfo       | 43 ++++++++++
 drivers/base/firmware.c                       | 14 ++++
 drivers/soc/aspeed/aspeed-socinfo.c           | 84 ++++++++++++++++++-
 include/linux/firmware_bootinfo.h             |  8 ++
 4 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
 create mode 100644 include/linux/firmware_bootinfo.h

-- 
2.34.1

