From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Jul 2018 15:05:14 +1000
Subject: [PATCH 0/5] fsi: Convert misc devs to proper chardevs and more
Message-ID: <20180724050519.31920-1-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This converts the various FSI devices from misc dev to chardev,
as there can potentially be too much of them for misc devs limited
minors, and because there are some lifetime issues with the current
support.

This provide a common infrastructure to allocate an FSI major and
distribute minors in a way that keeps it compatible with existing
userspace. A new representation grouping FSI devices under a
/dev/fsi directory is optinally provided, which will work in
conjunction with new udev scripts aimed at providing fixed ID
based symlinks.

A side effect of those conversions is to fix some object lifetime
issues caused by a mixup between devm_kzalloc and proper object
lifetime.

This series also adds a /dev{/fsi}/cfamN chardev for raw CFAM
access that will superseed the existing "raw" sysfs file.

Finally there's also a locking fix to avoid horrible mixups if
the "rescan" file is poked while a rescan is already in progress.


