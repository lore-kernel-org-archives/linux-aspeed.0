From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 24 Mar 2022 17:59:15 +0100
Subject: [PATCH 0/3] Documentation/ABI/testing: Sphinx warning fixes
Message-ID: <20220324165918.22005-1-hdegoede@redhat.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,

After Stephen reported some Sphinx warnings for the platform-drivers-x86,
I had to first figure out how to reproduce these. It turns out that to
regenerate the htmldocs for Documentation/ABI/testing one has to run:

touch Documentation/admin-guide/abi-testing.rst && make htmldocs

This turned up not only warnings from platform/x86 driver ABI but also
for some others. While at it I've written fixes for those too.

I'm not sure how these should be merged, I guess that the relevant
subsys maintainers will pick these up?

Regards,

Hans
   

Hans de Goede (3):
  Documentation/ABI: sysfs-driver-aspeed-uart-routing: Fix sphinx
    warning
  Documentation/ABI: sysfs-class-thermal: Fix Sphinx warning
  Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors

 Documentation/ABI/testing/sysfs-class-thermal              | 2 +-
 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing | 7 ++++---
 Documentation/ABI/testing/sysfs-fs-erofs                   | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.35.1

